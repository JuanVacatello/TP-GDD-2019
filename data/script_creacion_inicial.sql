USE GD2C2019
GO
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

  
-----DROP PROCEDURES

IF OBJECT_ID('LIL_MIX.altaRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.altaRol
GO

IF OBJECT_ID('LIL_MIX.listadoRol') IS NOT NULL
  DROP PROCEDURE LIL_MIX.listadoRol
GO

IF OBJECT_ID('LIL_MIX.modificarRolNombre') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarRolNombre
GO

IF OBJECT_ID('LIL_MIX.modificarRolAgregarFuncionalidad') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarRolAgregarFuncionalidad
GO

IF OBJECT_ID('LIL_MIX.modificarRolEliminarFuncionalidad') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarRolEliminarFuncionalidad
GO

IF OBJECT_ID('LIL_MIX.habilitarRol') IS NOT NULL
	DROP PROCEDURE LIL_MIX.habilitarRol
 GO

IF OBJECT_ID('LIL_MIX.bajaRol') IS NOT NULL
	DROP PROCEDURE LIL_MIX.bajaRol
GO

IF OBJECT_ID('LIL_MIX.login') IS NOT NULL
	DROP PROCEDURE LIL_MIX.login
GO

IF OBJECT_ID('LIL_MIX.altaUsuarioCliente') IS NOT NULL
 DROP PROCEDURE LIL_MIX.altaUsuarioCliente
GO

IF OBJECT_ID('LIL_MIX.altaUsuarioProveedor') IS NOT NULL
  DROP PROCEDURE LIL_MIX.altaUsuarioProveedor
GO

IF OBJECT_ID('LIL_MIX.agregarRolAUsuario') IS NOT NULL
  DROP PROCEDURE LIL_MIX.agregarRolAUsuario
GO

IF OBJECT_ID('LIL_MIX.modificarContrasenia') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarContrasenia
GO

IF OBJECT_ID('LIL_MIX.darDeBajaUsuario') IS NOT NULL
  DROP PROCEDURE LIL_MIX.darDeBajaUsuario
GO

IF OBJECT_ID('LIL_MIX.bajaCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.bajaCliente
GO

IF OBJECT_ID('LIL_MIX.listadoClientes') IS NOT NULL
  DROP PROCEDURE LIL_MIX.listadoClientes
GO

IF OBJECT_ID('LIL_MIX.habilitarCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.habilitarCliente
GO

IF OBJECT_ID('LIL_MIX.modificarClienteNombre') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteNombre
GO

IF OBJECT_ID('LIL_MIX.modificarClienteApellido') IS NOT NULL
 DROP PROCEDURE LIL_MIX.modificarClienteApellido
GO

IF OBJECT_ID('LIL_MIX.modificarClienteDNI') IS NOT NULL
 DROP PROCEDURE LIL_MIX.modificarClienteDNI
GO

IF OBJECT_ID('LIL_MIX.modificarClienteMail') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteMail
GO
 
IF OBJECT_ID('LIL_MIX.modificarClienteTelefono') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteTelefono
GO
 
IF OBJECT_ID('LIL_MIX.modificarClienteFechaNacimiento') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteFechaNacimiento
GO

IF OBJECT_ID('LIL_MIX.modificarClienteCP') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteCP
GO

IF OBJECT_ID('LIL_MIX.modificarClienteCalleDirec') IS NOT NULL
 DROP PROCEDURE LIL_MIX.modificarClienteCalleDirec
GO

IF OBJECT_ID('LIL_MIX.modificarClientePisoDirec') IS NOT NULL
 DROP PROCEDURE LIL_MIX.modificarClientePisoDirec
GO

IF OBJECT_ID('LIL_MIX.modificarClienteDptoDirec') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteDptoDirec
GO

 IF OBJECT_ID('LIL_MIX.modificarClienteCiudad') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarClienteCiudad
GO

IF OBJECT_ID('LIL_MIX.bajaProveedor') IS NOT NULL
  DROP PROCEDURE LIL_MIX.bajaProveedor
GO

IF OBJECT_ID('LIL_MIX.listadoProveedores') IS NOT NULL
  DROP PROCEDURE LIL_MIX.listadoProveedores
GO

IF OBJECT_ID('LIL_MIX.habilitarProveedor') IS NOT NULL
  DROP PROCEDURE LIL_MIX.habilitarProveedor
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorRS') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarProveedorRS
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorMail') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarProveedorMail
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorTelefono') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarProveedorTelefono
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorCP') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarProveedorCP
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorCuit') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificarProveedorCuit
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorRubro') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarProveedorRubro
GO

IF OBJECT_ID('LIL_MIX.modificarProveedorNombreDeContacto') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarProveedorNombreDeContacto
GO

IF OBJECT_ID('LIL_MIX.modificarCalleDirecCliente') IS NOT NULL
  DROP PROCEDURE LIL_MIX.modificareCalleDirecCliente
GO 

IF OBJECT_ID('LIL_MIX.modificarPisoDirecCliente') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarPisoDirecCliente
GO

IF OBJECT_ID('LIL_MIX.modificarDptoDirecCliente') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarDptoDirecCliente
GO

IF OBJECT_ID('LIL_MIX.modificarCiudadCliente') IS NOT NULL
	DROP PROCEDURE LIL_MIX.modificarCiudadCliente
GO

IF OBJECT_ID('LIL_MIX.cargarCredito') IS NOT NULL
	DROP PROCEDURE LIL_MIX.cargarCredito
GO

IF OBJECT_ID('LIL_MIX.crearOferta') IS NOT NULL
	DROP PROCEDURE LIL_MIX.crearOferta
GO

IF OBJECT_ID('LIL_MIX.ofertasVigentesHastaDiaActual') IS NOT NULL
	DROP PROCEDURE LIL_MIX.ofertasVigentesHastaDiaActual
GO

IF OBJECT_ID('LIL_MIX.comprarOferta') IS NOT NULL
	DROP PROCEDURE LIL_MIX.comprarOferta
GO

IF OBJECT_ID('LIL_MIX.consumoDeOferta') IS NOT NULL
	DROP PROCEDURE LIL_MIX.consumoDeOferta
GO

IF OBJECT_ID('LIL_MIX.todasLasOfertasAdquiridas') IS NOT NULL
	DROP PROCEDURE LIL_MIX.todasLasOfertasAdquiridas
GO

IF OBJECT_ID('LIL_MIX.facturacionProveedor') IS NOT NULL
	DROP PROCEDURE LIL_MIX.facturacionProveedor
GO

IF OBJECT_ID('LIL_MIX.listadoEstadistico1') IS NOT NULL
	DROP PROCEDURE LIL_MIX.listadoEstadistico1
GO

IF OBJECT_ID('LIL_MIX.listadoEstadistico2') IS NOT NULL
	DROP PROCEDURE LIL_MIX.listadoEstadistico2
GO
-----DROP TRIGGERS

IF OBJECT_ID('LIL_MIX.noRepetirFuncionalidadesEnUnRol') IS NOT NULL
  DROP TRIGGER LIL_MIX.noRepetirFuncionalidadesEnUnRol
GO

IF OBJECT_ID('LIL_MIX.eliminarRolesInhabilitados') IS NOT NULL
  DROP TRIGGER LIL_MIX.eliminarRolesInhabilitados
GO

IF OBJECT_ID('LIL_MIX.cargarCreditoAlCliente') IS NOT NULL
  DROP TRIGGER LIL_MIX.cargarCreditoAlCliente
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
GO

CREATE TABLE LIL_MIX.direccion ( direccion_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				   direccion_calle VARCHAR(255),
				   direccion_piso TINYINT,
				   direccion_dpto CHAR(1),
				   direccion_ciudad VARCHAR(255) )
GO

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
GO

CREATE TABLE LIL_MIX.oferta ( oferta_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			           oferta_codigo VARCHAR(255) NOT NULL UNIQUE,
			           oferta_precio_oferta INT NOT NULL,
			           oferta_precio_lista INT NOT NULL,
			           oferta_fecha_publicacion DATETIME NOT NULL,
			           oferta_fecha_vencimiento DATETIME NOT NULL,
			           oferta_decripcion VARCHAR(255) NOT NULL,
			           oferta_stock INT NOT NULL,
			           oferta_proveedor_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
			            oferta_restriccion_compra INT NOT NULL )
GO

CREATE TABLE LIL_MIX.cliente ( cliente_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, --el cliente id comenzará en 1 y se incrementará en 1 a medida que se vayan agregando nuevos clientes
			                   cliente_nombre VARCHAR(255) NOT NULL ,
			                   cliente_apellido VARCHAR(255) NOT NULL ,
			                   cliente_direccion_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.direccion(direccion_id),
			                   cliente_mail VARCHAR(255) NOT NULL,
			                   cliente_telefono INT NOT NULL,
			                   cliente_fecha_nacimiento DATETIME NOT NULL,
			                   cliente_cp SMALLINT ,
			                   cliente_dni INT NOT NULL,
			                   cliente_credito BIGINT DEFAULT 200,
			                   cliente_habilitado BIT DEFAULT 1,
			                   cliente_usuario_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.usuario(usuario_id) )
GO

CREATE TABLE LIL_MIX.compra ( compra_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			                  compra_oferta_numero INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.oferta(oferta_id),
			                  compra_oferta_descr VARCHAR(255) NOT NULL,
			                  compra_cliente_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
			                  compra_cantidad INT NOT NULL,
			                  compra_fecha DATETIME NOT NULL )
GO

CREATE TABLE LIL_MIX.factura ( factura_id INT NOT NULL PRIMARY KEY,
			       factura_proveedor_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.proveedor(proveedor_id),
			       factura_fecha_inicio DATETIME NOT NULL,
			       factura_fecha_fin DATETIME NOT NULL,
			       factura_importe FLOAT NOT NULL )
GO

CREATE TABLE LIL_MIX.cupon ( cupon_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			                 cupon_fecha_vencimiento DATETIME NOT NULL,
			                 cupon_fecha_consumo DATETIME,
			                 cupon_compra_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.compra(compra_id),
			                 cupon_cliente_id INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id) )
GO

CREATE TABLE LIL_MIX.rol ( rol_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
			               rol_nombre VARCHAR(30) NOT NULL,
			               rol_habilitado BIT DEFAULT 1 )
GO

CREATE TABLE LIL_MIX.funcionalidad ( funcionalidad_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                     funcionalidad_descripcion VARCHAR(30) NOT NULL )
GO

CREATE TABLE LIL_MIX.rolxusuario ( rol_id INT NOT NULL,
				                   usuario_id INT NOT NULL,
				                   PRIMARY KEY (rol_id, usuario_id),
				                   FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
				                   FOREIGN KEY (usuario_id) REFERENCES LIL_MIX.usuario(usuario_id) )
GO

CREATE TABLE LIL_MIX.funcionalidadxrol ( rol_id INT NOT NULL,
					                     funcionalidad_id INT NOT NULL,
					                     PRIMARY KEY (rol_id, funcionalidad_id),
					                     FOREIGN KEY (rol_id) REFERENCES LIL_MIX.rol(rol_id),
					                     FOREIGN KEY (funcionalidad_id) REFERENCES LIL_MIX.funcionalidad(funcionalidad_id) )
GO

CREATE TABLE LIL_MIX.tarjeta ( tarjeta_numero BIGINT NOT NULL PRIMARY KEY,
			                   tarjeta_tipo VARCHAR(30) NOT NULL,
			                   tarjeta_fecha_vencimiento DATETIME NOT NULL,
			                   tarjeta_id_cliente INT NOT NULL,
							   FOREIGN KEY (tarjeta_id_cliente) REFERENCES LIL_MIX.cliente(cliente_id))
GO

CREATE TABLE LIL_MIX.tipoDePago ( tipo_de_pago_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, --1, 2, 3
				                  tipo_de_pago_descripcion VARCHAR(30) NOT NULL ) --EFECTIVO, CREDITO O DEBITO
GO

CREATE TABLE LIL_MIX.cargaDeCredito ( carga_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                      carga_fecha DATETIME NOT NULL,
				                      carga_id_cliente INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.cliente(cliente_id),
				                      carga_tipo_de_pago INT NOT NULL FOREIGN KEY REFERENCES LIL_MIX.tipoDePago(tipo_de_pago_id),
				                      carga_monto BIGINT NOT NULL,
				                      carga_tarjeta_numero BIGINT FOREIGN KEY REFERENCES LIL_MIX.tarjeta(tarjeta_numero) )
GO

CREATE TABLE LIL_MIX.semestre ( semestre_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
				                semestre_fecha_inicio VARCHAR(5) NOT NULL,
				                semestre_fecha_fin VARCHAR(5) NOT NULL )
GO



											               /*Creacion de datos*/

--                        Funcionalidades

-- 1) ABM ROL
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('ABM de ROL')
GO
-- 2) Registro de usuario
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Registro de Usuario')
GO
-- 3) ABM CLIENTE.
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('ABM de CLIENTE')
GO
-- 4) ABM PROVEEDOR.
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('ABM de PROVEEDOR')
GO
-- 5) Carga de credito
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Carga de credito')
GO
-- 6) Cambio de contraseña
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Cambio de contraseña')
GO
-- 7) Baja de usuario
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Baja de usuario')
GO
-- 8) Confeccion y publicacion de oferta
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Conf. y publ. de oferta')
GO
-- 9) Comprar oferta
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Comprar oferta')
GO
-- 10) Entrega
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Entrega')
GO
-- 11) Facturacion a proveedor
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Facturacion a proveedor')
GO
-- 12) Listado Estadístico
INSERT INTO LIL_MIX.funcionalidad(funcionalidad_descripcion) VALUES ('Listado Estadistico')
GO

