------------------::::::::::::::::::::::  PROCEDURES  ::::::::::::::::::::::------------------

----------------------------------------  AMB DE ROL  ----------------------------------------

--1) 

IF OBJECT_ID('LIL_MIX.crearRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.crearRol

--Crear un rol implica cargar los siguientes datos: Nombre y Listado de Funcionalidades (selección acotada) 
 
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

--2)

IF OBJECT_ID('LIL_MIX.modificarRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarRol

-- En la modificación de un rol solo se pueden alterar ambos campos: el nombre y el listado de funcionalidades. 

CREATE PROCEDURE LIL_MIX.modificarRol
@rol_nombre VARCHAR(30), @rol_nombre_nuevo VARCHAR(30), @funcionalidad_descripcion VARCHAR(30), 
@accion VARCHAR(1) -- borrar o agregar funcionalidad
AS
BEGIN

	IF @rol_nombre_nuevo NOT NULL

		UPDATE LIL_MIX.rol
		SET rol_nombre = rol_nombre_nuevo
		WHERE rol_nombre = @rol_nombre

	--Se deben poder quitar de a una las funcionalidades como así  también agregar nuevas funcionalidades a rol que 
	--se está modificando

	BEGIN TRY
		BEGIN TRAN
			IF @funcionalidad_descripcion NOT IN (SELECT funcionalidad_descripcion FROM LIL_MIX.funcionalidad)
				THROW 51002, 'No existe funcionalidad', 1

			IF @accion = 1 -- El usuario pretende agregar funcionalidad

			INSERT INTO LIL_MIX.funcionalidadxrol (rol_id, funcionalidad_id)
			VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre),
				(SELECT funcionalidad_id FROM LIL_MIXfuncionalidad 
				WHERE funcionalidad_descripcion = @funcionalidad_descripcion))

			IF @accion = 2 --El usuario pretende eliminar funcionalidad

			DELETE FROM LIL_MIX.funcionalidadxrol 
			WHERE funcionalidad_id = (SELECT funcionalidad_id FROM LIL_MIX.funcionalidad WHERE funcionalidad_descripcion = @funcionalidad_descripcion)
				AND rol_id = (SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre)

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH

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

--4) 

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

----------------------------------------  LOGIN Y SEGURIDAD  ----------------------------------------

--5)

CREATE PROCEDURE LIL_MIX.Login_procedure @username VARCHAR(20) , @password VARCHAR(10)
AS
 BEGIN
	DECLARE @intentos TINYINT 
	DECLARE @hash VARBINARY(225) 
	DECLARE @pass VARBINARY(225)
	DECLARE @cantidad INT 
	
	SET @intentos = (SELECT usuario_intentos FROM LIL_MIX.usuario WHERE usuario_nombre = @username) --INTENTOS FALLIDOS
    SET @hash = HASHBYTES('SHA2_256',  @password) -- Me encripta el password
	SET @pass = (SELECT usuario_password FROM LIL_MIX.usuario WHERE usuario_nombre = @username) -- El password real

	IF(@intentos IS NULL) 	--me fijo si esta el usuario
		SET @cantidad = -1

		ELSE IF(@hash != @pass)  --comparo las contrasenias , la que me pasan y se encripta con la real (se equivoca)
			BEGIN
				SET @cantidad = @intentos
				IF(@intentos != 3)  --verifico la cantidad de ceros. si aun le quedan, hago el update
					UPDATE LIL_MIX.usuario 
					SET usuario_intentos = @intentos + 1 
					WHERE usuario_nombre = @username
			END				
		ELSE 
			IF (@intentos != 3) 
				BEGIN
				SET @cantidad = 4   --Todo bien! Contrasenia correcta!
				UPDATE LIL_MIX.Usuario SET usuario_intentos = 0 
				WHERE usuario_nombre = @username
				END
		RETURN @cantidad
 END

------------------------------------  REGISTRO DE USUARIO  -----------------------------------

-------------------- procedure copiado hay que reveer --> tema encriptacion

CREATE PROCEDURE GEDDES.ingresarUsuario(
    @username VARCHAR(20),
  	@password VARCHAR(10),
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
  	@tipoDoc VARCHAR(20),
    @nroDoc DECIMAL(8,0),
  	@direccion VARCHAR(255),
  	@telefono DECIMAL(18,0),
  	@fechaNacimiento DATETIME,
  	@sexo VARCHAR(15),
	@mail VARCHAR(255))
