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


