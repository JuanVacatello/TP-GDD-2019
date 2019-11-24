------------------::::::::::::::::::::::  PROCEDURES  ::::::::::::::::::::::------------------

----------------------------------------  AMB DE ROL  ----------------------------------------

------------------------------------  REGISTRO DE USUARIO  -----------------------------------

--1)

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

--2)

--Debe tenerse en cuenta que se pueda modificar el password. 

CREATE PROCEDURE LIL_MIX.modificarContrasenia
@anterior VARCHAR(255), @nueva VARCHAR(255)
AS
BEGIN

	UPDATE LIL_MIX.usuario
	SET usuario_password = @nueva
	WHERE usuario_password = @anterior

END

--3)

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

--4)

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

	INSERT INTO dirección (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
	VALUES (@direccion_calle, @direccion_piso, @direccion_dpto, @ciudad)

	-- Toda creación de cliente nuevo, implica una carga de dinero de bienvenida de $200.
	
	INSERT INTO cliente (cliente_nombre, cliente_apellido, cliente_mail, cliente_telefono, cliente_fecha_nacimiento, 
				cliente_cp, cliente_dni, cliente_credito, cliente_habilitado, cliente_usuario_id, cliente_direccion_id)
	VALUES (@nombre, @apellido, @mail, @telefono, @fechanacimiento, @codigopostal, @dni, 200, 1, 
		(SELECT usuario_id FROM usuario WHERE usuario_nombre = @nombre_de_usuario),
		(SELECT direccion_id FROM dirección WHERE direccion_calle = @direccion_calle AND direccion_piso = @direccion_piso AND
		direccion_dpto = @direccion_dpto AND direccion_ciudad = @ciudad)) 
	
	COMMIT

END TRY

BEGIN CATCH

	ROLLBACK

END CATCH

END















