------------------::::::::::::::::::::::  PROCEDURES  ::::::::::::::::::::::------------------

----------------------------------------  AMB DE ROL  ----------------------------------------

-- 1) 

-- Funcionalidad para poder crear, modificar y eliminar el acceso de un usuario a una opción del sistema. 

IF OBJECT_ID('LIL_MIX.crearRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.crearRol

-- Crear un rol implica cargar los siguientes datos: Nombre y Listado de Funcionalidades (selección acotada) 
 
CREATE PROCEDURE LIL_MIX.crearRol 
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @rol_nombre IN (SELECT rol_nombre FROM LIL_MIX.rol)
				THROW 50004, 'Rol existente', 1

			IF @funcionalidad_descripcion NOT IN (SELECT funcionalidad_descripcion FROM LIL_MIX.funcionalidad)
				THROW 50005, 'Funcionalidad inexistente', 1
			
			INSERT INTO LIL_MIX.rol (rol_nombre, rol_habilitado)
			VALUES (@rol_nombre, 1)

			INSERT INTO LIL_MIX.funcionalidadxrol (rol_id, funcionalidad_id)
			VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
				(SELECT funcionalidad_id FROM LIL_MIX.funcionalidad 
				WHERE funcionalidad_descripcion = @funcionalidad_descripcion))
		
		COMMIT
		
	END TRY

	BEGIN CATCH
		ROLLBACK

	END CATCH
END 

--2) SECCIÓN DE MODIFICACIÓN DEL ROL

-- 2.1) Modificar nombre

IF OBJECT_ID('LIL_MIX.modificarRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarRol

-- En la modificación de un rol solo se pueden alterar ambos campos: el nombre y el listado de funcionalidades. 

CREATE PROCEDURE LIL_MIX.modificarRolNombre
@rol_nombre VARCHAR(30), @rol_nombre_nuevo VARCHAR(30)
AS
BEGIN
	UPDATE LIL_MIX.rol
	SET rol_nombre = rol_nombre_nuevo
	WHERE rol_nombre = @rol_nombre
END

--Se deben poder quitar de a una las funcionalidades como así  también agregar nuevas funcionalidades a rol que 
--se está modificando

-- 2.2) Agregar funcionalidad

CREATE PROCEDURE LIL_MIX.modificarRolAgregarFuncionalidad
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @funcionalidad_descripcion NOT IN (SELECT funcionalidad_descripcion FROM LIL_MIX.funcionalidad)
				THROW 51002, 'No existe funcionalidad.', 1

			INSERT INTO LIL_MIX.funcionalidadxrol (rol_id, funcionalidad_id)
			VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre),
				(SELECT funcionalidad_id FROM LIL_MIXfuncionalidad 
			WHERE funcionalidad_descripcion = @funcionalidad_descripcion))

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

-- 2.3) Eliminar funcionalidad

CREATE PROCEDURE LIL_MIX.modificarRolEliminarFuncionalidad
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
			DECLARE @funcid INT,
				@rolid INT
			
			SELECT @funcid = funcionalidad_id FROM LIL_MIX.funcionalidad
			WHERE funcionalidad_descripcion = @funcionalidad_descripcion
			
			SELECT @rolid = rol_id FROM LIL_MIX.rol
			WHERE rol_nombre = @rol_nombre
			
			IF @funcid NOT IN (SELECT funcionalidad_id FROM LIL_MIX.funcionalidadxrol WHERE rol_id = @rolid)
				THROW 51002, 'No existe esa funcionalidad en este rol.', 1

			DELETE FROM LIL_MIX.funcionalidadxrol 
			WHERE funcionalidad_id = @funcid AND rol_id = @rolid
			
		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END

-- 2.4) Habilitar un rol

IF OBJECT_ID('LIL_MIX.habilitarRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.habilitarRol

--Se debe poder volver a habilitar un rol inhabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.habilitarRol
@rol_nombre VARCHAR(30)
AS
BEGIN
	UPDATE LIL_MIX.rol
	SET rol_habilitado = 1
	WHERE rol_nombre = @rol_nombre

END

--3) 

IF OBJECT_ID('LIL_MIX.eliminarRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.eliminarRol

-- La eliminación del rol implica una baja lógica del mismo. El rol debe poder inhabilitarse.

CREATE PROCEDURE LIL_MIX.eliminarRol
@rol_nombre VARCHAR(30)
AS
BEGIN

	UPDATE LIL_MIX.rol
	SET rol_habilitado = 0
	WHERE rol_nombre = @rol_nombre

END

----------------------------------------  LOGIN Y SEGURIDAD  ----------------------------------------

-- 4)

-- Al ejecutar la aplicación el usuario no podrá acceder a ninguna funcionalidad del sistema hasta 
-- completar el proceso de Login. 

