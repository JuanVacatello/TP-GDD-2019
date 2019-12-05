USE GD2C2019

------DROPS FKs

DECLARE cursor_tablas CURSOR FOR
SELECT 'ALTER TABLE [' +  OBJECT_SCHEMA_NAME(parent_object_id) +'].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + ']'
FROM sys.foreign_keys

DECLARE @sql nvarchar(255)
OPEN cursor_tablas
FETCH NEXT FROM cursor_tablas INTO @sql

WHILE @@FETCH_STATUS = 0
    BEGIN
    execute sp_executesql @sql
    FETCH NEXT FROM cursor_tablas INTO @sql
    END
CLOSE cursor_tablas
DEALLOCATE cursor_tablas
GO

------DROPS TABLAS

IF OBJECT_ID('LIL_MIX.usuario') IS NOT NULL
  DROP TABLE LIL_MIX.usuario
  GO

IF OBJECT_ID('LIL_MIX.direccion') IS NOT NULL
  DROP TABLE LIL_MIX.direccion
  GO

IF OBJECT_ID('LIL_MIX.proveedor') IS NOT NULL
  DROP TABLE LIL_MIX.proveedor
  GO

IF OBJECT_ID('LIL_MIX.oferta') IS NOT NULL
  DROP TABLE LIL_MIX.oferta
 GO

IF OBJECT_ID('LIL_MIX.cliente') IS NOT NULL
  DROP TABLE LIL_MIX.cliente
 GO

IF OBJECT_ID('LIL_MIX.compra') IS NOT NULL
  DROP TABLE LIL_MIX.compra
 GO

IF OBJECT_ID('LIL_MIX.factura') IS NOT NULL
  DROP TABLE LIL_MIX.factura
 GO

IF OBJECT_ID('LIL_MIX.cupon') IS NOT NULL
  DROP TABLE LIL_MIX.cupon
 GO

IF OBJECT_ID('LIL_MIX.rol') IS NOT NULL
  DROP TABLE LIL_MIX.rol
 GO

IF OBJECT_ID('LIL_MIX.funcionalidad') IS NOT NULL
  DROP TABLE LIL_MIX.funcionalidad
 GO

IF OBJECT_ID('LIL_MIX.rolxusuario') IS NOT NULL
  DROP TABLE LIL_MIX.rolxusuario
 GO

IF OBJECT_ID('LIL_MIX.funcionalidadxrol') IS NOT NULL
  DROP TABLE LIL_MIX.funcionalidadxrol
 GO

IF OBJECT_ID('LIL_MIX.tarjeta') IS NOT NULL
  DROP TABLE LIL_MIX.tarjeta
 GO

IF OBJECT_ID('LIL_MIX.tipoDePago') IS NOT NULL
  DROP TABLE LIL_MIX.tipoDePago
 GO

IF OBJECT_ID('LIL_MIX.cargaDeCredito') IS NOT NULL
  DROP TABLE LIL_MIX.cargaDeCredito
 GO 
 
IF OBJECT_ID('LIL_MIX.semestre') IS NOT NULL
  DROP TABLE LIL_MIX.semestre
  GO 

-----DROP ESQUEMA

IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'LIL_MIX')
    DROP SCHEMA LIL_MIX
GO

--CREACION ESQUEMA

CREATE SCHEMA LIL_MIX AUTHORIZATION  gdCupon2019 
GO


--CREACION DE TABLAS 

CREATE TABLE LIL_MIX.usuario ( usuario_id INT NOT NULL IDENTITY(1000,1) PRIMARY KEY,
			                   usuario_nombre VARCHAR(255) NOT NULL UNIQUE,
	                           usuario_password VARCHAR(255) NOT NULL,
			                   usuario_intentos TINYINT DEFAULT 0,
			                   usuario_habilitado BIT DEFAULT 1 )
									   					 