AS
BEGIN
    DECLARE @pass VARBINARY(225)
	SET @pass = HASHBYTES('SHA2_256',@password) 
	INSERT INTO GEDDES.Usuarios(usua_id, usua_username,usua_password, usua_nombre, usua_apellido, usua_tipoDoc, usua_nroDoc, usua_direccion,
					usua_telefono,usua_fechaNacimiento, usua_sexo, usua_mail)

	VALUES(@nroDoc*100+1,@username,@pass,@nombre,@apellido,@tipoDoc,@nroDoc,@direccion, @telefono,@fechaNacimiento, @sexo, @mail)

	INSERT INTO GEDDES.RolXusuario (usua_id,role_id)
		VALUES (@nroDoc*100+1, 1)

END
-----------

--6)

IF OBJECT_ID('LIL_MIX.crearUsuario') IS NOT NULL
  DROP PROCEDURE LIL_MIX.crearUsuario

--Crear un Usuario

CREATE PROCEDURE LIL_MIX.crearUsuario
@usuario_nombre VARCHAR(255), @usuario_password VARCHAR(255), @rol_nombre VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			-- El username debe ser único en un todo el sistema.

			IF EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre)

			--La aplicación deberá controlar esta restricción e informar debidamente al usuario.

				THROW 50006, 'Nombre de usuario ya existente, intente nuevamente', 1

			IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
				THROW 50007, 'El rol no existe', 1
			
			--El password deberá almacenarse encriptado de forma irreversible bajo el algoritmo de encriptación SHA256.

			INSERT INTO LIL_MIX.usuario (usuario_nombre, usuario_password, usuario_intentos, usuario_habilitado)
			VALUES (@usuario_nombre, @usuario_password, 0, 1)

			INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
			VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
					(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))

			COMMIT
	END TRY

	BEGIN CATCH

		ROLLBACK

	END CATCH
END

--7)

IF OBJECT_ID('LIL_MIX.modificarContrasenia') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarContrasenia

--Debe tenerse en cuenta que se pueda modificar el password. 

CREATE PROCEDURE LIL_MIX.modificarContrasenia
@anterior VARCHAR(255), @nueva VARCHAR(255)
AS
BEGIN

	UPDATE LIL_MIX.usuario
	SET usuario_password = @nueva
	WHERE usuario_password = @anterior

END

--8)

IF OBJECT_ID('LIL_MIX.darDeBajaUsuario') IS NOT NULL
  DROP PROCEDURE LIL_MIX.darDeBajaUsuario

--También debe contemplarse de alguna manera, que un administrativo pueda dar de baja un usuario. 

CREATE PROCEDURE LIL_MIX.darDeBajaUsuario
@usuario_nombre VARCHAR(255)
AS
BEGIN

  UPDATE LIL_MIX.usuario
  SET usuario_habilitado = 0
  WHERE usuario_nombre = usuario_nombre

END
---------------------------------------  AMB DE CLIENTES  ---------------------------------------

--9)

IF OBJECT_ID('LIL_MIX.darDeAltaCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.darDeAltaCliente

-- Dar de alta un cliente 

CREATE PROCEDURE LIL_MIX.darDeAltaCliente 
@nombre_de_usuario VARCHAR(255), @nombre VARCHAR(255), @apellido VARCHAR(255), @dni INT, @mail VARCHAR(255), 
@telefono INT, @fechanacimiento DATETIME, @codigopostal SMALLINT, @direccion_calle VARCHAR(255), @direccion_piso TINYINT, 
@direccion_dpto CHAR(1), @ciudad VARCHAR(255)
AS
BEGIN

-- El alumno deberá determinar un procedimiento para evitar la generación de clientes “gemelos” 
-- (distinto nombre de usuario, pero igual datos identificatorios según se justifique en la estrategia de resolución).

BEGIN TRY
	BEGIN TRAN

	-- Consideramos dato identificatorio al dni 

	IF EXISTS (SELECT * FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_user_id = u.usuario_id)
				 WHERE c.cliente_dni = @dni AND u.usuario_nombre != @nombre_de_usuario)
		THROW 50008, 'Cliente gemelo. No puede realizarse la operación', 1

	INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
	VALUES (@direccion_calle, @direccion_piso, @direccion_dpto, @ciudad)

	-- Toda creación de cliente nuevo, implica una carga de dinero de bienvenida de $200.
	
	INSERT INTO LIL_MIX.cliente (cliente_nombre, cliente_apellido, cliente_mail, cliente_telefono, cliente_fecha_nacimiento, 
				cliente_cp, cliente_dni, cliente_credito, cliente_habilitado, cliente_user_id, cliente_direccion_id)
	VALUES (@nombre, @apellido, @mail, @telefono, @fechanacimiento, @codigopostal, @dni, 200, 1, 
		(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_de_usuario),
		(SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = @direccion_calle AND 
		direccion_piso = @direccion_piso AND direccion_dpto = @direccion_dpto AND direccion_ciudad = @ciudad)) 
	
	COMMIT