--                             Roles

-- Debe tenerse en cuenta, que actualmente existen 3 roles, Proveedor, Administrativo, Cliente.

INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('ADMINISTRATIVO')
INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('CLIENTE')
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
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,9)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,10)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,11)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,12) --No sabemos quien tiene esa función
GO

-- Funciones Cliente
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,2)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,5)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,6)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (2,9)
GO

-- Funciones Proveedor
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,2)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,6)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,8)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (3,10)
GO

--                       Listado de semestres

INSERT INTO LIL_MIX.semestre(semestre_fecha_inicio, semestre_fecha_fin) VALUES ('01-01', '30-06')
INSERT INTO LIL_MIX.semestre(semestre_fecha_inicio, semestre_fecha_fin) VALUES ('01-07', '31-12')
GO

--                        Formas de pago

INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Efectivo')
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Crédito')
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Débito')
GO

--                        Usuario

INSERT INTO LIL_MIX.usuario(usuario_nombre, usuario_password)
SELECT DISTINCT Cli_Nombre+'_'+Cli_Apellido , HASHBYTES('SHA2_256', CONVERT(VARCHAR(255),Cli_Dni))
FROM gd_esquema.Maestra
GO

INSERT INTO LIL_MIX.usuario(usuario_nombre, usuario_password)
SELECT DISTINCT Provee_Telefono , HASHBYTES('SHA2_256', Provee_CUIT )
FROM gd_esquema.Maestra
WHERE Provee_Telefono IS NOT NULL
GO

--                        RolxUsuario

INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
SELECT 3, u.usuario_id
FROM gd_esquema.Maestra m JOIN LIL_MIX.usuario u ON (u.usuario_nombre = CONVERT(VARCHAR(255), m.Provee_Telefono))
GROUP BY usuario_id
GO

INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
SELECT 2, u.usuario_id
FROM gd_esquema.Maestra m JOIN LIL_MIX.usuario u ON (u.usuario_nombre = m.Cli_Nombre+'_'+m.Cli_Apellido)
GROUP BY usuario_id
GO

--                        Direccion

INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_ciudad)
SELECT Cli_Direccion, Cli_Ciudad
FROM gd_esquema.Maestra
GROUP BY Cli_Direccion, Cli_Ciudad
GO

INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_ciudad)
SELECT Provee_Dom, Provee_Ciudad
FROM gd_esquema.Maestra
WHERE Provee_Dom IS NOT NULL
GROUP BY Provee_Dom, Provee_Ciudad
GO

--                        Cliente

INSERT INTO LIL_MIX.cliente (cliente_nombre , cliente_apellido , cliente_direccion_id, cliente_mail,
			cliente_telefono , cliente_fecha_nacimiento , cliente_dni , cliente_credito , cliente_usuario_id)
SELECT Cli_Nombre , Cli_Apellido , (SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = Cli_Direccion AND direccion_ciudad = Cli_Ciudad),
	   Cli_Mail , Cli_Telefono , Cli_Fecha_Nac , Cli_Dni , SUM(COALESCE(Carga_Credito,0)),
	   (SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = Cli_Nombre+'_'+Cli_Apellido)
FROM gd_esquema.Maestra
WHERE Cli_Dni IS NOT NULL
GROUP BY Cli_Nombre , Cli_Apellido , Cli_Mail , Cli_Telefono , Cli_Fecha_Nac , Cli_Dni , Cli_Direccion, Cli_Ciudad
GO

--                        Proveedor

INSERT INTO LIL_MIX.proveedor ( proveedor_direccion_id, proveedor_telefono, proveedor_cuit, proveedor_rubro, proveedor_nombre_contacto,
	proveedor_rs, proveedor_usuario_id)
SELECT (SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = Provee_Dom AND direccion_ciudad = Provee_Ciudad),
	Provee_Telefono, Provee_CUIT, Provee_Rubro, Provee_RS, Provee_RS,
	(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = CONVERT(VARCHAR(255), Provee_Telefono))
FROM gd_esquema.Maestra
WHERE Provee_CUIT IS NOT NULL -- Para que solo aparezan los proveedores y no clientes
GROUP BY Provee_CUIT, Provee_Telefono, Provee_Rubro, Provee_RS, Provee_Dom, Provee_Ciudad
GO

--                        Oferta

INSERT INTO LIL_MIX.oferta (oferta_proveedor_id, oferta_precio_oferta , oferta_precio_lista, oferta_fecha_publicacion ,
			oferta_fecha_vencimiento , oferta_decripcion , oferta_stock , oferta_codigo, oferta_restriccion_compra)
SELECT (SELECT proveedor_id FROM LIL_MIX.proveedor WHERE proveedor_cuit = Provee_CUIT), Oferta_Precio, Oferta_Precio_Ficticio,
	Oferta_Fecha, Oferta_Fecha_Venc , Oferta_Descripcion , Oferta_Cantidad , SUBSTRING(Oferta_Codigo, 1, 10), 3