CREATE PROCEDURE LIL_MIX.login
@usuario VARCHAR(255), @password_ingresada VARCHAR(255) 
AS
BEGIN
	DECLARE @password_del_usuario varchar(255),
		@password_encriptada nvarchar(255),
		@intentos tinyint,
		@usuario_habilitado bit

	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario)
	BEGIN
		RAISERROR('El usuario ingresado no existe.', 16, 1)
		RETURN
	END

	SELECT @password_del_usuario = usuario_password, @usuario_habilitado = usuario_habilitado
	FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario

	IF @usuario_habilitado = 0 
	BEGIN
		RAISERROR('El usuario ha sido inhabilitado. Por favor, contáctese con un administrador.', 16, 1)
		RETURN
	END

	SELECT @password_encriptada = HASHBYTES('SHA2_256', @password_ingresada)

	IF @password_del_usuario != @password_encriptada
	BEGIN
		RAISERROR('Contraseña incorrecta.', 16, 1)
		
		-- El sistema debe llevar un registro de cantidad intentos fallidos de login. 

		UPDATE LIL_MIX.usuario
		SET usuario_intentos = usuario_intentos + 1
		WHERE usuario_nombre = @usuario
		
		SELECT @intentos = usuario_intentos
		FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario

		IF @intentos = 3
		BEGIN
			RAISERROR('Ha ingresado la contraseña 3 veces de forma incorrecta. El usuario será inhabilitado', 16, 1)

			-- Luego de 3 intentos fallidos en cualquier momento, el usuario debe ser inhabilitado.
			
			UPDATE LIL_MIX.usuario
			SET usuario_habilitado = 0
			WHERE usuario_nombre = @usuario

			RETURN
		END
	END
	ELSE
	BEGIN
		-- Al realizar un Login satisfactorio, el sistema deberá limpiar la cantidad de intentos fallidos.
		
		UPDATE LIL_MIX.usuario
		SET usuario_intentos = 0
		WHERE usuario_nombre = @usuario
		
		RETURN
	END
END

------------------------------------  REGISTRO DE USUARIO  -----------------------------------

-- Funcionalidad que se encuentra disponible al momento de loguearse el usuario al sistema. 

-- 5) CREAR USUARIO TIPO CLIENTE

IF OBJECT_ID('LIL_MIX.crearUsuario') IS NOT NULL
  DROP PROCEDURE LIL_MIX.crearUsuarioCliente

CREATE PROCEDURE LIL_MIX.crearUsuarioCliente
@usuario_nombre VARCHAR(255), @usuario_password VARCHAR(255), @rol_nombre VARCHAR(30), -- Datos de usuario
@nombre VARCHAR(255), @apellido VARCHAR(255), @dni INT, @mail VARCHAR(255), @telefono INT, @fechanacimiento DATETIME, 
@codigopostal SMALLINT, @direccion_calle VARCHAR(255), @direccion_piso TINYINT, @direccion_dpto CHAR(1), @ciudad VARCHAR(255) -- Datos de cliente
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		-- DATOS DE USUARIO:
		
		-- El username debe ser único en un todo el sistema.

		IF EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre)

		--La aplicación deberá controlar esta restricción e informar debidamente al usuario.

			THROW 50064, 'Nombre de usuario ya existe, intente con uno distinto.', 1

		IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
			THROW 500065, 'El rol no existe, intente nuevamente.', 1
			
		-- El password deberá almacenarse encriptado de forma irreversible bajo el algoritmo de encriptación SHA256.
	
		INSERT INTO LIL_MIX.usuario (usuario_nombre, usuario_password, usuario_intentos, usuario_habilitado)
		VALUES (@usuario_nombre, HASHBYTES('SHA2_256', @usuario_password), 0, 1)

		INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
		VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))
		
		-- DATOS DE CLIENTE:
			
		-- El alumno deberá determinar un procedimiento para evitar la generación de clientes “gemelos” 
		-- (distinto nombre de usuario, pero igual datos identificatorios según se justifique en la estrategia de resolución).

		IF EXISTS (SELECT * FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_user_id = u.usuario_id)
				 WHERE c.cliente_dni = @dni AND u.usuario_nombre != @usuario_nombre) -- Consideramos dato identificatorio al dni y al mail
			THROW 50008, 'Cliente gemelo. Ya existe cliente con dicho DNI. No puede realizarse la operación.', 1

		IF EXISTS (SELECT * FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_user_id = u.usuario_id)
				 WHERE c.cliente_mail = @mail AND u.usuario_nombre != @usuario_nombre) -- Consideramos dato identificatorio al dni y al mail
			THROW 50008, 'Cliente gemelo. Ya existe cliente con dicho e-mail. No puede realizarse la operación.', 1

		INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
		VALUES (@direccion_calle, @direccion_piso, @direccion_dpto, @ciudad)

		-- Toda creación de cliente nuevo, implica una carga de dinero de bienvenida de $200.

		INSERT INTO LIL_MIX.cliente (cliente_nombre, cliente_apellido, cliente_mail, cliente_telefono, cliente_fecha_nacimiento, 
					cliente_cp, cliente_dni, cliente_credito, cliente_habilitado, cliente_user_id, cliente_direccion_id)
		VALUES (@nombre, @apellido, @mail, @telefono, @fechanacimiento, @codigopostal, @dni, 200, 1, 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre),
			(SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = @direccion_calle AND 
			direccion_piso = @direccion_piso AND direccion_dpto = @direccion_dpto AND direccion_ciudad = @ciudad)) 

		COMMIT
	END TRY

	BEGIN CATCH

		ROLLBACK

	END CATCH