END TRY

BEGIN CATCH

	ROLLBACK

END CATCH

END

--10)

IF OBJECT_ID('LIL_MIX.eliminarCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.eliminarCliente

-- La eliminación de un cliente implica la baja lógica del mismo. 

CREATE PROCEDURE LIL_MIX.eliminarCliente
@dni_del_cliente INT
AS
BEGIN

	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 0
	WHERE cliente_dni = @dni_del_cliente

END

-- 11)

IF OBJECT_ID('LIL_MIX.habilitarCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.habilitarCliente

CREATE PROCEDURE LIL_MIX.habilitarCliente
@dni_del_cliente INT
AS
BEGIN

	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 1
	WHERE cliente_dni = @dni_del_cliente

END


-- 12)

IF OBJECT_ID('LIL_MIX.modificarCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarCliente

-- Todos los datos mencionados anteriormente son modificables: Nombre, Apellido, DNI, Mail, Teléfono,
-- Dirección calle, nro piso, depto y localidad, Código Postal, Fecha de Nacimiento.
-- Se debe poder volver a habilitar el cliente deshabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.modificarCliente 
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@nombre_nuevo VARCHAR(255), @apellido_nuevo VARCHAR(255), @dni_nuevo INT, @mail_nuevo VARCHAR(255), 
@telefono_nuevo INT, @fechanacimiento_nuevo DATETIME, @codigopostal_nuevo SMALLINT, @direccion_calle_nuevo VARCHAR(255), 
@direccion_piso_nuevo TINYINT, @direccion_dpto_nuevo CHAR(1), @ciudad_nuevo VARCHAR(255)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		DECLARE @direccion_id_del_cliente INT,
			@dni_del_cliente INT,
			@usuario_id_del_cliente INT
			
		DECLARE direccionusuarioydni CURSOR FOR
		SELECT @direccion_id_del_cliente = c.cliente_direccion_id, 
		@usuario_id_del_cliente = u.usuario_id, @dni_del_cliente = c.cliente_dni 
		FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_user_id = u.usuario_id) 
		WHERE usuario_nombre = @nombre_usuario 
	
		-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
		IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = @contrasenia)
			THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
		BEGIN
			IF @nombre_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_nombre = @nombre_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
			IF @apellido_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_apellido = @apellido_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
			IF @dni_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_dni = @dni_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
			IF @mail_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_mail = @mail_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
			IF @telefono_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_telefono = @telefono_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
			IF @fechanacimiento_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_fecha_nacimiento = @fechanacimiento_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
			IF @codigopostal_nuevo IS NOT NULL
				UPDATE LIL_MIX.cliente SET cliente_cp = @codigopostal_nuevo WHERE cliente_user_id = @usuario_id_del_cliente
		END			
		
		BEGIN
			IF @direccion_calle_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_calle = @direccion_calle_nuevo WHERE direccion_id = @direccion_id_del_cliente
			IF @direccion_piso_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_piso = @direccion_piso_nuevo WHERE direccion_id = @direccion_id_del_cliente
			IF @direccion_dpto_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_dpto = @direccion_dpto_nuevo WHERE direccion_id = @direccion_id_del_cliente
			IF @ciudad_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_ciudad = @ciudad_nuevo WHERE direccion_id = @direccion_id_del_cliente
		END
		 
					
		EXECUTE LIL_MIX.habilitarCliente @dni_del_cliente
		
		COMMIT
		
	END TRY
	
	BEGIN CATCH
		
		ROLLBACK
	
	END CATCH