CREATE TABLE LIL_MIX.direccion ( direccion_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                 direccion_calle VARCHAR(255),
				                 direccion_piso TINYINT,
				                 direccion_dpto CHAR(1),
				                 direccion_ciudad VARCHAR(255) )

CREATE TABLE LIL_MIX.proveedor ( proveedor_id INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
				                 proveedor_direccion_id INT FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
				                 proveedor_telefono INT,
				                 proveedor_cuit VARCHAR(13) UNIQUE,
				                 proveedor_rubro VARCHAR(255),
				                 proveedor_mail VARCHAR(255),
				                 proveedor_cp SMALLINT,
				                 proveedor_nombre_contacto VARCHAR(255),
				                 proveedor_rs VARCHAR(255) UNIQUE,
				                 proveedor_habilitado BIT DEFAULT 1,
				                 proveedor_usuario_id INT FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id) )

CREATE TABLE LIL_MIX.oferta ( oferta_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			                  oferta_codigo VARCHAR(255) NOT NULL,
			                  oferta_precio_oferta INT NOT NULL,
			                  oferta_precio_lista INT NOT NULL,
			                  oferta_fecha_publicacion DATETIME NOT NULL,
			                  oferta_fecha_vencimiento DATETIME NOT NULL,
			                  oferta_decripcion VARCHAR(255) NOT NULL,
			                  oferta_stock INT NOT NULL,
			                  oferta_proveedor_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
			                  oferta_restriccion_compra TINYINT NOT NULL )

CREATE TABLE LIL_MIX.cliente ( cliente_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, --el cliente id comenzará en 1 y se incrementará en 1 a medida que se vayan agregando nuevos clientes
			                   cliente_nombre VARCHAR(255) NOT NULL ,
			                   cliente_apellido VARCHAR(255) NOT NULL , 
			                   cliente_direccion_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
			                   cliente_mail VARCHAR(255) NOT NULL,
			                   cliente_telefono INT NOT NULL,
			                   cliente_fecha_nacimiento DATETIME NOT NULL,
			                   cliente_cp SMALLINT ,
			                   cliente_dni INT NOT NULL,
			                   cliente_credito BIGINT ,
			                   cliente_habilitado BIT DEFAULT 1,
			                   cliente_usuario_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id) ) 

CREATE TABLE LIL_MIX.compra ( compra_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			                  compra_oferta_numero INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.oferta(oferta_id),
			                  compra_oferta_descr VARCHAR(255) NOT NULL,
			                  compra_cliente_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
			                  compra_cantidad INT NOT NULL,
			                  compra_fecha DATETIME NOT NULL )

CREATE TABLE LIL_MIX.factura ( factura_id INT NOT NULL IDENTITY(1000,1) PRIMARY KEY,
			                   factura_proveedor_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
			                   factura_fecha_inicio DATETIME NOT NULL,
			                   factura_fecha_fin DATETIME NOT NULL,
			                   factura_importe FLOAT NOT NULL )

CREATE TABLE LIL_MIX.cupon ( cupon_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			                 cupon_fecha_vencimiento DATETIME NOT NULL,
			                 cupon_fecha_consumo DATETIME,
			                 cupon_compra_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.compra(compra_id),
			                 cupon_cliente_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id) )

CREATE TABLE LIL_MIX.rol ( rol_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			               rol_nombre VARCHAR(30) NOT NULL,
			               rol_habilitado BIT DEFAULT 1 )

CREATE TABLE LIL_MIX.funcionalidad ( funcionalidad_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                     funcionalidad_descripcion VARCHAR(30) NOT NULL )

CREATE TABLE LIL_MIX.rolxusuario ( rol_id INT NOT NULL,
				                   usuario_id INT NOT NULL,
				                   PRIMARY KEY (rol_id, usuario_id),
				                   FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
				                   FOREIGN KEY (usuario_id) REFERENCES LIL_MIX.usuario(usuario_id) )

