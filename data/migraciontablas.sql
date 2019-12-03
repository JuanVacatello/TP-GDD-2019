--use GD2C2019

--MIGRACION

--CREATE TABLE LIL_MIX.direccion ( direccion_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
--								 direccion_calle VARCHAR(255),
--								 direccion_piso TINYINT,
--								 direccion_dpto VARCHAR(255),
--								 direccion_ciudad VARCHAR(255),
--								 )

INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_ciudad)
SELECT Cli_Direccion, Cli_Ciudad
FROM gd_esquema.Maestra
GROUP BY Cli_Direccion, Cli_Ciudad

INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_ciudad)
SELECT Provee_Dom, Provee_Ciudad
FROM gd_esquema.Maestra
GROUP BY Provee_Dom, Provee_Ciudad

--CREATE TABLE LIL_MIX.proveedor ( proveedor_id INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
--								 proveedor_direccion_id INT FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
--								 proveedor_telefono INT,
--								 proveedor_cuit VARCHAR(13),
--								 proveedor_rubro VARCHAR(255),
--								 proveedor_mail VARCHAR(255),
--								 proveedor_cp SMALLINT,
--								 proveedor_nombre_contacto VARCHAR(255),
--								 proveedor_rs VARCHAR(255),
--								 proveedor_habilitado BIT,
--								 proveedor_usuario_id INT FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id)
--								 )


INSERT INTO LIL_MIX.proveedor ( proveedor_direccion_id, proveedor_telefono, proveedor_cuit, proveedor_rubro , proveedor_rs, proveedor_habilitado)
SELECT (SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle LIKE Provee_Dom),
		Provee_Telefono, Provee_CUIT, Provee_Rubro, Provee_RS, 1
FROM gd_esquema.Maestra
WHERE Provee_CUIT IS NOT NULL --Para que solo aparezan los provvedores y no clientes
group by Provee_CUIT, Provee_Telefono, Provee_Rubro, Provee_RS, Provee_Dom

--CREATE TABLE LIL_MIX.oferta ( oferta_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
--							  oferta_precio_oferta INT,
--							  oferta_precio_lista INT,
--							  oferta_fecha_publicacion DATETIME,
--							  oferta_fecha_vencimiento DATETIME,
--							  oferta_decripcion VARCHAR(255),
--							  oferta_stock INT,
--							  oferta_proveedor_id INT FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
--							  oferta_restriccion_compra TINYINT,
--							  oferta_codigo VARCHAR(255)
--							  )

INSERT INTO LIL_MIX.oferta (oferta_proveedor_id, oferta_precio_oferta , oferta_precio_lista, oferta_fecha_publicacion ,
							oferta_fecha_vencimiento , oferta_decripcion , oferta_stock , oferta_codigo)
SELECT (SELECT proveedor_id FROM LIL_MIX.proveedor WHERE proveedor_cuit LIKE Provee_CUIT), Oferta_Precio, Oferta_Precio_Ficticio,
		Oferta_Fecha, Oferta_Fecha_Venc , Oferta_Descripcion , Oferta_Cantidad , Oferta_Codigo
FROM gd_esquema.Maestra
WHERE Oferta_Fecha IS NOT NULL

/*-CREATE TABLE LIL_MIX.cliente ( cliente_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, --el cliente id comenzar� en 1 y se incrementar� en 1 a medida que se vayan agregando nuevos clientes
						       cliente_nombre VARCHAR(255) ,
							   cliente_apellido VARCHAR(255) ,
							   cliente_direccion_id INT FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
							   cliente_mail VARCHAR(255),
							   cliente_telefono INT,
							   cliente_fecha_nacimiento DATETIME,
							   cliente_cp SMALLINT ,
							   cliente_dni INT,
							   cliente_credito BIGINT,
							   cliente_habilitado BIT,
							   cliente_user_id INT FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id)
							   )
*/

INSERT INTO LIL_MIX.cliente (cliente_nombre , cliente_apellido , cliente_direccion_id, cliente_mail,
							 cliente_telefono , cliente_fecha_nacimiento , cliente_dni , cliente_credito , cliente_habilitado )
SELECT Cli_Nombre , Cli_Apellido , (SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle LIKE Cli_Direccion),
	   Cli_Mail , Cli_Telefono , Cli_Fecha_Nac , Cli_Dni , SUM(Carga_Credito), 1
FROM gd_esquema.Maestra
WHERE Cli_Dni IS NOT NULL
GROUP BY Cli_Nombre , Cli_Apellido , Cli_Mail , Cli_Telefono , Cli_Fecha_Nac , Cli_Dni , Cli_Direccion

/* CREATE TABLE LIL_MIX.factura ( factura_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
							   factura_numero INT,
							   factura_proveedor_id INT FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
							   factura_fecha_inicio DATETIME,
							   factura_fecha_fin DATETIME,
							   factura_compra_id INT FOREIGN KEY REFERENCES LIL_MIX.compra(compra_id),
							   factura_importe FLOAT
							   )
*/

INSERT INTO LIL_MIX.factura (factura_numero , factura_proveedor_id, factura_fecha_inicio, factura_fecha_fin, factura_importe)
SELECT Factura_Nro , (SELECT proveedor_id FROM LIL_MIX.proveedor WHERE Provee_CUIT = proveedor_cuit) , MIN(Oferta_Fecha_Compra) , Factura_Fecha , SUM(Oferta_Precio) 
FROM gd_esquema.Maestra
WHERE Factura_Nro IS NOT NULL
GROUP BY Factura_Nro , Factura_Fecha , Provee_CUIT
ORDER BY Factura_Nro , Factura_Fecha


/*CREATE TABLE LIL_MIX.usuario ( usuario_id INT NOT NULL IDENTITY(1000,1) PRIMARY KEY,
				 usuario_nombre VARCHAR(255) NOT NULL UNIQUE,
				 usuario_password VARCHAR(255) NOT NULL,
				 usuario_intentos TINYINT DEFAULT 0,
				 usuario_habilitado BIT DEFAULT 1
				)
*/

INSERT INTO LIL_MIX.usuario(usuario_nombre, usuario_password)
SELECT DISTINCT Cli_Nombre+''+Cli_Apellido , Cli_Dni
FROM gd_esquema.Maestra


INSERT INTO LIL_MIX.usuario(usuario_nombre, usuario_password)
SELECT DISTINCT Provee_Telefono , Provee_CUIT
FROM gd_esquema.Maestra