END


---------------------------------------------  AMB DE PROVEEDOR  ---------------------------------------------

--13)

IF OBJECT_ID('LIL_MIX.darDeAltaProveedor') IS NOT NULL
  DROP PROCEDURE LIL_MIX.darDeAltaProveedor

-- Dar de alta un proveedor 

CREATE PROCEDURE LIL_MIX.darDeAltaProveedor
@nombre_de_usuario VARCHAR(255), @razon_social VARCHAR(255), @mail VARCHAR(255), @telefono INT, @cuit VARCHAR(13), @rubro VARCHAR(255), 
@nombre_contacto VARCHAR(255), @codigo_postal SMALLINT, @calle VARCHAR(255), @piso TINYINT, @dpto CHAR(1), @ciudad VARCHAR(255)
AS
--BEGIN
	BEGIN TRY
		BEGIN TRAN
	
		INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
		VALUES (@calle, @piso, @dpto, @ciudad)
		
	--La razón social y cuit son datos únicos, por ende no pueden existir 2 proveedores con la misma razón social y cuit
	--El sistema deberá controlar esta restricción e informar debidamente al usuario ante alguna anomalía.

		IF EXISTS (SELECT * FROM LIL_MIX.proveedor WHERE proveedor_rs = @razon_social AND proveedor_cuit = @cuit)
			THROW 50009, 'Combinacion de razón social y CUIT existentes', 1
			
		INSERT INTO LIL_MIX.proveedor (proveedor_telefono, proveedor_cuit, proveedor_rubro, proveedor_mail, proveedor_cp, 
			proveedor_nombre_contacto, proveedor_rs, proveedor_habilitado, proveedor_usuario_id, proveedor_direccion_id)
		VALUES (@telefono, @cuit, @rubro, @mail, @codigo_postal, @nombre_contacto, @razon_social, 1,
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_de_usuario),
			(SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = @calle AND direccion_piso = @piso AND
				direccion_dpto = @dpto AND direccion_ciudad = @ciudad)
		
	COMMIT
END TRY

BEGIN CATCH
	
	ROLLBACK
	
END CATCH

END


-- 14)

IF OBJECT_ID('LIL_MIX.eliminarProveedor') IS NOT NULL
  DROP PROCEDURE LIL_MIX.eliminarProveedor

--La eliminación de un proveedor implica la baja lógica del mismo.

CREATE PROCEDURE LIL_MIX.eliminarProveedor
@razon_social VARCHAR(255), @cuit VARCHAR(13)
AS
BEGIN

	UPDATE LIL_MIX.proveedor
	SET proveedor_habilitado = 0
	WHERE proveedor_rs = @razon_social AND proveedor_cuit = @cuit

END


-- 15)

CREATE PROCEDURE LIL_MIX.habilitarProveedor
@cuit VARCHAR(13), @razon_social VARCHAR(255)
AS
BEGIN

	UPDATE LIL_MIX.proveedor
	SET proveedor_habilitado = 1
	WHERE proveedor_cuir = @cuit AND proveedor_rs = @razon_social

END

-- 16)

