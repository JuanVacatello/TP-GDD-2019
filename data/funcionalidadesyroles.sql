--use GD2C2019
                                                            /*Creacion de datos*/

--                                  Funcionalidades

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
-- 6) Cambio de contraseña
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Cambio de contraseña')
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
-- 12) Listado Estadístico
INSERT INTO LIL_MIX.funcionalidad (funcionalidad_descipcion) VALUES ('Listado Estadistico')
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