END

-- 6) CREAR USUARIO TIPO PROVEEDOR

CREATE PROCEDURE LIL_MIX.crearUsuarioProveedor
@usuario_nombre VARCHAR(255), @usuario_password VARCHAR(255), @rol_nombre VARCHAR(30), -- Datos de usuario
@nombre_de_usuario VARCHAR(255), @razon_social VARCHAR(255), @mail VARCHAR(255), @telefono INT, @cuit VARCHAR(13), @rubro VARCHAR(255), 
@nombre_contacto VARCHAR(255), @codigo_postal SMALLINT, @calle VARCHAR(255), @piso TINYINT, @dpto CHAR(1), @ciudad VARCHAR(255) -- Datos de proveedor
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		-- DATOS DE USUARIO:
			
		-- El username debe ser único en un todo el sistema.

		IF EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre)

		--La aplicación deberá controlar esta restricción e informar debidamente al usuario.

			THROW 50006, 'Nombre de usuario ya existe, intente con uno distinto.', 1

		IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
			THROW 50007, 'El rol no existe, intente nuevamente.', 1
			
		-- El password deberá almacenarse encriptado de forma irreversible bajo el algoritmo de encriptación SHA256.
	
		INSERT INTO LIL_MIX.usuario (usuario_nombre, usuario_password, usuario_intentos, usuario_habilitado)
		VALUES (@usuario_nombre, HASHBYTES('SHA2_256', @usuario_password), 0, 1)

		INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
		VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))

		-- DATOS DE PROVEEDOR:
		
		INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
		VALUES (@calle, @piso, @dpto, @ciudad)
		
		--La razón social y cuit son datos únicos, por ende no pueden existir 2 proveedores con la misma razón social y cuit
		--El sistema deberá controlar esta restricción e informar debidamente al usuario ante alguna anomalía.

		IF EXISTS (SELECT * FROM LIL_MIX.proveedor WHERE proveedor_rs = @razon_social AND proveedor_cuit = @cuit)
			THROW 50009, 'Combinacion de razón social y CUIT existentes', 1
			
		INSERT INTO LIL_MIX.proveedor (proveedor_telefono, proveedor_cuit, proveedor_rubro, proveedor_mail, proveedor_cp, 
			proveedor_nombre_contacto, proveedor_rs, proveedor_habilitado, proveedor_usuario_id, proveedor_direccion_id)
		VALUES (@telefono, @cuit, @rubro, @mail, @codigo_postal, @nombre_contacto, @razon_social, 1,
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre),
			(SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = @calle AND direccion_piso = @piso AND
				direccion_dpto = @dpto AND direccion_ciudad = @ciudad)
		
		COMMIT
	END TRY

	BEGIN CATCH

		ROLLBACK

	END CATCH
END

-- 7) 

-- A un usuario se le asigna un solo rol, 
-- pero no se descarta que pueda tener más de un rol al mismo tiempo en un futuro no muy lejano. 

CREATE PROCEDURE LIL_MIX.agregarRolAUsuario
@rol_nombre VARCHAR(30), @usuario_nombre VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	
	-- Chequeo existencia del rol
	
	IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
		THROW 50059, 'Rol inexistente.', 1
		
	-- Chequeo existencia del usuario
	
	IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
		THROW 50060, 'Usuario inexistente.', 1
		
	INSERT INTO LIL_MIX.rolxusuario (rol_id, usuario_id)
	VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
		(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))
		
	COMMIT
END TRY

BEGIN CATCH

	ROLLBACK
	
END CATCH

END

-- 8)

-- Debe tenerse en cuenta que se pueda modificar el password. 

IF OBJECT_ID('LIL_MIX.modificarContrasenia') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarContrasenia

CREATE PROCEDURE LIL_MIX.modificarContrasenia
@usuario_nombre VARCHAR(255), @anteriorcontra VARCHAR(255), @nuevacontra VARCHAR(255)
AS
BEGIN

	UPDATE LIL_MIX.usuario
	SET usuario_password = HASHBYTES('SHA2_256', @nuevacontra)
	WHERE usuario_password = HASHBYTES('SHA2_256', @anteriorcontra) AND usuario_nombre = @usuario_nombre

END

-- 9)

--También debe contemplarse de alguna manera, que un administrativo pueda dar de baja un usuario.

IF OBJECT_ID('LIL_MIX.darDeBajaUsuario') IS NOT NULL
  DROP PROCEDURE LIL_MIX.darDeBajaUsuario 

CREATE PROCEDURE LIL_MIX.darDeBajaUsuario
@usuario_nombre VARCHAR(255)
AS
BEGIN

  UPDATE LIL_MIX.usuario
  SET usuario_habilitado = 0
  WHERE usuario_nombre = @usuario_nombre

END

---------------------------------------  AMB DE CLIENTES  ---------------------------------------

-- 10)

-- La eliminación de un cliente implica la baja lógica del mismo. 

IF OBJECT_ID('LIL_MIX.eliminarCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.eliminarCliente

CREATE PROCEDURE LIL_MIX.eliminarCliente
@dni_del_cliente INT
AS
BEGIN

	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 0
	WHERE cliente_dni = @dni_del_cliente

END

-- 11) SECCIÓN DE MODIFICACIÓN DEL CLIENTE