FROM gd_esquema.Maestra
WHERE Oferta_Fecha IS NOT NULL
GROUP BY SUBSTRING(Oferta_Codigo, 1, 10), Oferta_Precio, Oferta_Precio_Ficticio, Oferta_Fecha, Oferta_Fecha_Venc ,
		Oferta_Descripcion , Oferta_Cantidad , Provee_Cuit
GO

--                        Tarjeta

INSERT INTO LIL_MIX.tarjeta ( tarjeta_numero, tarjeta_tipo, tarjeta_fecha_vencimiento, tarjeta_id_cliente)
VALUES ( 12345678901234, 'VISA', convert(datetime,'18-06-22 12:0:00 AM',5),
	(SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_mail LIKE 'marga@gmail.com')) -- Únicamente Marga realizó cargas
GO

--                        CargaCredito

INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_id_cliente, carga_tipo_de_pago, carga_monto, carga_tarjeta_numero)
SELECT Carga_Fecha, (SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_dni = Cli_Dni),
	(SELECT tipo_de_pago_id FROM LIL_MIX.tipoDePago WHERE tipo_de_pago_descripcion = Tipo_Pago_Desc),
	Carga_Credito, 12345678901234 -- Número de tarjeta de Marga, fue la única que realizó cargas
FROM gd_esquema.Maestra
WHERE Tipo_Pago_Desc = 'Crédito' AND Carga_Fecha IS NOT NULL
GO


INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_id_cliente, carga_tipo_de_pago, carga_monto)
SELECT Carga_Fecha, (SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_dni = Cli_Dni),
	(SELECT tipo_de_pago_id FROM LIL_MIX.tipoDePago WHERE tipo_de_pago_descripcion = Tipo_Pago_Desc), Carga_Credito
FROM gd_esquema.Maestra
WHERE Tipo_Pago_Desc LIKE 'Efectivo' AND Carga_Fecha IS NOT NULL
GO

--                        Compra

INSERT INTO LIL_MIX.compra (compra_oferta_numero, compra_oferta_descr, compra_cliente_id, compra_cantidad, compra_fecha)
SELECT o.oferta_id, o.oferta_decripcion, (SELECT cliente_id FROM LIL_MIX.cliente WHERE cliente_dni = Cli_Dni),
		COUNT(o.oferta_codigo), m.Oferta_Fecha_Compra
FROM gd_esquema.Maestra m JOIN LIL_MIX.oferta o ON (o.oferta_codigo = SUBSTRING(m.Oferta_Codigo, 1, 10))
GROUP BY m.Oferta_Codigo, o.oferta_id, o.oferta_decripcion, m.Oferta_Fecha_Compra, Cli_Dni
GO

--                        Cupon

INSERT INTO LIL_MIX.cupon (cupon_fecha_vencimiento, cupon_fecha_consumo, cupon_compra_id, cupon_cliente_id)
SELECT (DATEADD(day, 30, c.compra_fecha)), m.Oferta_Entregado_Fecha, c.compra_id, c.compra_cliente_id
FROM LIL_MIX.oferta o JOIN LIL_MIX.compra c ON (c.compra_oferta_numero = o.oferta_id)
					  JOIN gd_esquema.Maestra m ON (o.oferta_codigo = SUBSTRING(m.Oferta_Codigo, 1, 10))
GO

--                        Factura

INSERT INTO LIL_MIX.factura (factura_id , factura_proveedor_id, factura_fecha_inicio, factura_fecha_fin, factura_importe)
SELECT Factura_Nro , (SELECT proveedor_id FROM LIL_MIX.proveedor WHERE proveedor_cuit = Provee_CUIT) , MIN(Oferta_Fecha_Compra) ,
	Factura_Fecha , SUM(Oferta_Precio)
FROM gd_esquema.Maestra
WHERE Factura_Nro IS NOT NULL
GROUP BY Factura_Nro , Factura_Fecha , Provee_CUIT
GO


------------------::::::::::::::::::::::  PROCEDURES  ::::::::::::::::::::::------------------

----------------------------------------  ABM DE ROL  ----------------------------------------

-- 1) Funcionalidad para poder crear, modificar y eliminar el acceso de un usuario a una opción del sistema. 

-- 1.1) Crear un rol implica cargar los siguientes datos: Nombre y Listado de Funcionalidades (selección acotada) 

CREATE PROCEDURE LIL_MIX.listadoFuncionalidades
AS
BEGIN
	SELECT * FROM LIL_MIX.funcionalidad
END
GO

 -- 2)
 
CREATE PROCEDURE LIL_MIX.altaRol 
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			
			IF @rol_nombre IN (SELECT rol_nombre FROM LIL_MIX.rol)
				THROW 50004, 'Rol existente', 1

			IF @funcionalidad_descripcion NOT IN (SELECT funcionalidad_descripcion FROM LIL_MIX.funcionalidad)
				THROW 50005, 'Funcionalidad inexistente', 1
			
			INSERT INTO LIL_MIX.rol (rol_nombre)
			VALUES (@rol_nombre)

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
GO

--2) SECCIÓN DE MODIFICACIÓN DEL ROL

-- Para elegir el rol que se desea modificar o eliminar 
-- se debe mostrar un listado con todos los roles existentes en el sistema. 

CREATE PROCEDURE LIL_MIX.listadoRol
AS
BEGIN
	SELECT rol_nombre FROM LIL_MIX.rol 
END
GO

-- 2.1) Modificar nombre

-- En la modificación de un rol solo se pueden alterar ambos campos: el nombre y el listado de funcionalidades. 

CREATE PROCEDURE LIL_MIX.modificarRolNombre
@rol_nombre VARCHAR(30), @rol_nombre_nuevo VARCHAR(30)
AS
BEGIN

	IF @rol_nombre_nuevo IN (SELECT rol_nombre FROM LIL_MIX.rol)
		THROW 50035, 'Ya existe rol con ese nombre', 1
		
	UPDATE LIL_MIX.rol
	SET rol_nombre = @rol_nombre_nuevo
	WHERE rol_nombre = @rol_nombre
END
GO

--Se deben poder quitar de a una las funcionalidades como así  también agregar nuevas funcionalidades a rol que 
--se está modificando

-- 2.2) Agregar funcionalidad

CREATE PROCEDURE LIL_MIX.modificarRolAgregarFuncionalidad
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @funcionalidad_descripcion NOT IN (SELECT funcionalidad_descripcion FROM LIL_MIX.funcionalidad)
				THROW 50006, 'No existe funcionalidad.', 1

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
GO

-- 2.3) Eliminar funcionalidad

CREATE PROCEDURE LIL_MIX.modificarRolEliminarFuncionalidad
@rol_nombre VARCHAR(30), @funcionalidad_descripcion VARCHAR(30)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
			DECLARE @funcid INT,
				@rolid INT
			
			SELECT @funcid = funcionalidad_id FROM LIL_MIX.funcionalidad
			WHERE funcionalidad_descripcion = @funcionalidad_descripcion
			
			SELECT @rolid = rol_id FROM LIL_MIX.rol
			WHERE rol_nombre = @rol_nombre
			
			IF @funcid NOT IN (SELECT funcionalidad_id FROM LIL_MIX.funcionalidadxrol WHERE rol_id = @rolid)
				THROW 50007, 'No existe esa funcionalidad en este rol.', 1

			DELETE FROM LIL_MIX.funcionalidadxrol 
			WHERE funcionalidad_id = @funcid AND rol_id = @rolid
			
		COMMIT
	END TRY

	BEGIN CATCH
	
		ROLLBACK
		
	END CATCH
END
GO

-- 2.4) Habilitar un rol
 
--Se debe poder volver a habilitar un rol inhabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.habilitarRol
@rol_nombre VARCHAR(30)
AS
BEGIN
	UPDATE LIL_MIX.rol
	SET rol_habilitado = 1
	WHERE rol_nombre = @rol_nombre
END
GO

--3) 

-- La eliminación del rol implica una baja lógica del mismo. El rol debe poder inhabilitarse.

CREATE PROCEDURE LIL_MIX.bajaRol
@rol_nombre VARCHAR(30)
AS
BEGIN
	UPDATE LIL_MIX.rol
	SET rol_habilitado = 0
	WHERE rol_nombre = @rol_nombre
END
GO

----------------------------------------  LOGIN Y SEGURIDAD  ----------------------------------------

-- 4)

-- Al ejecutar la aplicación el usuario no podrá acceder a ninguna funcionalidad del sistema hasta 
-- completar el proceso de Login. 