CREATE TABLE LIL_MIX.funcionalidadxrol ( rol_id INT NOT NULL,
					                     funcionalidad_id INT NOT NULL,
					                     PRIMARY KEY (rol_id, funcionalidad_id),
					                     FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
					                     FOREIGN KEY (funcionalidad_id) REFERENCES LIL_MIX.funcionalidad(funcionalidad_id) )

CREATE TABLE LIL_MIX.tarjeta ( tarjeta_numero BIGINT NOT NULL PRIMARY KEY,
			                   tarjeta_tipo VARCHAR(30) NOT NULL,
			                   tarjeta_fecha_vencimiento DATETIME NOT NULL,
			                   tarjeta_id_cliente INT NOT NULL ) --aca deberia de ser FK??

CREATE TABLE LIL_MIX.tipoDePago ( tipo_de_pago_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, --1, 2, 3
				                  tipo_de_pago_descripcion VARCHAR(30) NOT NULL ) --EFECTIVO, CREDITO O DEBITO

CREATE TABLE LIL_MIX.cargaDeCredito ( carga_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                      carga_fecha DATETIME NOT NULL,
				                      carga_id_cliente INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
				                      carga_tipo_de_pago INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.tipoDePago(tipo_de_pago_id),
				                      carga_monto BIGINT NOT NULL,
				                      carga_tarjeta_numero BIGINT FOREIGN KEY REFERENCES LIL_MIX.tarjeta(tarjeta_numero) )

CREATE TABLE LIL_MIX.semestre ( semestre_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                semestre_fecha_inicio VARCHAR(5) NOT NULL,
				                semestre_fecha_fin VARCHAR(5) NOT NULL )

                                            
											
											               /*Creacion de datos*/

--                        Funcionalidades

-- 1) ABM ROL
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('ABM de ROL')
GO
-- 2) Registro de usuario
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Registro de Usuario')
GO
-- 3) ABM CLIENTE.
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('ABM de CLIENTE')
GO
-- 4) ABM PROVEEDOR.
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('ABM de PROVEEDOR')
GO
-- 5) Carga de credito
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Carga de credito')
GO
-- 6) Cambio de contraseña
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Cambio de contraseña')
GO
-- 7) Baja de usuario
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Baja de usuario')
GO
-- 8) Confeccion y publicacion de oferta
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Conf. y publ. de oferta')
GO
-- 9) Comprar oferta
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Comprar oferta')
GO
-- 10) Entrega
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Entrega')
GO
-- 11) Facturacion a proveedor
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Facturacion a proveedor')
GO
-- 12) Listado Estadístico
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descripcion) VALUES ('Listado Estadistico')
GO

--                             Roles

-- Debe tenerse en cuenta, que actualmente existen 3 roles, Proveedor, Administrativo, Cliente. 

INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('ADMINISTRATIVO')
GO
INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('CLIENTE')
GO
INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('PROVEEDOR')
GO

--                          funcionalidadxrol

-- Un rol posee un conjunto de funcionalidades y las mismas no pueden estar repetidas dentro de un rol en particular. 

-- Funciones Administrador
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,1)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,3)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,4)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,5)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,6)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,7)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,8)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,11)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,12) --No sabemos quien tiene esa función

-- Funciones Cliente
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,2)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,5)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,6)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,9)

-- Funciones Proveedor
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,2)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,6)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,8)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,10)

--                       Listado de semestres

INSERT INTO LIL_MIX.semestre(semestre_fecha_inicio, semestre_fecha_fin) VALUES ('01-01', '30-06')
INSERT INTO LIL_MIX.semestre(semestre_fecha_inicio, semestre_fecha_fin) VALUES ('01-07', '31-12')
GO

--                        Formas de pago

INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Efectivo')
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Crédito')
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Debito')

SELECT * FROM LIL_MIX.funcionalidad
SELECT * FROM LIL_MIX.rol
SELECT * FROM LIL_MIX.funcionalidadxrol
SELECT * FROM LIL_MIX.semestre
SELECT * FROM LIL_MIX.tipoDePago