-- 11.1)

-- Se debe poder volver a habilitar el cliente deshabilitado desde la sección de modificación. 

IF OBJECT_ID('LIL_MIX.habilitarCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.habilitarCliente

CREATE PROCEDURE LIL_MIX.habilitarCliente
@usuario_nombre VARCHAR(255)
AS
BEGIN
	DECLARE @usuarioid INT
	
	SELECT @usuarioid = c.cliente_usuario_id
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (u.usuario_id = c.cliente_usuario_id)
	WHERE u.usuario_nombre = @usuario_nombre
	
	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 1
	WHERE cliente_usuario_id = @usuarioid
END

-- Todos los datos mencionados anteriormente son modificables: Nombre, Apellido, DNI, Mail, Teléfono,
-- Dirección calle, nro piso, depto y localidad, Código Postal, Fecha de Nacimiento.

-- 11.2) Modificación de nombre
  
CREATE PROCEDURE LIL_MIX.modificarClienteNombre
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@nombre_nuevo VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_nombre = @nombre_nuevo 
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.3) Modificación de apellido
  
CREATE PROCEDURE LIL_MIX.modificarClienteApellido
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@apellido_nuevo VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_apellido = @apellido_nuevo 
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.4) Modificación de DNI
  
CREATE PROCEDURE LIL_MIX.modificarClienteDNI
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@dni_nuevo INT
AS
BEGIN
BEGIN TRY	
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_dni = @dni_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.5) Modificación de e-mail
  
CREATE PROCEDURE LIL_MIX.modificarClienteMail
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@mail_nuevo VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_mail = @mail_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.6) Modificación de telefono
  
CREATE PROCEDURE LIL_MIX.modificarClienteTelefono
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@telefono_nuevo INT
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_telefono = @telefono_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.7) Modificación de fecha de nacimiento
  
CREATE PROCEDURE LIL_MIX.modificarClienteFechaNacimiento
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@fechanacimiento_nueva DATETIME
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_fecha_nacimiento = @fechanacimiento_nueva
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.8) Modificación de codigo postal
  
CREATE PROCEDURE LIL_MIX.modificarClienteCP
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@codigopostal_nuevo SMALLINT
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_cp = @codigopostal_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.9) Modificación de direccion (calle)
  
CREATE PROCEDURE LIL_MIX.modificarClienteCalleDirec
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@direccion_calle_nuevo VARCHAR(255) 
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_calle = @direccion_calle_nuevo 
	WHERE direccion_id = @direccionid

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.10) Modificación de direccion (numero de piso)
  
CREATE PROCEDURE LIL_MIX.modificarClientePisoDirec
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@direccion_piso_nuevo TINYINT
AS
BEGIN 
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_piso = @direccion_piso_nuevo
	WHERE direccion_id = @direccionid

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.11) Modificación de direccion (departamento)
  
CREATE PROCEDURE LIL_MIX.modificarClienteDptoDirec
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@direccion_dpto_nuevo CHAR(1)
AS
BEGIN
BEGIN TRY 
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_dpto = @direccion_dpto_nuevo
	WHERE direccion_id = @direccionid

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 11.12) Modificación de direccion (ciudad)
  
CREATE PROCEDURE LIL_MIX.modificarClienteCiudad
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@ciudad_nueva VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_ciudad = @ciudad_nueva
	WHERE direccion_id = @direccionid

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

---------------------------------------------  AMB DE PROVEEDOR  ---------------------------------------------

-- 12)

-- La eliminación de un proveedor implica la baja lógica del mismo.

IF OBJECT_ID('LIL_MIX.eliminarProveedor') IS NOT NULL
  DROP PROCEDURE LIL_MIX.eliminarProveedor

CREATE PROCEDURE LIL_MIX.eliminarProveedor
@razon_social VARCHAR(255), @cuit VARCHAR(13)
AS
BEGIN
	UPDATE LIL_MIX.proveedor
	SET proveedor_habilitado = 0
	WHERE proveedor_rs = @razon_social AND proveedor_cuit = @cuit

END

-- 13) SECCIÓN DE MODIFICACIÓN DEL PROVEEDOR

-- 13.1)

-- Se debe poder volver a habilitar el proveedor deshabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.habilitarProveedor
@cuit VARCHAR(13), @razon_social VARCHAR(255)
AS
BEGIN
	DECLARE @usuarioid INT
	
	SELECT @usuarioid = p.proveedor_usuario_id
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (u.usuario_id = p.proveedor_usuario_id)
	WHERE u.usuario_nombre = @usuario_nombre
	
	UPDATE LIL_MIX.proveedor
	SET proveedor_habilitado = 1
	WHERE proveedor_usuario_id = @usuarioid
END

-- Todos los datos mencionados anteriormente son modificables: Razón Social, Mail, Teléfono, Dirección calle, nro piso, depto 
-- y localidad, Código Postal, Ciudad, CIUT, Rubro en el cual se desempeña, Nombre de Contacto  

-- 13.2) Modificar razon social

