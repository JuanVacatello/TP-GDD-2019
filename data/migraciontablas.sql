--use GD2C2019

--MIGRACION

-- CREATE TABLE LIL_MIX.usuario ( usuario_id INT NOT NULL IDENTITY(1000,1) PRIMARY KEY,
--				 usuario_nombre VARCHAR(255) NOT NULL UNIQUE,
--				 usuario_password VARCHAR(255) NOT NULL,
--				 usuario_intentos TINYINT DEFAULT 0,
--				 usuario_habilitado BIT DEFAULT 1
--				)

INSERT INTO LIL_MIX.usuario(usuario_nombre, usuario_password)
SELECT DISTINCT Cli_Nombre+'_'+Cli_Apellido , Cli_Dni
FROM gd_esquema.Maestra

INSERT INTO LIL_MIX.usuario(usuario_nombre, usuario_password)
SELECT DISTINCT Provee_Telefono , Provee_CUIT
FROM gd_esquema.Maestra


-- CREATE TABLE LIL_MIX.rolxusuario ( rol_id INT,
--				   usuario_id INT,
--				   PRIMARY KEY (rol_id, usuario_id),
--				   FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
--				   FOREIGN KEY (usuario_id) REFERENCES LIL_MIX.usuario(usuario_id)
--				   )

INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
SELECT 3, (SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = Provee_Telefono)
FROM gd_esquema.Maestra

INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
SELECT 2, (SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = Cli_Nombre+'_'+Cli_Apellido)
FROM gd_esquema.Maestra


--CREATE TABLE LIL_MIX.direccion ( direccion_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
--				direccion_calle VARCHAR(255),
--				direccion_piso TINYINT,
--				direccion_dpto VARCHAR(255),
--				direccion_ciudad VARCHAR(255),
--				)

INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_ciudad)
SELECT Cli_Direccion, Cli_Ciudad
FROM gd_esquema.Maestra
GROUP BY Cli_Direccion, Cli_Ciudad

INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_ciudad)
SELECT Provee_Dom, Provee_Ciudad
FROM gd_esquema.Maestra
GROUP BY Provee_Dom, Provee_Ciudad


--CREATE TABLE LIL_MIX.proveedor ( proveedor_id INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
--				proveedor_direccion_id INT FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
--				proveedor_telefono INT,
--				proveedor_cuit VARCHAR(13),
--				proveedor_rubro VARCHAR(255),
--				proveedor_mail VARCHAR(255),
--				proveedor_cp SMALLINT,
--				proveedor_nombre_contacto VARCHAR(255),
--				proveedor_rs VARCHAR(255),
--				proveedor_habilitado BIT,
--				proveedor_usuario_id INT FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id)
--				)


INSERT INTO LIL_MIX.proveedor ( proveedor_direccion_id, proveedor_telefono, proveedor_cuit, proveedor_rubro, proveedor_mail, 
	proveedor_rs, proveedor_habilitado, proveedor_usuario_id)
SELECT (SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = Provee_Dom AND direccion_ciudad = Provee_Ciudad),
	Provee_Telefono, Provee_CUIT, Provee_Rubro, Provee_RS+'@gmail.com', Provee_RS, 1,
	(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = Provee_Telefono)
FROM gd_esquema.Maestra
WHERE Provee_CUIT IS NOT NULL -- Para que solo aparezan los proveedores y no clientes
group by Provee_CUIT, Provee_Telefono, Provee_Rubro, Provee_RS, Provee_Dom


-- CREATE TABLE LIL_MIX.cliente ( cliente_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
--					cliente_nombre VARCHAR(255) ,
--					cliente_apellido VARCHAR(255) ,
--					cliente_direccion_id INT FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
--					cliente_mail VARCHAR(255),
--					cliente_telefono INT,
--					cliente_fecha_nacimiento DATETIME,
--					cliente_cp SMALLINT ,
--					cliente_dni INT,
--					cliente_credito BIGINT,
--					cliente_habilitado BIT,
--					cliente_usuario_id INT FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id)
--					)

INSERT INTO LIL_MIX.cliente (cliente_nombre , cliente_apellido , cliente_direccion_id, cliente_mail,
			cliente_telefono , cliente_fecha_nacimiento , cliente_dni , cliente_credito , cliente_habilitado, cliente_usuario_id)
SELECT Cli_Nombre , Cli_Apellido , (SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = Cli_Direccion AND direccion_ciudad = Cli_Ciudad),
	   Cli_Mail , Cli_Telefono , Cli_Fecha_Nac , Cli_Dni , SUM(Carga_Credito), 1,
	   (SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = Cli_Nombre+'_'+Cli_Apellido)