CREATE PROCEDURE LIL_MIX.login
@usuario VARCHAR(255), @password_ingresada VARCHAR(255) 
AS
BEGIN
	DECLARE @password_del_usuario varchar(255),
			@password_encriptada nvarchar(255),
			@intentos tinyint,
			@usuario_habilitado bit

	IF NOT EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario)
	BEGIN
		RAISERROR('El usuario ingresado no existe.', 16, 1)
		RETURN
	END

	SELECT @password_del_usuario = usuario_password, @usuario_habilitado = usuario_habilitado
	FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario

	IF @usuario_habilitado = 0 
	BEGIN
		RAISERROR('El usuario ha sido inhabilitado. Por favor, contáctese con un administrador.', 16, 1)
		RETURN
	END

	SELECT @password_encriptada = HASHBYTES('SHA2_256', @password_ingresada)

	IF @password_del_usuario != @password_encriptada
	BEGIN
		RAISERROR('Contraseña incorrecta.', 16, 1)
		
		-- El sistema debe llevar un registro de cantidad intentos fallidos de login. 

		UPDATE LIL_MIX.usuario
		SET usuario_intentos = usuario_intentos + 1
		WHERE usuario_nombre = @usuario
		
		SELECT @intentos = usuario_intentos
		FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario

		IF @intentos = 3
		BEGIN
			RAISERROR('Ha ingresado la contraseña 3 veces de forma incorrecta. El usuario será inhabilitado.', 16, 1)

			-- Luego de 3 intentos fallidos en cualquier momento, el usuario debe ser inhabilitado.
			
			UPDATE LIL_MIX.usuario
			SET usuario_habilitado = 0
			WHERE usuario_nombre = @usuario

			RETURN
		END
	END
	ELSE
	BEGIN
		-- Al realizar un Login satisfactorio, el sistema deberá limpiar la cantidad de intentos fallidos.
		
		UPDATE LIL_MIX.usuario
		SET usuario_intentos = 0
		WHERE usuario_nombre = @usuario
		
		RETURN
	END
END
GO

------------------------------------  REGISTRO DE USUARIO  -----------------------------------

-- Funcionalidad que se encuentra disponible al momento de loguearse el usuario al sistema. 

-- 5) CREAR USUARIO TIPO CLIENTE

CREATE PROCEDURE LIL_MIX.altaUsuarioCliente
@usuario_nombre VARCHAR(255), @usuario_password VARCHAR(255), @rol_nombre VARCHAR(30), -- Datos de usuario
@nombre VARCHAR(255), @apellido VARCHAR(255), @dni INT, @mail VARCHAR(255), @telefono INT, @fechanacimiento DATETIME, 
@codigopostal SMALLINT, @direccion_calle VARCHAR(255), @direccion_piso TINYINT, @direccion_dpto CHAR(1), @ciudad VARCHAR(255) -- Datos de cliente
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		-- DATOS DE USUARIO:
		
		-- El username debe ser único en un todo el sistema.

		IF EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre)

		--La aplicación deberá controlar esta restricción e informar debidamente al usuario.

			THROW 50008, 'Nombre de usuario ya existe, intente con uno distinto.', 1

		IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
			THROW 50009, 'El rol no existe, intente nuevamente.', 1
			
		-- El password deberá almacenarse encriptado de forma irreversible bajo el algoritmo de encriptación SHA256.
	
		INSERT INTO LIL_MIX.usuario (usuario_nombre, usuario_password, usuario_intentos)
		VALUES (@usuario_nombre, HASHBYTES('SHA2_256', @usuario_password), 0)

		INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
		VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))
		
		-- DATOS DE CLIENTE:
			
		-- El alumno deberá determinar un procedimiento para evitar la generación de clientes “gemelos” 
		-- (distinto nombre de usuario, pero igual datos identificatorios según se justifique en la estrategia de resolución).

		IF EXISTS (SELECT * FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
				 WHERE (c.cliente_dni = @dni OR c.cliente_mail = @mail) AND u.usuario_nombre != @usuario_nombre) -- Consideramos dato identificatorio al dni y al mail
			THROW 50010, 'Cliente gemelo. Ya existe cliente con dicho DNI o e-mail. No puede realizarse la operación.', 1

		INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
		VALUES (@direccion_calle, @direccion_piso, @direccion_dpto, @ciudad)

		-- Toda creación de cliente nuevo, implica una carga de dinero de bienvenida de $200.

		INSERT INTO LIL_MIX.cliente (cliente_nombre, cliente_apellido, cliente_mail, cliente_telefono, cliente_fecha_nacimiento, 
					cliente_cp, cliente_dni, cliente_credito, cliente_usuario_id, cliente_direccion_id)
		VALUES (@nombre, @apellido, @mail, @telefono, @fechanacimiento, @codigopostal, @dni, 200, 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre),
			(SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = @direccion_calle AND 
			direccion_piso = @direccion_piso AND direccion_dpto = @direccion_dpto AND direccion_ciudad = @ciudad)) 

		COMMIT
	END TRY

	BEGIN CATCH

		ROLLBACK

	END CATCH
END
GO

-- 6) CREAR USUARIO TIPO PROVEEDOR

CREATE PROCEDURE LIL_MIX.altaUsuarioProveedor
@usuario_nombre VARCHAR(255), @usuario_password VARCHAR(255), @rol_nombre VARCHAR(30), -- Datos de usuario
@nombre_de_usuario VARCHAR(255), @razon_social VARCHAR(255), @mail VARCHAR(255), @telefono INT, @cuit VARCHAR(13), @rubro VARCHAR(255), 
@nombre_contacto VARCHAR(255), @codigo_postal SMALLINT, @calle VARCHAR(255), @piso TINYINT, @dpto CHAR(1), @ciudad VARCHAR(255) -- Datos de proveedor
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
		
		-- DATOS DE USUARIO:
			
		-- El username debe ser único en un todo el sistema.

		IF EXISTS (SELECT * FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre)

		--La aplicación deberá controlar esta restricción e informar debidamente al usuario.

			THROW 50011, 'Nombre de usuario ya existe, intente con uno distinto.', 1

		IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
			THROW 50012, 'El rol no existe, intente nuevamente.', 1
			
		-- El password deberá almacenarse encriptado de forma irreversible bajo el algoritmo de encriptación SHA256.
	
		INSERT INTO LIL_MIX.usuario (usuario_nombre, usuario_password, usuario_intentos)
		VALUES (@usuario_nombre, HASHBYTES('SHA2_256', @usuario_password), 0)

		INSERT INTO LIL_MIX.rolxusuario(rol_id, usuario_id)
		VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))

		-- DATOS DE PROVEEDOR:

		-- La razón social y cuit son datos únicos, por ende no pueden existir 2 proveedores con la misma razón social y cuit
		-- El sistema deberá controlar esta restricción e informar debidamente al usuario ante alguna anomalía.

		IF EXISTS (SELECT * FROM LIL_MIX.proveedor WHERE proveedor_cuit = @cuit)
			THROW 50013, 'CUIT ya existe en el sistema.', 1

		IF EXISTS (SELECT * FROM LIL_MIX.proveedor WHERE proveedor_rs = @razon_social)
			THROW 50014, 'Razón social ya existe en el sistema.', 1
		
		INSERT INTO LIL_MIX.direccion (direccion_calle, direccion_piso, direccion_dpto, direccion_ciudad)
		VALUES (@calle, @piso, @dpto, @ciudad)
			
		INSERT INTO LIL_MIX.proveedor (proveedor_telefono, proveedor_cuit, proveedor_rubro, proveedor_mail, proveedor_cp, 
			proveedor_nombre_contacto, proveedor_rs, proveedor_usuario_id, proveedor_direccion_id)
		VALUES (@telefono, @cuit, @rubro, @mail, @codigo_postal, @nombre_contacto, @razon_social, 
			(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre),
			(SELECT direccion_id FROM LIL_MIX.direccion WHERE direccion_calle = @calle AND direccion_piso = @piso AND
				direccion_dpto = @dpto AND direccion_ciudad = @ciudad))
		
		COMMIT
	END TRY

	BEGIN CATCH

		ROLLBACK

	END CATCH
END
GO

-- 7) 

-- A un usuario se le asigna un solo rol, 
-- pero no se descarta que pueda tener más de un rol al mismo tiempo en un futuro no muy lejano. 

CREATE PROCEDURE LIL_MIX.agregarRolAUsuario
@rol_nombre VARCHAR(30), @usuario_nombre VARCHAR(255)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
	
	-- Chequeo existencia del rol
	
	IF @rol_nombre NOT IN (SELECT rol_nombre FROM LIL_MIX.rol)
		THROW 50015, 'Rol inexistente.', 1
		
	-- Chequeo existencia del usuario
	
	IF @usuario_nombre NOT IN (SELECT usuario_nombre FROM LIL_MIX.usuario)
		THROW 50016, 'Usuario inexistente.', 1
		
	INSERT INTO LIL_MIX.rolxusuario (rol_id, usuario_id)
	VALUES ((SELECT rol_id FROM LIL_MIX.rol WHERE rol_nombre = @rol_nombre), 
		(SELECT usuario_id FROM LIL_MIX.usuario WHERE usuario_nombre = @usuario_nombre))
		
	COMMIT
END TRY

BEGIN CATCH

	ROLLBACK
	
END CATCH

END
GO

-- 8)

-- Debe tenerse en cuenta que se pueda modificar el password. 

CREATE PROCEDURE LIL_MIX.modificarContrasenia
@usuario_nombre VARCHAR(255), @anteriorcontra VARCHAR(255), @nuevacontra VARCHAR(255)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @usuariohabilitado BIT

		SELECT @usuariohabilitado = usuario_habilitado FROM LIL_MIX.usuario
		WHERE usuario_nombre = @usuario_nombre

		IF @usuariohabilitado = 0
			THROW 50017, 'El usuario esta inhabilitado. Por lo tanto, no puede cambiar su contraseña.', 1

		UPDATE LIL_MIX.usuario
		SET usuario_password = HASHBYTES('SHA2_256', @nuevacontra)
		WHERE usuario_password = HASHBYTES('SHA2_256', @anteriorcontra) AND usuario_nombre = @usuario_nombre

		COMMIT
		
	END TRY
	
	BEGIN CATCH
	
		ROLLBACK
		
	END CATCH
