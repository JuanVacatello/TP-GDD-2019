--use GD2C2019
                                                            /*Creacion de datos*/

/*                         	Usuarios
insert into SQL_INJECTION.Usuario (nombreUsuario,contrase�a,tipoUsuario,estado) values ('admin','E6B87050BFCB8143FCB8DB0170A4DC9ED00D904DDD3E2A4AD1',1,1)
GO
insert into SQL_INJECTION.Usuario (nombreUsuario,contrase�a,tipoUsuario,estado) values ('admin2','E6B87050BFCB8143FCB8DB0170A4DC9ED00D904DDD3E2A4AD1',1,1)
GO
*/

--Funcionalidades

-- 1) ABM ROL
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('ABM de ROL')
GO
-- 2) Registro de usuario
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Registro de Usuario')
GO
-- 3) ABM CLIENTE.
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('ABM de CLIENTE')
GO
-- 4) ABM PROVEEDOR.
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('ABM de PROVEEDOR')
GO
-- 5) Carga de credito
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Carga de credito')
GO
-- 6) Cambio de contrase�a
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Cambio de contrase�a')
GO
-- 7) Baja de usuario
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Baja de usuario')
GO
-- 8) Confeccion y publicacion de oferta
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Confeccion y publicacion de oferta')
GO
-- 9) Comprar oferta
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Comprar oferta')
GO
-- 10) Entrega
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Entrega')
GO
-- 11) Facturacion a proveedor
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Facturacion a proveedor')
GO
-- 12) Listado Estadastico
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Listado Estadistico')
GO

--                             Roles
INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('ADMINISTRATIVO')
GO
INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('CLIENTE')
GO
INSERT INTO LIL_MIX.rol (rol_nombre) VALUES ('PROVEEDOR')
GO

--                          funcionalidadxrol
-- Funciones Administrador
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,1)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,3)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,4)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,5)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,6)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,7)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,8)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,11)
INSERT INTO  LIL_MIX.funcionalidadxrol(rol_id,funcionalidad_id) VALUES (1,12) --No sabemos quien tiene esa funci�n
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

/*--                         RolesXUsuario

INSERT INTO  LIL_MIX.rolxusuario(rol_id,usuario_id) VALUES (1,1)
GO
INSERT INTO  LIL_MIX.rolxusuario(rol_id,usuario_id) VALUES (2,2)
GO
INSERT INTO  LIL_MIX.rolxusuario(rol_id,usuario_id) VALUES (3,3)
GO
*/
--                       Listado estadistico
INSERT INTO LIL_MIX.listado (listado_descripcion) VALUES ('Proveedores con mayor porcentaje de descuento ofrecido en sus ofertas')
INSERT INTO LIL_MIX.listado (listado_descripcion) VALUES ('Proveedores con mayor facturaci�n')
GO
--                       Listados de semestres
INSERT INTO LIL_MIX.semestre(semestre_descripcion) VALUES ('1')
INSERT INTO LIL_MIX.semestre(semestre_descripcion) VALUES ('2')
GO

--                        Forma de pago
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Efectivo')
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Tarjeta Credito')
INSERT INTO LIL_MIX.tipoDePago(tipo_de_pago_descripcion) VALUES ('Tarjeta Debito')

/*--                         Operacion de compra
insert into SQL_INJECTION.OperacionCompra(nombreOperacion) values ('Comprar pasaje')
insert into SQL_INJECTION.OperacionCompra(nombreOperacion) values ('Reservar pasaje')

--                         Operacion de cancelar pasajes por reparacion del crucero
insert into SQL_INJECTION.OperacionCancelarPasajes(nombreOperacion) values ('Cancelar Pasajes')
insert into SQL_INJECTION.OperacionCancelarPasajes(nombreOperacion) values ('Reprogramar pasajes')
*/