FROM gd_esquema.Maestra
WHERE Cli_Dni IS NOT NULL
GROUP BY Cli_Nombre , Cli_Apellido , Cli_Mail , Cli_Telefono , Cli_Fecha_Nac , Cli_Dni , Cli_Direccion


-- CREATE TABLE LIL_MIX.tarjeta ( tarjeta_numero BIGINT NOT NULL PRIMARY KEY,
--				tarjeta_tipo VARCHAR(30),
--				tarjeta_fecha_vencimiento DATETIME,
--				tarjeta_id_cliente INT
--				)

INSERT INTO LIL_MIX.tarjeta ( tarjeta_numero, tarjeta_tipo, tarjeta_fecha_vencimiento, tarjeta_id_cliente)
VALUES ( 12345678901234, 'VISA', convert(datetime,'18-06-22 10:34:09 PM',5),
	(SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_mail LIKE 'marga@gmail.com')) -- Únicamente Marga realizó cargas


-- CREATE TABLE LIL_MIX.cargaDeCredito ( carga_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
--				      carga_fecha DATETIME NOT NULL,
--				      carga_id_cliente INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
--				      carga_tipo_de_pago INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.tipoDePago(tipo_de_pago_id), 
--				      carga_monto BIGINT NOT NULL,
--				      carga_tarjeta_numero BIGINT FOREIGN KEY REFERENCES LIL_MIX.tarjeta(tarjeta_numero) 
--				      )

INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_id_cliente, carga_tipo_de_pago, carga_monto, carga_tarjeta_numero)
SELECT Carga_Fecha, (SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_dni = Cli_Dni), 
	(SELECT tipo_de_pago_id FROM LIL_MIX.tipoDePago WHERE tipo_de_pago_descripcion = Tipo_Pago_Desc),
	Carga_Credito, 12345678901234 -- Número de tarjeta de Marga, fue la única que realizó cargas
WHERE Tipo_Pago_Desc LIKE 'Crédito' AND Carga_Fecha IS NOT NULL
FROM gd_esquema.Maestra 

INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_id_cliente, carga_tipo_de_pago, carga_monto)
SELECT Carga_Fecha, (SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_dni = Cli_Dni), 
	(SELECT tipo_de_pago_id FROM LIL_MIX.tipoDePago WHERE tipo_de_pago_descripcion = Tipo_Pago_Desc), Carga_Credito
WHERE Tipo_Pago_Desc LIKE 'Efectivo' AND Carga_Fecha IS NOT NULL
FROM gd_esquema.Maestra


--CREATE TABLE LIL_MIX.oferta ( oferta_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
--								oferta_precio_oferta INT,
--								oferta_precio_lista INT,
--								oferta_fecha_publicacion DATETIME,
--								oferta_fecha_vencimiento DATETIME,
--								oferta_decripcion VARCHAR(255),
--								oferta_stock INT,
--								oferta_proveedor_id INT FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
--								oferta_restriccion_compra TINYINT,
--								oferta_codigo VARCHAR(255)
--								)

INSERT INTO LIL_MIX.oferta (oferta_proveedor_id, oferta_precio_oferta , oferta_precio_lista, oferta_fecha_publicacion ,
							oferta_fecha_vencimiento , oferta_decripcion , oferta_stock , oferta_codigo)
SELECT (SELECT proveedor_id FROM LIL_MIX.proveedor WHERE proveedor_cuit = Provee_CUIT), 
	Oferta_Precio, Oferta_Precio_Ficticio, Oferta_Fecha, Oferta_Fecha_Venc , Oferta_Descripcion , Oferta_Cantidad , Oferta_Codigo
FROM gd_esquema.Maestra
WHERE Oferta_Fecha IS NOT NULL
GROUP BY Oferta_Codigo


-- CREATE TABLE LIL_MIX.factura ( factura_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
--							   factura_numero INT,
--							   factura_proveedor_id INT FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
--							   factura_fecha_inicio DATETIME,
--							   factura_fecha_fin DATETIME,
--							   factura_importe FLOAT
--							   )

INSERT INTO LIL_MIX.factura (factura_numero , factura_proveedor_id, factura_fecha_inicio, factura_fecha_fin, factura_importe)
SELECT Factura_Nro , (SELECT proveedor_id FROM LIL_MIX.proveedor WHERE proveedor_cuit = Provee_CUIT) , MIN(Oferta_Fecha_Compra) , Factura_Fecha , SUM(Oferta_Precio) 
FROM gd_esquema.Maestra
WHERE Factura_Nro IS NOT NULL
GROUP BY Factura_Nro , Factura_Fecha , Provee_CUIT