END
GO

-- 9)

--También debe contemplarse de alguna manera, que un administrativo pueda dar de baja un usuario.
 
CREATE PROCEDURE LIL_MIX.darDeBajaUsuario
@usuario_nombre VARCHAR(255)
AS
BEGIN
	UPDATE LIL_MIX.usuario
	SET usuario_habilitado = 0
	WHERE usuario_nombre = @usuario_nombre
END
GO

---------------------------------------  ABM DE CLIENTES  ---------------------------------------

-- 10)

-- La eliminación de un cliente implica la baja lógica del mismo. 

CREATE PROCEDURE LIL_MIX.bajaCliente
@dni_del_cliente INT
AS
BEGIN
	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 0
	WHERE cliente_dni = @dni_del_cliente
END
GO

-- 11) SECCIÓN DE MODIFICACIÓN DEL CLIENTE

-- Para elegir que cliente se desea modificar o eliminar se debe presentar un buscador con listado, 
-- que permita filtrar simultáneamente por alguno o todos los siguientes campos: 
--  Nombre (texto libre)  Apellido (texto libre)  DNI (texto libre exacto)  Email (texto libre) 

CREATE PROCEDURE LIL_MIX.listadoClientes
@nombre VARCHAR(255), @apellido VARCHAR(255), @dni INT, @email VARCHAR(255)
AS
BEGIN
	SELECT c.cliente_dni as 'Nombre del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (u.usuario_id = c.cliente_usuario_id)
	WHERE c.cliente_dni = @dni
	
	SELECT c.cliente_nombre as 'Nombre del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (u.usuario_id = c.cliente_usuario_id)
	WHERE c.cliente_nombre LIKE '%'+@nombre+'%'
	
	SELECT c.cliente_apellido as 'Apellido del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (u.usuario_id = c.cliente_usuario_id)
	WHERE c.cliente_apellido LIKE '%'+@apellido+'%'
	
	SELECT c.cliente_mail as 'Apellido del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (u.usuario_id = c.cliente_usuario_id)
	WHERE c.cliente_mail LIKE '%'+@mail+'%'

END
GO

-- 11.1)

-- Se debe poder volver a habilitar el cliente deshabilitado desde la sección de modificación. 


CREATE PROCEDURE LIL_MIX.habilitarCliente
@usuario_nombre VARCHAR(255)
AS
BEGIN
	DECLARE @usuarioid INT
	
	SELECT @usuarioid = c.cliente_usuario_id
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (u.usuario_id = c.cliente_usuario_id)
	WHERE u.usuario_nombre = @usuario_nombre
	
	UPDATE LIL_MIX.cliente
	SET cliente_habilitado = 1
	WHERE cliente_usuario_id = @usuarioid
END
GO

-- Todos los datos mencionados anteriormente son modificables: Nombre, Apellido, DNI, Mail, Teléfono,
-- Dirección calle, nro piso, depto y localidad, Código Postal, Fecha de Nacimiento.

-- 11.2) Modificación de nombre

  
CREATE PROCEDURE LIL_MIX.modificarClienteNombre
@nombre_usuario VARCHAR(255), @nombre_nuevo VARCHAR(255)
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_nombre = @nombre_nuevo 
	WHERE cliente_usuario_id = @usuario_id_del_cliente	
END
GO

-- 11.3) Modificación de apellido


CREATE PROCEDURE LIL_MIX.modificarClienteApellido
@nombre_usuario VARCHAR(255), @apellido_nuevo VARCHAR(255)
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_apellido = @apellido_nuevo 
	WHERE cliente_usuario_id = @usuario_id_del_cliente	
END
GO

-- 11.4) Modificación de DNI

  
CREATE PROCEDURE LIL_MIX.modificarClienteDNI
@nombre_usuario VARCHAR(255), @dni_nuevo INT
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_dni = @dni_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente
				
END
GO

-- 11.5) Modificación de e-mail

  
CREATE PROCEDURE LIL_MIX.modificarClienteMail
@nombre_usuario VARCHAR(255), @mail_nuevo VARCHAR(255)
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_mail = @mail_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente
				
END
GO

-- 11.6) Modificación de telefono

CREATE PROCEDURE LIL_MIX.modificarClienteTelefono
@nombre_usuario VARCHAR(255), @telefono_nuevo INT
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_telefono = @telefono_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente			
END
GO

-- 11.7) Modificación de fecha de nacimiento

CREATE PROCEDURE LIL_MIX.modificarClienteFechaNacimiento
@nombre_usuario VARCHAR(255), @fechanacimiento_nueva DATETIME
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_fecha_nacimiento = @fechanacimiento_nueva
	WHERE cliente_usuario_id = @usuario_id_del_cliente
				
END
GO

-- 11.8) Modificación de codigo postal
  
CREATE PROCEDURE LIL_MIX.modificarClienteCP
@nombre_usuario VARCHAR(255), @codigopostal_nuevo SMALLINT
AS
BEGIN
	DECLARE @usuario_id_del_cliente INT
			
	SELECT @usuario_id_del_cliente = usuario_id FROM LIL_MIX.usuario
	WHERE usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.cliente 
	SET cliente_cp = @codigopostal_nuevo
	WHERE cliente_usuario_id = @usuario_id_del_cliente
			
END
GO

-- 11.9) Modificación de direccion (calle)

  
CREATE PROCEDURE LIL_MIX.modificarClienteCalleDirec
@nombre_usuario VARCHAR(255), @direccion_calle_nuevo VARCHAR(255) 
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_calle = @direccion_calle_nuevo 
	WHERE direccion_id = @direccionid
			
END
GO

-- 11.10) Modificación de direccion (numero de piso)

  
CREATE PROCEDURE LIL_MIX.modificarClientePisoDirec
@nombre_usuario VARCHAR(255), @direccion_piso_nuevo TINYINT
AS
BEGIN 
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_piso = @direccion_piso_nuevo
	WHERE direccion_id = @direccionid			
END
GO

-- 11.11) Modificación de direccion (departamento)

CREATE PROCEDURE LIL_MIX.modificarClienteDptoDirec
@nombre_usuario VARCHAR(255), @direccion_dpto_nuevo CHAR(1)
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_dpto = @direccion_dpto_nuevo
	WHERE direccion_id = @direccionid				
END
GO

-- 11.12) Modificación de direccion (ciudad)
  
CREATE PROCEDURE LIL_MIX.modificarClienteCiudad
@nombre_usuario VARCHAR(255), @ciudad_nueva VARCHAR(255)
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = c.cliente_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.cliente c ON (c.cliente_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_ciudad = @ciudad_nueva
	WHERE direccion_id = @direccionid
			
END
GO

---------------------------------------------  ABM DE PROVEEDOR  ---------------------------------------------

-- 12)

-- La eliminación de un proveedor implica la baja lógica del mismo.

CREATE PROCEDURE LIL_MIX.bajaProveedor
@razon_social VARCHAR(255), @cuit VARCHAR(13)
AS
BEGIN
	UPDATE LIL_MIX.proveedor
	SET proveedor_habilitado = 0
	WHERE proveedor_rs = @razon_social AND proveedor_cuit = @cuit
END
GO

-- 13) SECCIÓN DE MODIFICACIÓN DEL PROVEEDOR

-- Para elegir que proveedor se desea modificar o eliminar se debe presentar un buscador con listado, 
--- que permita filtrar simultáneamente por alguno o todos los siguientes campos: 
--  Razón Social (texto libre)  CUIT (texto libre exacto)  Email (texto libre) 

CREATE PROCEDURE LIL_MIX.listadoProveedores
@razonsocial VARCHAR(255), @cuit VARCHAR(13), @mail VARCHAR(255)
AS
BEGIN
	SELECT p.proveedor_rs as 'Nombre del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (u.usuario_id = p.proveedor_usuario_id)
	WHERE p.proveedor_rs LIKE '%'+@razonsocial+'%'
	
	SELECT p.proveedor_mail as 'Nombre del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (u.usuario_id = p.proveedor_usuario_id)
	WHERE p.proveedor_mail LIKE '%'+@mail+'%'
	
	SELECT p.proveedor_cuit as 'Nombre del cliente', u.usuario_nombre as 'Nombre de usuario'
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (u.usuario_id = p.proveedor_usuario_id)
	WHERE p.proveedor_cuit = @cuit
	
END
GO

-- 13.1)

-- Se debe poder volver a habilitar el proveedor deshabilitado desde la sección de modificación. 

CREATE PROCEDURE LIL_MIX.habilitarProveedor
@usuario_nombre VARCHAR(255)
AS
BEGIN
	DECLARE @usuarioid INT
	
	SELECT @usuarioid = p.proveedor_usuario_id
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (u.usuario_id = p.proveedor_usuario_id)
	WHERE u.usuario_nombre = @usuario_nombre
	
	UPDATE LIL_MIX.proveedor
	SET proveedor_habilitado = 1
	WHERE proveedor_usuario_id = @usuarioid