CREATE PROCEDURE LIL_MIX.modificarProveedorRS
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@razon_social_nueva VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_rs = @razon_social_nueva 
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.3) Modificar mail

CREATE PROCEDURE LIL_MIX.modificarProveedorMail
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@mail_nuevo VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_mail = @mail_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.4) Modificar telefono

CREATE PROCEDURE LIL_MIX.modificarProveedorTelefono
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@telefono_nuevo INT
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_telefono = @telefono_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.5) Modificar codigo postal

CREATE PROCEDURE LIL_MIX.modificarProveedorCP
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@codigopostal_nuevo SMALLINT
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_cp = @codigopostal_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.6) Modificar cuit

CREATE PROCEDURE LIL_MIX.modificarProveedorCiudad
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@cuit_nuevo VARCHAR(13)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_cuit = @cuit_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.7) Modificar rubro en el cual se desempeña

CREATE PROCEDURE LIL_MIX.modificarProveedorRubro
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@rubro_nuevo VARCHAR(255)
AS
BEGIN 
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_rubro = @rubro_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.8) Modificar nombre de contacto

CREATE PROCEDURE LIL_MIX.modificarProveedorNombreDeContacto
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@nombre_de_contacto_nuevo VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
				
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = u.usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_nombre_contacto  = @nombre_de_contacto_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor		

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.9) Modificación de direccion (calle)
  
CREATE PROCEDURE LIL_MIX.modificarClienteCalleDirec
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@direccion_calle_nuevo VARCHAR(255) 
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_calle = @direccion_calle_nuevo 
	WHERE direccion_id = @direccionid

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.10) Modificación de direccion (numero de piso)
  
CREATE PROCEDURE LIL_MIX.modificarClientePisoDirec
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@direccion_piso_nuevo TINYINT
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_piso = @direccion_piso_nuevo
	WHERE direccion_id = @direccionid

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.11) Modificación de direccion (departamento)
  
CREATE PROCEDURE LIL_MIX.modificarClienteDptoDirec
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@direccion_dpto_nuevo CHAR(1)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_dpto = @direccion_dpto_nuevo
	WHERE direccion_id = @direccionid
				
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

-- 13.12) Modificación de direccion (ciudad)
  
CREATE PROCEDURE LIL_MIX.modificarClienteCiudad
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@ciudad_nueva VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION

	-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = HASHBYTES('SHA2_256', @contrasenia))
		THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_ciudad = @ciudad_nueva
	WHERE direccion_id = @direccionid
	
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
				
END

--------------------------------------------  CARGA DE CRÉDITO  -----------------------------------------------

-- 17)

-- Esta funcionalidad permite la carga de crédito a la cuenta de un cliente para poder operar en este nuevo sistema

IF OBJECT_ID('LIL_MIX.cargarCredito') IS NOT NULL
  DROP PROCEDURE LIL_MIX.cargarCredito

CREATE PROCEDURE LIL_MIX.cargarCredito
@usuario_nombre VARCHAR(255), @monto BIGINT, 
@tipo_de_pago VARCHAR(30), --efectivo, credito o debito
@fechadecarga DATETIME, --supongo que se ve en c# este tema
@tarjeta_numero INT, @tarjeta_tipo VARCHAR(30), @tarjeta_fecha_vencimiento DATETIME
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
		DECLARE @cliente INT,
			@tipodepago VARCHAR(30),
			@clientehabilitado BIT

		SELECT @cliente = cliente_id, @clientehabilitado = cliente_habilitado
		FROM LIL_MIX.cliente c JOIN LIL_MIX.usuario u ON (u.usuario_id = c.cliente_usuario_id) 
		WHERE u.usuario_nombre = @usuario_nombre

		SELECT @tipodepago = tipo_de_pago FROM LIL_MIX.tipoDePago 
		WHERE tipo_de_pago_descripcion = @tipo_de_pago
			
		-- Un cliente inhabilitado no podrá comprar ofertas ni cargarse crédito bajo ninguna forma
			
		IF @clientehabiliado = 0
			THROW 50063, 'Cliente inhabilitado. No puede cargarse de crédito.', 1

		-- Una vez que se determina el monto a cargar, será necesario que se elija el tipo de pago (tarjeta de crédito o débito), 
		-- será obligatorio que se registren los datos necesarios para poder identificar la tarjeta utilizada. 

		IF @tipodepago != 1 -- No es 'Efectivo'
		
			-- Chequeo si los datos de la tarjeta ingresada están en la tabla TARJETA pero algún dato no concuerda
		
			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente = @cliente AND tarjeta_numero = @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento != @tarjeta_fecha_vencimiento)
				THROW 50012, 'Error al ingresar tarjeta', 1

			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente = @cliente AND tarjeta_numero = @tarjeta_numero AND tarjeta_tipo != @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente = @cliente)
				THROW 50013, 'Error al ingresar tarjeta', 1

			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente = @cliente AND tarjeta_numero != @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente != @cliente)
				THROW 50014, 'Error al ingresar tarjeta', 1
				
			-- Si en la tabla TARJETAS no está registrada dicha tarjeta para dicho cliente, la registro

			IF NOT EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_numero = @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente = @cliente)
				INSERT INTO LIL_MIX.tarjeta (tarjeta_numero, tarjeta_tipo, tarjeta_fecha_vencimiento, tarjeta_id_cliente)
				VALUES (@tarjeta_numero, @tarjeta_tipo, @tarjeta_fecha_vencimiento, @cliente)

		-- Al momento de efectuarse la carga de dinero, el sistema tomará la fecha de día. 
		-- La misma será tomada del archivo de configuración de la aplicación. 

		INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_monto, carga_id_cliente, carga_tipo_de_pago, carga_tarjeta_numero)
		VALUES (@fechadecarga, @monto , @cliente, @tipodepago, @tarjeta_numero) 

		COMMIT TRANSACTION
	END TRY
	
	BEGIN CATCH
		
		ROLLBACK TRANSACTION
		
	END CATCH
