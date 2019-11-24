------------------::::::::::::::::::::::  PROCEDURES  ::::::::::::::::::::::------------------

----------------------------------------  AMB DE ROL  ----------------------------------------

--1) 

--Crear un rol implica cargar los siguientes datos: Nombre y Listado de Funcionalidades (selección acotada) 
 
CREATE PROCEDURE LIL_MIX.crearRol 
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @rol_nombre IN (SELECT rol_nombre FROM LIL_MIX.rol)
				THROW 51000, 'Rol existente', 1

			IF @funcionalidad_descripcion NOT IN (SELECT funcionalidad_descripcion FROM LIL_MIX.funcionalidad)
				THROW 51001, 'Funcionalidad inexistente', 1
			
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

-- En la modificación de un rol solo se pueden alterar ambos campos: el nombre y el listado de funcionalidades. 

CREATE PROCEDURE LIL_MIX.modificarRol
@rol_nombre VARCHAR(30), @rol_nombre_nuevo VARCHAR(30), @funcionalidad_descripcion VARCHAR(30), @accion VARCHAR(1)
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

--Crear un Usuario

CREATE PROCEDURE LIL_MIX.crearUsuario
@usuario_nombre VARCHAR(255), @usuario_password VARCHAR(255), @rol_nombre VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			-- El username debe ser único en un todo el sistema.

			IF EXISTS (SELECT * FROM LIL_MIX.usuario u, inserted i WHERE u.usuario_nombre = i.usuario_nombre)

			--La aplicación deberá controlar esta restricción e informar debidamente al usuario.

				THROW 50008, 'Nombre de usuario ya existente, intente nuevamente', 1

			IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
				THROW 50009, 'El rol no existe', 1
			
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

	IF EXISTS (SELECT * FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
				 WHERE c.cliente_dni = @dni AND u.usuario_nombre =! @nombre_de_usuario)
		THROW 51003, 'Cliente gemelo. No puede realizarse la operación', 1

	INSERT INTO LIL_MIX.dirección (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
	VALUES (@direccion_calle, @direccion_piso, @direccion_dpto, @ciudad)

	-- Toda creación de cliente nuevo, implica una carga de dinero de bienvenida de $200.
	
	INSERT INTO LIL_MIX.cliente (cliente_nombre, cliente_apellido, cliente_mail, cliente_telefono, cliente_fecha_nacimiento, 
				cliente_cp, cliente_dni, cliente_credito, cliente_habilitado, cliente_usuario_id, cliente_direccion_id)
	VALUES (@nombre, @apellido, @mail, @telefono, @fechanacimiento, @codigopostal, @dni, 200, 1, 
		(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_de_usuario),
		(SELECT direccion_id FROM LIL_MIX.dirección WHERE direccion_calle = @direccion_calle AND 
		direccion_piso = @direccion_piso AND direccion_dpto = @direccion_dpto AND direccion_ciudad = @ciudad)) 
	
	COMMIT

END TRY

BEGIN CATCH

	ROLLBACK

END CATCH

END

--10)

-- La eliminación de un cliente implica la baja lógica del mismo. 

CREATE PROCEDURE LIL_MIX.eliminarCliente
@dni_del_cliente int
AS
BEGIN

	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 0
	WHERE cliente_dni = @dni_del_cliente

END

--11)

-- Todos los datos mencionados anteriormente son modificables. 
-- Se debe poder volver a habilitar el cliente deshabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.modificarCliente
@nombre_usuario_nuevo VARCHAR(255), @nombre_nuevo VARCHAR(255), @apellido_nuevo VARCHAR(255), @dni_nuevo INT, @mail_nuevo VARCHAR(255), 
@telefono_nuevo INT, @fechanacimiento_nuevo DATETIME, @codigopostal_nuevo SMALLINT, @direccion_calle_nuevo VARCHAR(255), 
@direccion_piso_nuevo TINYINT, @direccion_dpto_nuevo CHAR(1), @ciudad_nuevo VARCHAR(255)
AS
BEGIN

	IF @nombre_de_usuario IS NOT NULL
		UPDATE LIL_MIX.usuario
		SET n

END
















