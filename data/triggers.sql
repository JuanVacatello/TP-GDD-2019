
------------------::::::::::::::::::::::  TRIGGERS  ::::::::::::::::::::::------------------

---------------------------------------  AMB DE ROL  ---------------------------------------

--1) No puede haber un rol con funcionalidades repetidas

CREATE TRIGGER LIL_MIX.noRepetirFuncionalidadesEnUnRol ON LIL_MIX.funcionalidadxrol
INSTEAD OF INSERT AS
BEGIN
	DECLARE @funcionalidad_id varchar(30)
	DECLARE @rol_id int

	DECLARE cursorInsertados CURSOR FOR
	SELECT funcionalidad_id, rol_id FROM inserted

	OPEN cursorInsertados

	FETCH NEXT FROM cursorInsertados
	INTO @funcionalidad_id, @rol_id

	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN TRY
			BEGIN TRAN

			--Un rol posee un conjunto de funcionalidades y las mismas no pueden estar repetidas dentro de un rol en particular:

			IF @funcionalidad_id IN (SELECT funcionalidad_id FROM LIL_MIX.funcionalidadxrol WHERE rol_id = @rol_id)
				THROW 50001, 'Funcionalidad ya existente para este rol', 1

			--Chequeo de claves foraneas:

			IF @funcionalidad_id NOT IN (SELECT funcionalidad_id FROM LIL_MIX.funcionalidad)
				THROW 50002, 'Funcionalidad no existente', 1

			IF @rol_id NOT IN (SELECT rol_id FROM LIL_MIX.rol)
				THROW 50003, 'Rol no existente', 1

			INSERT INTO LIL_MIX.funcionalidadxrol (rol_id, funcionalidad_id)
			VALUES (@rol_id, @funcionalidad_id)

			COMMIT

		END TRY

		BEGIN CATCH

			ROLLBACK

		END CATCH

		FETCH NEXT FROM cursorInsertados
		INTO @funcionalidad_id, @rol_id

	END

	CLOSE cursorInsertados
	DEALLOCATE cursorInsertados

END

--2)

CREATE TRIGGER LIL_MIX.eliminarRolesInhabilitados ON LIL_MIX.rol
AFTER UPDATE AS
BEGIN

	--Se le debe quitar el rol inhabilitado a todos aquellos usuarios que lo posean

	DELETE FROM LIL_MIX.rolxusuario
	WHERE rol_id IN (SELECT rol_id FROM inserted WHERE rol_habilitado = 0)

END

---------------------------------------  AMB DE PROVEEDOR  ---------------------------------------

--3) No se puede ingresar un proveedor con el mismo CUIT y/o Razon Social

CREATE TRIGGER LIL_MIX.proveedorExistente ON LIL_MIX.proveedor
INSTEAD OF INSERT AS
BEGIN

	BEGIN TRY
		BEGIN TRAN

		--La razón social y cuit son datos únicos, por ende no pueden existir 2 proveedores con la misma razón social y cuit

		IF (SELECT proveedor_rs FROM inserted) IN (SELECT proveedor_rs FROM LIL_MIX.proveedor)

		--El sistema deberá controlar esta restricción e informar debidamente al usuario ante alguna anomalía.

			THROW 51000, 'Razon social ya existente', 1

		IF (SELECT proveedor_cuit FROM inserted) IN (SELECT proveedor_cuit FROM LIL_MIX.proveedor)

			THROW 51000, 'CUIT ya existente', 1

		INSERT INTO LIL_MIX.proveedor
		SELECT * FROM inserted

		COMMIT

	END TRY

	BEGIN CATCH

		ROLLBACK

	END CATCH

END