END
GO

-- Todos los datos mencionados anteriormente son modificables: Razón Social, Mail, Teléfono, Dirección calle, nro piso, depto 
-- y localidad, Código Postal, Ciudad, CIUT, Rubro en el cual se desempeña, Nombre de Contacto  

-- 13.2) Modificar razon social

CREATE PROCEDURE LIL_MIX.modificarProveedorRS
@nombre_usuario VARCHAR(255), @razon_social_nueva VARCHAR(255)
AS
BEGIN
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_rs = @razon_social_nueva 
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor					
END
GO

-- 13.3) Modificar mail

CREATE PROCEDURE LIL_MIX.modificarProveedorMail
@nombre_usuario VARCHAR(255), @mail_nuevo VARCHAR(255)
AS
BEGIN			
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_mail = @mail_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor					
END
GO

-- 13.4) Modificar telefono

CREATE PROCEDURE LIL_MIX.modificarProveedorTelefono
@nombre_usuario VARCHAR(255), @telefono_nuevo INT
AS
BEGIN
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_telefono = @telefono_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor				
END
GO

-- 13.5) Modificar codigo postal

CREATE PROCEDURE LIL_MIX.modificarProveedorCP
@nombre_usuario VARCHAR(255), @codigopostal_nuevo SMALLINT
AS
BEGIN
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_cp = @codigopostal_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor					
END
GO

-- 13.6) Modificar cuit

CREATE PROCEDURE LIL_MIX.modificarProveedorCuit
@nombre_usuario VARCHAR(255), @cuit_nuevo VARCHAR(13)
AS
BEGIN
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_cuit = @cuit_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor					
END
GO

-- 13.7) Modificar rubro en el cual se desempeña

CREATE PROCEDURE LIL_MIX.modificarProveedorRubro
@nombre_usuario VARCHAR(255), @rubro_nuevo VARCHAR(255)
AS
BEGIN 
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_rubro = @rubro_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor					
END

GO

-- 13.8) Modificar nombre de contacto

CREATE PROCEDURE LIL_MIX.modificarProveedorNombreDeContacto
@nombre_usuario VARCHAR(255), @nombre_de_contacto_nuevo VARCHAR(255)
AS
BEGIN			
	DECLARE @usuario_id_del_proveedor INT
			
	SELECT @usuario_id_del_proveedor = usuario_id 
	FROM LIL_MIX.usuario WHERE usuario_nombre = @nombre_usuario 
	
	UPDATE LIL_MIX.proveedor 
	SET proveedor_nombre_contacto  = @nombre_de_contacto_nuevo
	WHERE proveedor_usuario_id = @usuario_id_del_proveedor					
END
GO

-- 13.9) Modificación de direccion (calle)

CREATE PROCEDURE LIL_MIX.modificarCalleDirecCliente
@nombre_usuario VARCHAR(255), @direccion_calle_nuevo VARCHAR(255) 
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_calle = @direccion_calle_nuevo 
	WHERE direccion_id = @direccionid			
END
GO

-- 13.10) Modificación de direccion (numero de piso)

CREATE PROCEDURE LIL_MIX.modificarPisoDirecCliente
@nombre_usuario VARCHAR(255), @direccion_piso_nuevo TINYINT
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_piso = @direccion_piso_nuevo
	WHERE direccion_id = @direccionid			
END
GO

-- 13.11) Modificación de direccion (departamento)
  
CREATE PROCEDURE LIL_MIX.modificarDptoDirecCliente
@nombre_usuario VARCHAR(255), @direccion_dpto_nuevo CHAR(1)
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_dpto = @direccion_dpto_nuevo
	WHERE direccion_id = @direccionid				
END
GO

-- 13.12) Modificación de direccion (ciudad)

CREATE PROCEDURE LIL_MIX.modificarCiudadCliente
@nombre_usuario VARCHAR(255), @ciudad_nueva VARCHAR(255)
AS
BEGIN
	DECLARE @direccionid INT
			
	SELECT @direccionid = p.proveedor_direccion_id 
	FROM LIL_MIX.usuario u JOIN LIL_MIX.proveedor p ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario
			
	UPDATE LIL_MIX.direccion 
	SET direccion_ciudad = @ciudad_nueva
	WHERE direccion_id = @direccionid
			
END
GO

--------------------------------------------  CARGA DE CRÉDITO  -----------------------------------------------

-- 14) Esta funcionalidad permite la carga de crédito a la cuenta de un cliente para poder operar en este nuevo sistema

-- 14.1) Para dar de alta una nueva carga implicará registrar los siguientes datos: 
--  Fecha  Cliente  Tipo de pago (selección acotada)  Monto  Datos de la tarjeta (a determinar por los alumnos) 

CREATE PROCEDURE LIL_MIX.listadoTiposDePago
AS
BEGIN
	SELECT * FROM LIL_MIX.tipoDePago
END
GO

-- 14.2)

CREATE PROCEDURE LIL_MIX.cargarCredito
@usuario_nombre VARCHAR(255), @monto BIGINT, 
@tipo_de_pago VARCHAR(30), --efectivo, credito o debito
@fechadecarga DATETIME, @tarjeta_numero BIGINT, @tarjeta_tipo VARCHAR(30), @tarjeta_fecha_vencimiento DATETIME
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
		DECLARE @cliente INT,
				@tipodepago VARCHAR(30),
				@clientehabilitado BIT

		SELECT @cliente = cliente_id, @clientehabilitado = cliente_habilitado
		FROM LIL_MIX.cliente c JOIN LIL_MIX.usuario u ON (u.usuario_id = c.cliente_usuario_id) 
		WHERE u.usuario_nombre = @usuario_nombre

		SELECT @tipodepago = tipo_de_pago_id FROM LIL_MIX.tipoDePago 
		WHERE tipo_de_pago_descripcion = @tipo_de_pago
			
		-- Un cliente inhabilitado no podrá comprar ofertas ni cargarse crédito bajo ninguna forma
			
		IF @clientehabilitado = 0
			THROW 50018, 'Cliente inhabilitado. No puede cargarse de crédito.', 1

		-- Una vez que se determina el monto a cargar, será necesario que se elija el tipo de pago (tarjeta de crédito o débito), 
		-- será obligatorio que se registren los datos necesarios para poder identificar la tarjeta utilizada. 

		IF @tipodepago != 1 -- No es 'Efectivo'
		
			-- Chequeo si los datos de la tarjeta ingresada están en la tabla TARJETA pero algún dato no concuerda
		
			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente = @cliente AND tarjeta_numero = @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento != @tarjeta_fecha_vencimiento)
				THROW 50019, 'Error al ingresar tarjeta.', 1

			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente = @cliente AND tarjeta_numero = @tarjeta_numero AND tarjeta_tipo != @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente = @cliente)
				THROW 50020, 'Error al ingresar tarjeta.', 1

			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente = @cliente AND tarjeta_numero != @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente != @cliente)
				THROW 50021, 'Error al ingresar tarjeta.', 1
				
			IF EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_id_cliente != @cliente AND tarjeta_numero = @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente != @cliente)
				THROW 50022, 'La tarjeta pertenece a otro cliente. No puede utilizarla.', 1
				
			-- Si en la tabla TARJETA no está registrada dicha tarjeta para dicho cliente, la registro

			IF NOT EXISTS (SELECT * FROM LIL_MIX.tarjeta WHERE tarjeta_numero = @tarjeta_numero AND tarjeta_tipo = @tarjeta_tipo AND tarjeta_fecha_vencimiento = @tarjeta_fecha_vencimiento AND tarjeta_id_cliente = @cliente)
				INSERT INTO LIL_MIX.tarjeta (tarjeta_numero, tarjeta_tipo, tarjeta_fecha_vencimiento, tarjeta_id_cliente)
				VALUES (@tarjeta_numero, @tarjeta_tipo, @tarjeta_fecha_vencimiento, @cliente)

		-- Al momento de efectuarse la carga de dinero, el sistema tomará la fecha de día. 
		-- La misma será tomada del archivo de configuración de la aplicación. 

		INSERT INTO LIL_MIX.cargaDeCredito (carga_fecha, carga_monto, carga_id_cliente, carga_tipo_de_pago, carga_tarjeta_numero)
		VALUES (@fechadecarga, @monto , @cliente, @tipodepago, @tarjeta_numero) 

		COMMIT TRANSACTION
	END TRY
	
	BEGIN CATCH
		
		ROLLBACK TRANSACTION
		
	END CATCH
END
GO
		
---------------------------------------  CONFECCIÓN Y PUBLICACIÓN DE OFERTAS ------------------------------------------

-- 15)

--Este caso de uso es utilizado por los proveedores para armar y publicar las ofertas que formarán parte de la plataforma.