END
		
---------------------------------------  CONFECCIÓN Y PUBLICACIÓN DE OFERTAS ------------------------------------------

-- 18)

--Este caso de uso es utilizado por los proveedores para armar y publicar las ofertas que formarán parte de la plataforma.

CREATE PROCEDURE LIL_MIX.crearOferta
@usuario_nombre VARCHAR(255),
@fechaactualdelsistema DATETIME,
@oferta_decripcion VARCHAR(255), @oferta_fecha_vencimiento DATETIME, @oferta_precio_oferta INT, @oferta_precio_lista INT,
@oferta_stock INT, @oferta_restriccion_compra TINYINT, @oferta_codigo VARCHAR(255)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
		DECLARE @proveedorid INT,
			@proveedorhabilitado BIT
		
		SELECT @proveedorid = p.proveedor_id, @proveedorhabilitado = p.proveedor_habilitado
		FROM LIL_MIX.proveedor p JOIN LIL_MIX.usuario u ON (u.usuario_id = p.proveedor_id)
		WHERE u.usuario_nombre = @usuario_nombre
		
		-- Un proveedor inhabilitado no podrá armar ofertas. 
		
		IF @proveedorhabilitado = 0
			THROW 50070, 'Proveedor inhabilitado. No puede armar ofertas', 1
		
		-- El proveedor podrá ir cargando ofertas con diferentes fechas, 
		-- esta fecha debe ser mayor o igual a la fecha actual del sistema
		
		IF @oferta_fecha_vencimiento < @fechaactualdelsistema
			THROW 50015, 'Fecha de vencimiento debe ser mayor o igual a la fecha actual.', 1
		
		-- Un cupón consta de 2 precios, que son determinados por el proveedor: 
		-- El precio de oferta. (rebajado) y El precio de lista u original del producto o servicio que se publica 
		
		IF @oferta_precio_oferta >= @oferta_precio_lista
			THROW 50016, 'El precio de oferta debe ser menor que el precio de lista.', 1
			
		INSERT INTO LIL_MIX.oferta (oferta_codigo, oferta_precio_oferta, oferta_precio_lista, oferta_fecha_publicacion,
			oferta_fecha_vencimiento, oferta_decripcion, oferta_stock, oferta_proveedor_id, oferta_restriccion_compra)
		VALUES (@oferta_codigo, @oferta_precio_oferta, @oferta_precio_lista, @fechaactualdelsistema, @oferta_fecha_vencimiento,
			@oferta_decripcion, @oferta_stock, @oferta_restriccion_compra) 
			
	-- ULTIMO PARRAFO: Y SI UN ADMINISTRATIVO HACE UNA OFERTA=?=?=?=?=?
		
		COMMIT TRANSACTION
	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION
		
	END TRY
END

----------------------------------------------  COMPRAR OFERTA ----------------------------------------------------

-- 19)

-- Esta funcionalidad permite a un cliente comprar una oferta publicada por los diferentes proveedores. 