-- Todos los datos mencionados anteriormente son modificables: Razón Social, Mail, Teléfono, Dirección calle, nro piso, depto 
-- y localidad, Código Postal, Ciudad, CIUT, Rubro en el cual se desempeña, Nombre de Contacto  
-- Se debe poder volver a habilitar el proveedor deshabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.modificarProveedor
@contrasenia VARCHAR(255), @nombre_usuario VARCHAR(255), -- El username no es modificable
@razon_social_nuevo VARCHAR(255), @mail_nuevo VARCHAR(255), @telefono_nuevo INT, @codigopostal_nuevo SMALLINT, 
@direccion_calle_nuevo VARCHAR(255), @direccion_piso_nuevo TINYINT, @direccion_dpto_nuevo CHAR(1), @ciudad_nuevo VARCHAR(255)
@cuit_nuevo VARCHAR(13), @rubro_nuevo VARCHAR(255), @nombre_de_contacto_nuevo VARCHAR(255)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		-- Por mas que ya haya hecho el LOGIN, que ingrese una vez más usuario y contraseña si pretende modificar cosas 
		
		IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario AND usuario_password = @contrasenia)
			THROW 50010, 'Usuario y/o contraseña incorrecta', 1
		
		DECLARE @cuit_proveedor VARCHAR(13),
			@razon_social_proveedor VARCHAR(255),
			@usuario_id_del_proveedor INT,
			@direccion_id_del_proveedor INT
			
		DECLARE cuitrazonsocialdireccionyusuario CURSOR FOR
		SELECT @direccion_id_del_proveedor = p.proveedor_direccion_id, @usuario_id_del_proveedor = u.usuario_id,  
		@cuit_proveedor = p.proveedor_cuit, @razon_social_proveedor = p.proveedor_rs
		FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id) 
		WHERE usuario_nombre = @nombre_usuario 
		
		BEGIN
			IF @razon_social_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_rs = @razon_social_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			IF @mail_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_mail = @mail_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			IF @telefono_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_telefono = @telefono_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			IF @codigopostal_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_cp = @codigopostal_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			IF @cuit_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_cuit = @cuit_nuevo_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			IF @rubro_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_rubro = @rubro_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			IF @nombre_de_contacto_nuevo IS NOT NULL
				UPDATE LIL_MIX.proveedor SET proveedor_nombre_contacto = @nombre_de_contacto_nuevo WHERE proveedor_usuario_id = @usuario_id_del_proveedor
			
		END			
		
		BEGIN
			IF @direccion_calle_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_calle = @direccion_calle_nuevo WHERE direccion_id = @direccion_id_del_proveedor
			IF @direccion_piso_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_piso = @direccion_piso_nuevo WHERE direccion_id = @direccion_id_del_proveedor
			IF @direccion_dpto_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_dpto = @direccion_dpto_nuevo WHERE direccion_id = @direccion_id_del_proveedor
			IF @ciudad_nuevo IS NOT NULL
				UPDATE LIL_MIX.direccion SET direccion_ciudad = @ciudad_nuevo WHERE direccion_id = @direccion_id_del_proveedor
		END
		 
					
		EXECUTE LIL_MIX.habilitarProveedor @cuit_proveedor, @razon_social_proveedor
		
		COMMIT
		
	END TRY
	
	BEGIN CATCH
		
		ROLLBACK
	
	END CATCH

END

--------------------------------------------  CARGA DE CRÉDITO  -----------------------------------------------

-- 17)

IF OBJECT_ID('LIL_MIX.cargarCredito') IS NOT NULL
  DROP PROCEDURE LIL_MIX.cargarCredito

-- Esta funcionalidad permite la carga de crédito a la cuenta de un cliente para poder operar en este nuevo sistema

CREATE PROCEDURE LIL_MIX.cargarCredito
@usuario_nombre VARCHAR(255), @monto INT, @tipo_de_pago VARCHAR(30) --efectivo, credito o debito
-- Lo saque por que no se usa y no tenia tipo de dato @datos_tarjeta 
AS
BEGIN

-- Al momento de efectuarse la carga de dinero, el sistema tomará la fecha de día. 
-- La misma será tomada del archivo de configuración de la aplicación. 

	INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_monto, carga_tipo_de_pago, carga_id_cliente)
	VALUES (GETDATE(), @monto , (SELECT tipo_de_pago FROM LIL_MIX.tipoDePago WHERE tipo_de_pago_descripcion = @tipo_de_pago),
		(SELECT cliente_id FROM LIL_MIX.cliente c JOIN LIL_MIX.usuario u ON (u.usuario_id = c.cliente_user_id) 
			WHERE u.usuario_nombre = @usuario_nombre)) -- NI IDEA COMO TIENE QUE SER EL GETDATE

	-- Una vez que se determina el monto a cargar, será necesario que se elija el tipo de pago (tarjeta de crédito o débito), 
	-- será obligatorio que se registren los datos necesarios para poder identificar la tarjeta utilizada. 

	INSERT INTO LIL_MIX.tipoDePago (tipo_de_pago_descripcion, tipo_de_pago_descuento, tipo_de_pago_tarjeta_numero)

	-- END  Falta terminar