CREATE PROCEDURE LIL_MIX.crearOferta
@usuario_nombre VARCHAR(255),
@fechaactualdelsistema DATETIME,
@oferta_decripcion VARCHAR(255), @oferta_fecha_vencimiento DATETIME, @oferta_precio_oferta INT, @oferta_precio_lista INT,
@oferta_stock INT, @oferta_restriccion_compra TINYINT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
		DECLARE @proveedorid INT,
			@proveedorhabilitado BIT
		
		SELECT @proveedorid = p.proveedor_id, @proveedorhabilitado = p.proveedor_habilitado
		FROM LIL_MIX.proveedor p JOIN LIL_MIX.usuario u ON (u.usuario_id = p.proveedor_id)
		WHERE u.usuario_nombre = @usuario_nombre
		
		-- Un proveedor inhabilitado no podrá armar ofertas. 
		
		IF @proveedorhabilitado = 0
			THROW 50023, 'Proveedor inhabilitado. No puede armar ofertas.', 1
		
		-- El proveedor podrá ir cargando ofertas con diferentes fechas, 
		-- esta fecha debe ser mayor o igual a la fecha actual del sistema
		
		IF @oferta_fecha_vencimiento < @fechaactualdelsistema
			THROW 50024, 'La fecha de vencimiento debe ser mayor o igual a la fecha actual.', 1
		
		-- Un cupón consta de 2 precios, que son determinados por el proveedor: 
		-- El precio de oferta. (rebajado) y El precio de lista u original del producto o servicio que se publica 
		
		IF @oferta_precio_oferta >= @oferta_precio_lista
			THROW 50025, 'El precio de oferta debe ser menor que el precio de lista.', 1
			
		INSERT INTO LIL_MIX.oferta (oferta_codigo, oferta_precio_oferta, oferta_precio_lista, oferta_fecha_publicacion,
			oferta_fecha_vencimiento, oferta_decripcion, oferta_stock, oferta_proveedor_id, oferta_restriccion_compra)
		VALUES ((SELECT CONVERT(varchar(255), NEWID())), @oferta_precio_oferta, @oferta_precio_lista, @fechaactualdelsistema,
				@oferta_fecha_vencimiento, @oferta_decripcion, @oferta_stock, @proveedorid, @oferta_restriccion_compra) 
		
		COMMIT TRANSACTION

	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION
		
	END CATCH
END
GO

----------------------------------------------  COMPRAR OFERTA ----------------------------------------------------

-- 16)

-- Esta funcionalidad permite a un cliente comprar una oferta publicada por los diferentes proveedores. 

-- Se debe tener en cuenta que el usuario solo podrá ver las ofertas que se encuentren vigentes para el 
-- día en el cual se ingresa al sistema.

CREATE PROCEDURE LIL_MIX.ofertasVigentesHastaDiaActual
@diaactual DATETIME
AS
BEGIN
	SELECT oferta_codigo as 'Codigo de oferta', oferta_decripcion as 'Descripcion', oferta_precio_lista as 'Precio de lista', 
	oferta_precio_oferta as 'Precio de oferta', oferta_stock as 'Stock disponible', 
	oferta_restriccion_compra as 'Cantidad máxima que puede comprar cada cliente'
	FROM LIL_MIX.oferta
	WHERE oferta_fecha_vencimiento < @diaactual
END
GO

-- 17)

CREATE PROCEDURE LIL_MIX.comprarOferta
@nombre_usuario INT, @oferta_codigo VARCHAR(255), @cantidad TINYINT, 
@diadecompra DATETIME			
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DECLARE @creditocliente BIGINT,
			@preciooferta INT,
			@cantmaximadeofertas TINYINT,
			@ofertaid INT,
			@clienteid INT,
			@compraid INT,
			@ofertadesc VARCHAR(255),
			@fechavenc DATETIME,
			@stockdisponible INT,
			@clientehabilitado BIT
		
		SELECT @creditocliente = c.cliente_credito, @clienteid = c.cliente_id, @clientehabilitado = c.cliente_habilitado
		FROM LIL_MIX.cliente c JOIN LIL_MIX.usuario u ON (u.usuario_id = c.cliente_usuario_id)
		WHERE u.usuario_nombre = @nombre_usuario
		
		SELECT @ofertaid = oferta_id, @preciooferta = oferta_precio_oferta, @fechavenc = oferta_fecha_vencimiento,
		@ofertadesc = oferta_decripcion, @cantmaximadeofertas = oferta_restriccion_compra, @stockdisponible = oferta_stock
		FROM LIL_MIX.oferta WHERE oferta_codigo = @oferta_codigo
		
		-- Un cliente inhabilitado no podrá comprar ofertas ni cargarse crédito bajo ninguna forma
		
		IF @clientehabilitado = 0
			THROW 50026, 'Cliente inhabilitado. No puede comprar ofertas.', 1
		
		-- Chequear si hay stock disponible
		
		IF @stockdisponible < @cantidad
			THROW 50027, 'No hay suficiente stock de dicha oferta.', 1
	
		-- Al momento de realizar la compra el sistema deberá validar que el crédito que posee el usuario sea suficiente
		
		IF @creditocliente < (@preciooferta * @cantidad)
			THROW 50028, 'No tiene crédito suficiente para realizar la compra.', 1
		
		-- Se deberá validar que la adquisición no supere la cantidad máxima de ofertas permitida por usuario. 
		
		IF @cantidad > @cantmaximadeofertas
			THROW 50029, 'Superó el máximo de unidades permitida para comprar por cliente.', 1
		
		-- Los datos mínimos a registrar son los siguientes: Fecha de compra, Oferta, Nro de Oferta, Cliente que realizó la compra 

		INSERT INTO LIL_MIX.compra (compra_oferta_numero, compra_oferta_descr, compra_cliente_id, compra_cantidad, compra_fecha)
		VALUES (@ofertaid, @ofertadesc, @clienteid, @cantidad, @diadecompra) 
		
		-- Cuando un cliente adquiere una oferta, se le deberá informar el código de compra 
		
		SELECT @compraid = compra_id FROM LIL_MIX.compra
		WHERE compra_oferta_numero = @ofertaid AND compra_oferta_descr = @ofertadesc AND compra_cliente_id = @clienteid 
			AND compra_cantidad = @cantidad AND compra_fecha = @diadecompra
		
		UPDATE LIL_MIX.oferta
		SET oferta_stock = oferta_stock - @cantidad
		WHERE oferta_codigo = @oferta_codigo
		
		-- Generación automática del cupón
		
		INSERT INTO LIL_MIX.cupon (cupon_fecha_vencimiento, cupon_compra_id, cupon_cliente_id)
		VALUES (DATEADD(day, 30, @diadecompra), @compraid, @clienteid)

		COMMIT TRANSACTION
		
	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION
		
	END CATCH

END
GO

---------------------------------------  ENTREGA/CONSUMO DE OFERTA ------------------------------------------

-- 18)

-- Funcionalidad que permite a un proveedor dar de baja una oferta entregada por un cliente al momento de realizarse el canje.  

CREATE PROCEDURE LIL_MIX.consumoDeOferta
@cuponid INT, @nombre_usuario VARCHAR(13), --proveedor
@diadeconsumo DATETIME
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		
		DECLARE @fechaconsumo DATETIME,
			@fechacomp DATETIME,
			@proveedorid INT,
			@proveedoridchequear INT,
			@usuariohabilitado BIT,
			@fechavenc DATETIME
		
		SELECT @fechaconsumo = cu.cupon_fecha_consumo, @fechacomp = co.compra_fecha,
			@proveedoridchequear = o.oferta_proveedor_id, @fechavenc = cu.cupon_fecha_vencimiento
		FROM LIL_MIX.compra co JOIN LIL_MIX.cupon cu ON (cu.cupon_compra_id = co.compra_id)
							   JOIN LIL_MIX.oferta o ON (o.oferta_id = co.compra_oferta_numero)
		WHERE cupon_id = @cuponid
		
		SELECT @proveedorid = p.proveedor_id, @usuariohabilitado = p.proveedor_habilitado 
		FROM LIL_MIX.proveedor p JOIN LIL_MIX.usuario u ON (p.proveedor_usuario_id = u.usuario_id)
		WHERE u.usuario_nombre = @nombre_usuario
		
		IF @usuariohabilitado = 0
			THROW 50030, 'El proveedor está inhabilitado. No puede entregar ofertas.', 1
		
		-- Este proceso tiene como restricciones que un cupón no puede ser canjeado más de una vez
	
		IF @fechaconsumo IS NOT NULL
			THROW 50031, 'El cupón ya fue canjeado.', 1

		-- Si el cupón se venció tampoco podrá ser canjeado 
		
		IF @fechavenc < @diadeconsumo
			THROW 50032, 'El cupón está vencido', 1
			
		-- Validarse que dicho cupón entrega corresponda al proveedor
		
		IF @proveedorid != @proveedoridchequear
			THROW 50033, 'El cupón no corresponde al proveedor.', 1
		
	-- Para dar de baja un cupón disponible para consumir es necesario que se registre: Fecha de consumo, Código de cupón, Cliente 
		
		UPDATE LIL_MIX.cupon
		SET cupon_fecha_consumo = @diadeconsumo
		WHERE cupon_id = @cuponid
			
		COMMIT TRANSACTION
		
	END TRY
	
	BEGIN CATCH
	
		ROLLBACK TRANSACTION
		
	END CATCH

END
GO

------------------------------------- FACTURACION PROVEEDOR -------------------------------------------------

-- 19)

-- Esta funcionalidad permite a un administrativo facturar a un proveedor todas las ofertas compradas por los clientes. 
-- Para ello ingresará el período de facturación por intervalos de fecha, se deberá seleccionar el proveedor 
-- y a continuación se listaran todos las ofertas que fueron adquiridas por los clientes.  