CREATE PROCEDURE LIL_MIX.comprarOferta
@nombre_usuario INT, @oferta_codigo VARCHAR(255), @cantidad TINYINT, @diadecompra DATETIME			
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @creditocliente BIGINT,
			@preciooferta INT,
			@cantmaximadeofertas TINYINT,
			@ofertaid INT,
			@clienteid INT,
			@compraid INT,
			@ofertadesc VARCHAR(255),
			@fechavenc DATETIME,
			@stockdisponible INT,
			@clientehabilitado BIT
		
		SELECT @creditocliente = c.cliente_credito, @clienteid = c.cliente_id, @clientehabilitado = c.cliente_habilitado
		FROM LIL_MIX.cliente c JOIN LIL_MIX.usuario u ON (u.usuario_id = c.cliente_usuario_id)
		WHERE u.usuario_nombre = @nombre_usuario
		
		SELECT @ofertaid = oferta_id, @preciooferta = oferta_precio_oferta, @fechavenc = oferta_fecha_vencimiento,
		@ofertadesc = oferta_decripcion, @cantmaximadeofertas = oferta_restriccion_compra, @stockdisponible = oferta_stock
		FROM LIL_MIX.oferta WHERE oferta_codigo = @oferta_codigo
		
		-- Un cliente inhabilitado no podrá comprar ofertas ni cargarse crédito bajo ninguna forma
		
		IF @clientehabilitado = 0
			THROW 50064, 'Cliente inhabilitado. No puede comprar ofertas.', 1
		
		-- Chequear si hay stock disponible
		
		IF @stockdisponible < @cantidad
			THROW 50030, 'No hay suficiente stock de dicha oferta.', 1
	
		-- Al momento de realizar la compra el sistema deberá validar que el crédito que posee el usuario sea suficiente
		
		IF @creditocliente < (@preciooferta * @cantidad)
			THROW 50017, 'No tiene crédito suficiente para realizar la compra.', 1
		
		-- Se deberá validar que la adquisición no supere la cantidad máxima de ofertas permitida por usuario. 
		
		IF @cantidad > @cantmaximadeofertas
			THROW 50018, 'Superó el máximo de unidades permitida para comprar por cliente.', 1
		
		-- Los datos mínimos a registrar son los siguientes: Fecha de compra, Oferta, Nro de Oferta, Cliente que realizó la compra 

		INSERT INTO LIL_MIX.compra (compra_oferta_numero, compra_oferta_descr, compra_cliente_id, compra_cantidad, compra_fecha)
		VALUES (@ofertaid, @ofertadesc, @clienteid, @cantidad, @diadecompra) 
		
		-- Cuando un cliente adquiere una oferta, se le deberá informar el código de compra 
		
		SELECT @compraid = compra_id FROM LIL_MIX.compra
		WHERE compra_oferta_id = @ofertaid AND compra_oferta_descr = @ofertadesc AND compra_cliente_id = @clienteid AND compra_cantidad = @cantidad AND compra_fecha = GETDATE() --cambiar a la funcion q encontro juan
		
		RETURN @compraid 
		
		UPDATE LIL_MIX.oferta
		SET oferta_stock = oferta_stock - @cantidad
		WHERE oferta_codigo = @oferta_codigo
		
		-- Generación automática del cupón
		
		INSERT INTO LIL_MIX.cupon (cupon_fecha_vencimiento, cupon_compra_id, cupon_cliente_id)
		VALUES (DATEADD(day, 30, @diadecompra), @compraid, @clienteid)

		COMMIT TRANSACTION
		
	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION
		
	END CATCH

END

---------------------------------------  ENTREGA/CONSUMO DE OFERTA ------------------------------------------

-- 20)

-- Funcionalidad que permite a un proveedor dar de baja una oferta entregada por un cliente al momento de realizarse el canje.  

CREATE PROCEDURE LIL_MIX.consumoDeOferta
@cuponid INT, @nombre_usuario VARCHAR(13), @diadeconsumo DATETIME
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
		DECLARE @fechaconsumo DATETIME,
			@fechacomp DATETIME,
			@proveedorid INT,
			@proveedoridchequear INT
		
		SELECT @fechaconsumo = cu.cupon_fecha_consumo, @fechacomp = co.compra_fecha,
		@proveedoridchequear = of.oferta_proveedor_id
		FROM LIL_MIX.compra co JOIN LIL_MIX.cupon cu ON (cu.cupon_compra_id = co.compra_id)
				       JOIN LIL_MIX.oferta of ON (of.oferta_id = co.compra_oferta_numero)
		WHERE cupon_id = @cuponid
		
		SELECT @proveedorid = p.proveedor_id 
		FROM LIL_MIX.proveedor p JOIN LIL_MIX.usuario u ON (p.proveedor_usuario_id = u.usuario_id)
		WHERE u.usuario_nombre = @nombre_usuario
		
		-- Este proceso tiene como restricciones que un cupón no puede ser canjeado más de una vez
	
		IF @fechaconsumo IS NOT NULL
			THROW 50019, 'El cupón ya fue canjeado', 1

		-- Si el cupón se venció tampoco podrá ser canjeado 
		
		IF @fechavenc < @diadeconsumo
			THROW 50020, 'El cupón está vencido', 1
			
		-- Validarse que dicho cupón entrega corresponda al proveedor
		
		IF @proveedorid != @proveedoridchequear
			THROW 50021, 'El cupón no corresponde a dicho proveedor', 1
		
	-- Para dar de baja un cupón disponible para consumir es necesario que se registre: Fecha de consumo, Código de cupón, Cliente 
		
		UPDATE LIL_MIX.cupon
		SET cupon_fecha_consumo = @diadeconsumo
		WHERE cupon_id = @cuponid
			
		COMMIT TRANSACTION
		
	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION
		
	END CATCH

END

------------------------------------- FACTURACION PROVEEDOR -------------------------------------------------

-- 21)

-- Esta funcionalidad permite a un administrativo facturar a un proveedor todas las ofertas compradas por los clientes. 
-- Para ello ingresará el período de facturación por intervalos de fecha, se deberá seleccionar el proveedor 
-- y a continuación se listaran todos las ofertas que fueron adquiridas por los clientes.  

