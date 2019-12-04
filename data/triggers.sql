
------------------::::::::::::::::::::::  TRIGGERS  ::::::::::::::::::::::------------------

---------------------------------------  AMB DE ROL  ---------------------------------------

--1) No puede haber un rol con funcionalidades repetidas

IF OBJECT_ID('LIL_MIX.noRepetirFuncionalidadesEnUnRol') IS NOT NULL
  DROP TRIGGER LIL_MIX.noRepetirFuncionalidadesEnUnRol
GO

CREATE TRIGGER LIL_MIX.noRepetirFuncionalidadesEnUnRol ON LIL_MIX.funcionalidadxrol
INSTEAD OF INSERT AS
BEGIN
	DECLARE @funcionalidad_id INT,
		@rol_id INT

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
GO

--2)

IF OBJECT_ID('LIL_MIX.eliminarRolesInhabilitados') IS NOT NULL
  DROP TRIGGER LIL_MIX.eliminarRolesInhabilitados
GO

CREATE TRIGGER LIL_MIX.eliminarRolesInhabilitados ON LIL_MIX.rol
AFTER UPDATE AS
BEGIN

	--Se le debe quitar el rol inhabilitado a todos aquellos usuarios que lo posean

	DELETE FROM LIL_MIX.rolxusuario
	WHERE rol_id IN (SELECT rol_id FROM inserted WHERE rol_habilitado = 0)

END

----------------------------------------- CARGA DE CRÉDITO ----------------------------------------------

-- 3)

IF OBJECT_ID('LIL_MIX.cargarCreditoAlCliente') IS NOT NULL
  DROP TRIGGER LIL_MIX.cargarCreditoAlCliente
GO

CREATE TRIGGER cargarCreditoAlCliente ON cargaDeCredito
AFTER INSERT AS
BEGIN
	DECLARE @monto_cargado INT,
		@cliente_id INT

	DECLARE cursorCreditoInsertado CURSOR FOR
	SELECT carga_monto, carga_id_cliente FROM inserted

	OPEN cursorCreditoInsertado

	FETCH NEXT FROM cursorCreditoInsertado
	INTO @monto_cargado, @cliente_id

	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE cliente
		SET cliente_credito = cliente_credito + @monto_cargado
		WHERE cliente_id = @cliente_id

		FETCH NEXT FROM cursorCreditoInsertado
		INTO @monto_cargado, @cliente_id
	END

	CLOSE cursorCreditoInsertado
	DEALLOCATE cursorCreditoInsertado
END
GO