CREATE PROCEDURE LIL_MIX.todasLasOfertasAdquiridas
@fecha_inicio DATETIME , @fecha_fin DATETIME , @nombre_usuario_proveedor VARCHAR(255)
AS
BEGIN
	SELECT o.oferta_codigo as 'Codigo de oferta', p.proveedor_cuit as 'Cuit del proveedor'
	FROM LIL_MIX.proveedor p JOIN LIL_MIX.oferta o ON (p.proveedor_id = o.oferta_proveedor_id)
							 JOIN LIL_MIX.compra c ON (c.compra_oferta_numero = o.oferta_id)
							 JOIN LIL_MIX.usuario u ON (p.proveedor_usuario_id = u.usuario_id)
	WHERE u.usuario_nombre = @nombre_usuario_proveedor AND (c.compra_fecha BETWEEN @fecha_inicio AND @fecha_fin)
END
GO

-- 20)

CREATE PROCEDURE LIL_MIX.facturacionProveedor
@fecha_inicio DATETIME , @fecha_fin DATETIME , @proveedor_cuit VARCHAR(13)
AS
BEGIN 	
	BEGIN TRY
		BEGIN TRAN

		DECLARE @proveedor_id INT,
			@factura_importe INT

		IF NOT EXISTS (SELECT * FROM LIL_MIX.proveedor WHERE proveedor_cuit = @proveedor_cuit)
			THROW 50034, 'El proveedor al que se quiere facturar no existe.' , 1

		-- Se informará el importe de la factura y el número correspondiente de la misma. 

		SELECT @proveedor_id = p.proveedor_id , @factura_importe = SUM(c.compra_cantidad * o.oferta_precio_oferta) 
		FROM LIL_MIX.oferta o JOIN LIL_MIX.compra c ON (o.oferta_id = c.compra_oferta_numero)
				  JOIN LIL_MIX.proveedor p ON (o.oferta_proveedor_id = p.proveedor_id)
		WHERE p.proveedor_cuit = @proveedor_cuit AND (c.compra_fecha BETWEEN @fecha_inicio AND @fecha_fin)
		GROUP BY p.proveedor_id

		INSERT INTO LIL_MIX.factura (factura_proveedor_id , factura_fecha_inicio , factura_fecha_fin , factura_importe)
		VALUES (@proveedor_id, @fecha_inicio , @fecha_fin , @factura_importe)

		COMMIT 

	END TRY

	BEGIN CATCH 

		ROLLBACK

	END CATCH
END
GO

--------------------------------------------- LISTADO ESTADÍSTICO -----------------------------------------------------

-- Esta funcionalidad nos debe permitir consultar el TOP 5 de: 
--	o Proveedores con mayor porcentaje de descuento ofrecido en sus ofertas 
--	o Proveedores con mayor facturación 

-- Dichas consultas son a nivel semestral, para lo cual la pantalla debe permitirnos selección el semestral a consultar.  
-- Además de ingresar el año a consultar, el sistema nos debe permitir seleccionar que tipo de listado se quiere visualizar. 

--21) 1. Proveedores con mayor porcentaje de descuento

CREATE PROCEDURE LIL_MIX.listadoEstadistico1   
@anio INT, @semestre INT   -- 1 o 2
AS
BEGIN

	SELECT TOP 5 s.semestre_id as 'Semestre', @anio as 'Año', p.proveedor_id as 'Proveedor ID', p.proveedor_nombre_contacto as 'Nombre de contacto', 
				p.proveedor_mail as 'Mail', p.proveedor_cuit as 'CUIT', p.proveedor_rubro as 'Rubro', p.proveedor_rs as 'Razon social',
		(100-AVG((o.oferta_precio_oferta * 100) / o.oferta_precio_lista)) as 'Porcentaje de Descuento'			
	FROM LIL_MIX.proveedor p JOIN LIL_MIX.oferta o ON (o.oferta_proveedor_id = p.proveedor_id), LIL_MIX.semestre s
	WHERE s.semestre_id = @semestre AND
		o.oferta_fecha_publicacion BETWEEN CONVERT(DATETIME, s.semestre_fecha_inicio+'-'+@anio, 103) AND CONVERT(DATETIME, s.semestre_fecha_fin+'-'+@anio, 103)
	GROUP BY p.proveedor_nombre_contacto, p.proveedor_mail, p.proveedor_cuit, p.proveedor_rubro, p.proveedor_rs, s.semestre_id, p.proveedor_id
	ORDER BY [Porcentaje de Descuento] DESC, p.proveedor_id ASC	-- El listado se debe ordenar en forma descendente por monto. 
	  
END
GO

-- Cabe aclarar que los campos a visualizar en la tabla del listado para las 2 consultas no son los mismos, 
-- y al momento de seleccionar un tipo solo deben visualizarse las columnas pertinentes al tipo de listado elegido. 

--22) 2. Proveedores con mayor facturacion

CREATE PROCEDURE LIL_MIX.listadoEstadistico2  
@anio INT, @semestre INT   -- 1 o 2
AS
BEGIN

	SELECT TOP 5 s.semestre_id as 'Semestre', @anio as 'Año', p.proveedor_id as 'ID del Proveedor', p.proveedor_nombre_contacto as 'Nombre de contacto', 
			p.proveedor_mail as 'Mail', p.proveedor_cuit as 'CUIT', p.proveedor_rubro as 'Rubro', p.proveedor_rs as 'Razon social', 
				SUM(f.factura_importe) as 'Total Facturado'
	FROM LIL_MIX.proveedor p JOIN LIL_MIX.factura f ON (f.factura_proveedor_id = p.proveedor_id), LIL_MIX.semestre s  
	WHERE s.semestre_id = @semestre AND
		(f.factura_fecha_inicio BETWEEN CONVERT(DATETIME, s.semestre_fecha_inicio+'-'+@anio, 103) AND 
					CONVERT(DATETIME, s.semestre_fecha_fin+'-'+@anio, 103))
		AND (f.factura_fecha_fin BETWEEN CONVERT(DATETIME, s.semestre_fecha_inicio+'-'+@anio, 103) AND 
		CONVERT(DATETIME, s.semestre_fecha_fin+'-'+@anio, 103))
	GROUP BY p.proveedor_id, p.proveedor_nombre_contacto, p.proveedor_mail, p.proveedor_cuit, p.proveedor_rubro, p.proveedor_rs, s.semestre_id
	ORDER BY [Total Facturado] DESC	-- El listado se debe ordenar en forma descendente por monto. 
	
END
GO


-------------------------------::::::::::::::::::::::  TRIGGERS  ::::::::::::::::::::::----------------------------------

-------------------------------------------------  AMB DE ROL  -------------------------------------------------

-- 1) No puede haber un rol con funcionalidades repetidas

IF OBJECT_ID('LIL_MIX.noRepetirFuncionalidadesEnUnRol') IS NOT NULL
  DROP TRIGGER LIL_MIX.noRepetirFuncionalidadesEnUnRol
GO

CREATE TRIGGER LIL_MIX.noRepetirFuncionalidadesEnUnRol ON LIL_MIX.funcionalidadxrol
INSTEAD OF INSERT AS
BEGIN
	DECLARE @funcionalidad_id INT,
		@rol_id INT

	SELECT @funcionalidad_id = funcionalidad_id, @rol_id = rol_id FROM inserted

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
END
GO

--2) Eliminacion de roles inhabilitados

CREATE TRIGGER LIL_MIX.eliminarRolesInhabilitados ON LIL_MIX.rol
AFTER UPDATE AS
BEGIN

	--Se le debe quitar el rol inhabilitado a todos aquellos usuarios que lo posean

	DELETE FROM LIL_MIX.rolxusuario
	WHERE rol_id IN (SELECT rol_id FROM inserted WHERE rol_habilitado = 0)

END
GO

----------------------------------------- CARGA DE CRÉDITO ----------------------------------------------

-- 3)

CREATE TRIGGER LIL_MIX.cargarCreditoAlCliente ON LIL_MIX.cargaDeCredito
AFTER INSERT AS
BEGIN
	DECLARE @monto_cargado INT,
		@cliente_id INT

	SELECT @monto_cargado = carga_monto, @cliente_id = carga_id_cliente FROM inserted

	UPDATE LIL_MIX.cliente
	SET cliente_credito = cliente_credito + @monto_cargado
	WHERE cliente_id = @cliente_id

END
GO

--------------------------------------

SELECT * FROM LIL_MIX.funcionalidad
SELECT * FROM LIL_MIX.rol
SELECT * FROM LIL_MIX.funcionalidadxrol
SELECT * FROM LIL_MIX.semestre
SELECT * FROM LIL_MIX.tipoDePago
SELECT * FROM LIL_MIX.cliente
SELECT * FROM LIL_MIX.proveedor
SELECT * FROM LIL_MIX.compra
SELECT * FROM LIL_MIX.cupon
ORDER BY cupon_cliente_id, cupon_compra_id

SELECT * FROM LIL_MIX.usuario
SELECT * FROM LIL_MIX.rolxusuario
SELECT * FROM LIL_MIX.factura
SELECT * FROM LIL_MIX.cargaDeCredito
SELECT * FROM LIL_MIX.oferta
SELECT * FROM LIL_MIX.direccion
SELECT * FROM LIL_MIX.tarjeta
