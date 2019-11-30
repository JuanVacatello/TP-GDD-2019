--use GD2C2019

--CREACION DE ESQUEMA

--IF OBJECT_ID('LIL_MIX.usuario') IS NOT NULL
  --DROP TABLE LIL_MIX.usuario

CREATE SCHEMA LIL_MIX AUTHORIZATION  gdCupon2019 

--CREACION DE TABLAS 

IF OBJECT_ID('LIL_MIX.usuario') IS NOT NULL
  DROP TABLE LIL_MIX.usuario

IF OBJECT_ID('LIL_MIX.direccion') IS NOT NULL
  DROP TABLE LIL_MIX.direccion

IF OBJECT_ID('LIL_MIX.proveedor') IS NOT NULL
  DROP TABLE LIL_MIX.proveedor

IF OBJECT_ID('LIL_MIX.oferta') IS NOT NULL
  DROP TABLE LIL_MIX.oferta

IF OBJECT_ID('LIL_MIX.cliente') IS NOT NULL
  DROP TABLE LIL_MIX.cliente

IF OBJECT_ID('LIL_MIX.compra') IS NOT NULL
  DROP TABLE LIL_MIX.compra

IF OBJECT_ID('LIL_MIX.factura') IS NOT NULL
  DROP TABLE LIL_MIX.factura

IF OBJECT_ID('LIL_MIX.cupon') IS NOT NULL
  DROP TABLE LIL_MIX.cupon

IF OBJECT_ID('LIL_MIX.rol') IS NOT NULL
  DROP TABLE LIL_MIX.rol

IF OBJECT_ID('LIL_MIX.funcionalidad') IS NOT NULL
  DROP TABLE LIL_MIX.funcionalidad

IF OBJECT_ID('LIL_MIX.rolxusuario') IS NOT NULL
  DROP TABLE LIL_MIX.rolxusuario

IF OBJECT_ID('LIL_MIX.funcionalidadxrol') IS NOT NULL
  DROP TABLE LIL_MIX.funcionalidadxrol

IF OBJECT_ID('LIL_MIX.tarjeta') IS NOT NULL
  DROP TABLE LIL_MIX.tarjeta

IF OBJECT_ID('LIL_MIX.tipoDePago') IS NOT NULL
  DROP TABLE LIL_MIX.tipoDePago

IF OBJECT_ID('LIL_MIX.cargaDeCredito') IS NOT NULL
  DROP TABLE LIL_MIX.cargaDeCredito
  
--CREACION DE TABLAS 

CREATE TABLE LIL_MIX.usuario ( usuario_id INT NOT NULL IDENTITY(1000,1) PRIMARY KEY,
				usuario_nombre VARCHAR(255) NOT NULL UNIQUE,
				usuario_password VARCHAR(255) NOT NULL,
				usuario_intentos TINYINT,
				usuario_habilitado BIT
				)
									   					 
CREATE TABLE LIL_MIX.direccion ( direccion_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				direccion_calle VARCHAR(255),
				direccion_piso TINYINT,
				direccion_dpto CHAR(1),
				direccion_ciudad VARCHAR(255)
				)

CREATE TABLE LIL_MIX.proveedor ( proveedor_id INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
				proveedor_direccion_id INT FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
				proveedor_telefono INT,
				proveedor_cuit VARCHAR(13) UNIQUE,
				proveedor_rubro VARCHAR(255),
				proveedor_mail VARCHAR(255),
				proveedor_cp SMALLINT,
				proveedor_nombre_contacto VARCHAR(255),
				proveedor_rs VARCHAR(255) UNIQUE,
				proveedor_habilitado BIT,
				proveedor_usuario_id INT FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id)
				)

CREATE TABLE LIL_MIX.oferta ( oferta_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				oferta_precio_oferta INT,
				oferta_precio_lista INT,
				oferta_fecha_publicacion DATETIME,
				oferta_fecha_vencimiento DATETIME,
				oferta_decripcion VARCHAR(255),
				oferta_stock INT,
				oferta_proveedor_id INT FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
				oferta_restriccion_compra TINYINT,
				oferta_codigo VARCHAR(255)
				)

CREATE TABLE LIL_MIX.cliente ( cliente_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, --el cliente id comenzará en 1 y se incrementará en 1 a medida que se vayan agregando nuevos clientes
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

CREATE TABLE LIL_MIX.compra ( compra_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				compra_oferta_id INT FOREIGN KEY REFERENCES LIL_MIX.oferta(oferta_id) ,
				compra_cliente_id INT FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
				compra_cantidad INT,
				compra_fecha DATETIME
				)

CREATE TABLE LIL_MIX.factura ( factura_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				factura_numero INT,
				factura_proveedor_id INT FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
				factura_fecha_inicio DATETIME,
				factura_fecha_fin DATETIME,
				factura_compra_id INT FOREIGN KEY REFERENCES LIL_MIX.compra(compra_id),
				factura_importe FLOAT
				)

CREATE TABLE LIL_MIX.cupon ( cupon_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				cupon_fecha_vencimiento DATETIME,
				cupon_fecha_consumo DATETIME,
				cupon_compra_id INT FOREIGN KEY REFERENCES LIL_MIX.compra(compra_id),
				cupon_cliente_id INT FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id)
				)

CREATE TABLE LIL_MIX.rol ( rol_id INT NOT NULL PRIMARY KEY,
			   rol_nombre VARCHAR(30) NOT NULL,
			   rol_habilitado BIT
			   )

CREATE TABLE LIL_MIX.funcionalidad ( funcionalidad_id VARCHAR(30) NOT NULL PRIMARY KEY,
					 funcionalidad_descipcion VARCHAR(30)
					 )

CREATE TABLE LIL_MIX.rolxusuario ( rol_id INT,
				  usuario_id INT,
				  PRIMARY KEY (rol_id, usuario_id),
				  FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
				  FOREIGN KEY (usuario_id) REFERENCES LIL_MIX.usuario(usuario_id)
				  )

CREATE TABLE LIL_MIX.funcionalidadxrol ( rol_id INT,
					 funcionalidad_id VARCHAR(30),
					 PRIMARY KEY (rol_id, funcionalidad_id),
					 FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
					 FOREIGN KEY (funcionalidad_id) REFERENCES LIL_MIX.funcionalidad(funcionalidad_id)
					 )

CREATE TABLE LIL_MIX.tarjeta ( tarjeta_numero INT NOT NULL PRIMARY KEY,
				tarjeta_tipo VARCHAR(30),
				tarjeta_fecha_vencimiento DATETIME,
				tarjeta_id_cliente INT
				)

CREATE TABLE LIL_MIX.tipoDePago ( tipo_de_pago VARCHAR(30) NOT NULL PRIMARY KEY, --CHEQUEAR PK (TODAVIA NO EJECUTAMOS)
				  tipo_de_pago_descripcion VARCHAR(30),
				  tipo_de_pago_descuento INT,
				  tipo_de_pago_tarjeta_numero INT FOREIGN KEY REFERENCES LIL_MIX.tarjeta(tarjeta_numero)
				  )

CREATE TABLE LIL_MIX.cargaDeCredito ( carga_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
					carga_fecha DATETIME,
					carga_id_cliente INT FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
					carga_tipo_de_pago VARCHAR(30) FOREIGN KEY REFERENCES LIL_MIX.tipoDePago(tipo_de_pago), --TODAVIA NO EJECUTAMOS
					carga_monto BIGINT
					)