CREATE PROCEDURE LIL_MIX.facturacionProveedor
@fecha_inicio DATETIME , @fecha_fin DATETIME , @proveedor_cuit VARCHAR(13)
AS
BEGIN 
	DECLARE @proveedor_id INT,
		@factura_importe INT

	BEGIN TRY
		BEGIN TRAN
	
		IF NOT EXISTS (SELECT * FROM LIL_MIX.proveedor WHERE proveedor_cuit = @proveedor_cuit)
			THROW 50125 , 'El proveedor al que se quiere facturar no existe' , 1

		-- Se informará el importe de la factura y el número correspondiente de la misma. 
		
		SELECT @proveedor_id = p.proveedor_id , @factura_importe = SUM(c.compra_cantidad * o.oferta_precio_oferta) 
		FROM LIL_MIX.oferta o JOIN LIL_MIX.compra c ON (o.oferta_id = c.compra_oferta_id)
				      JOIN LIL_MIX.proveedor p ON (o.oferta_proveedor_id = p.proveedor_id)
		WHERE p.proveedor_cuit = @proveedor_cuit AND (c.compra_fecha BETWEEN @fecha_inicio AND @fecha_fin)
		GROUP BY p.proveedor_id

		INSERT INTO LIL_MIX.factura (factura_proveedor_id , factura_fecha_inicio , factura_fecha_fin , factura_importe)
		VALUES (@proveedor_id, @fecha_inicio , @fecha_fin , @factura_importe)

		COMMIT 
	END TRY

	BEGIN CATCH 

		ROLLBACK

	END CATCH

END

--------------------------------------------- LISTADO ESTADÍSTICO -----------------------------------------------------

-- Esta funcionalidad nos debe permitir consultar el TOP 5 de: 
--	o Proveedores con mayor porcentaje de descuento ofrecido en sus ofertas 
--	o Proveedores con mayor facturación 

-- Dichas consultas son a nivel semestral, para lo cual la pantalla debe permitirnos selección el semestral a consultar.  
-- Además de ingresar el año a consultar, el sistema nos debe permitir seleccionar que tipo de listado se quiere visualizar. 

-- 22) 1. Prov mayor porcentaje descuento

CREATE PROCEDURE LIL_MIX.listadoEstadistico1   
@anio INT, @semestre INT   -- 1 o 2
AS
BEGIN
	IF @listadoavisualizar = 1 -- Proveedores con mayor porcentaje de descuento ofrecido en sus ofertas 
	
		SELECT TOP 5 o.proveedor_id as 'ID', p.proveedor_nombre_contacto as 'Nombre de contacto', p.proveedor_mail as 'Mail', 
			p.proveedor_cuit as 'CUIT', p.proveedor_rubro as 'Rubro', p.proveedor_rs as 'Razon social', 
			(o.oferta_precio_oferta * 100 / o.oferta_precio_lista) as 'Porcentaje de Descuento'				
		FROM LIL_MIX.proveedor p JOIN LIL_MIX.oferta o ON (o.oferta_proveedor_id = p.proveedor_id), LIL_MIX.semestre s
		WHERE s.semestre_id = @semestre
		GROUP BY p.proveedor_nombre_contacto, p.proveedor_mail, p.proveedor_cuit, p.proveedor_rubro, p.proveedor_rs
		HAVING o.oferta_fecha_publicacion BETWEEN CONVERT(DATETIME, s.semestre_fecha_inicio+'-'+@anio, 103) AND CONVERT(DATETIME, s.semestre_fecha_fin+'-'+@anio, 103)
		ORDER BY [Porcentaje de Descuento] DESC	-- El listado se debe ordenar en forma descendente por monto. 
END

-- Cabe aclarar que los campos a visualizar en la tabla del listado para las 2 consultas no son los mismos, 
-- y al momento de seleccionar un tipo solo deben visualizarse las columnas pertinentes al tipo de listado elegido. 		
		
-- 23) 2. Prov mayor facturacion

CREATE PROCEDURE LIL_MIX.listadoEstadistico1  
@anio INT, @semestre INT   -- 1 o 2
     o 2. Prov mayor facturacion
AS
BEGIN
	IF @listadoavisualizar = 2 -- Proveedores con mayor facturación 
	
		SELECT TOP 5 o.proveedor_id as 'ID', p.proveedor_nombre_contacto as 'Nombre de contacto', p.proveedor_mail as 'Mail', 
			p.proveedor_cuit as 'CUIT', p.proveedor_rubro as 'Rubro', p.proveedor_rs as 'Razon social', SUM(f.factura_importe) as 'Total Facturado'
		FROM LIL_MIX.proveedor p JOIN LIL_MIX.factura f ON (f.factura_proveedor_id = p.proveedor_id), LIL_MIX.semestre s
		WHERE s.semestre_id = @semestre
		GROUP BY p.proveedor_nombre_contacto, p.proveedor_mail, p.proveedor_cuit, p.proveedor_rubro, p.proveedor_rs
		HAVING (f.factura_fecha_inicio BETWEEN CONVERT(DATETIME, s.semestre_fecha_inicio+'-'+@anio, 103) AND CONVERT(DATETIME, s.semestre_fecha_fin+'-'+@anio, 103))
			AND (f.factura_fecha_fin BETWEEN CONVERT(DATETIME, s.semestre_fecha_inicio+'-'+@anio, 103) AND CONVERT(DATETIME, s.semestre_fecha_fin+'-'+@anio, 103))
		ORDER BY [Total Facturado] DESC	-- El listado se debe ordenar en forma descendente por monto. 
	
END




