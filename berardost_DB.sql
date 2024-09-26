-- Creacion de la base de datos --------------------------------------------------------------------------------------
-- drop database if exists berardost;
create database berardost;
use berardost;

-- Creacion de las tablas de la base de datos --------------------------------------------------------------------------------------

create table producto (
ID int auto_increment primary key,
nombre varchar(50) not null,
marca varchar(50) not null,
modelo varchar(50) not null,
precioLista decimal(14,2) not null,
precioVenta decimal(14,2) not null,
stock int unsigned not null 
) comment 'Guarda los datos de los productos que comercializa la empresa.';

create table provincia (
ID int auto_increment primary key,
nombre varchar(50) not null
) comment 'Guarda el nombre de las provincias de Argentina.';

create table localidad (
ID int auto_increment primary key,
nombre varchar(50) not null,
ID_provincia int, constraint fk_localidad_provincia foreign key(ID_Provincia) references provincia(ID) 
) comment 'Guarda el nombre de las localidades de las provincias.';

create table proveedor (
ID int auto_increment primary key,
nombre varchar(50) not null,
email varchar(100) not null unique,
telefono varchar(20) not null,
paginaWeb varchar(100) unique,
calle varchar(25) not null,
numero varchar(5) not null,
ID_Localidad int, constraint fk_proveedor_localidad foreign key(ID_Localidad) references localidad(ID) 
) comment 'Guarda los datos de los proveedores de la empresa.';

create table compra (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
precioUnitario decimal(14,2) not null,
cantidad int unsigned not null,
total decimal(14,2) not null,
ID_Producto int, constraint fk_compra_producto foreign key(ID_Producto) references producto(ID),
ID_Proveedor int, constraint fk_compra_proveedor foreign key(ID_Proveedor) references proveedor(ID) 
) comment 'Guarda los datos de las compras de productos que realiza la empresa a los proveedores.';

create table cliente (
ID int auto_increment primary key,
CUIL_CUIT varchar(13) unique not null,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null unique,
email varchar(100) unique,
calle varchar(25) not null,
numero varchar(5) not null,
ID_Localidad int, constraint fk_cliente_localidad foreign key(ID_Localidad) references localidad(ID) 
) comment 'Guarda los datos de los clientes.';

create table venta (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
cantidad int unsigned not null,
total decimal(14,2) not null,
ID_Producto int, constraint fk_venta_producto foreign key(ID_Producto) references producto(ID),
ID_Cliente int, constraint fk_venta_cliente foreign key(ID_Cliente) references cliente(ID)
) comment 'Guarda los datos de las compras que realizan los clientes.';

create table instalacion (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
tipo enum('Supermercado', 'Comercio', 'Hogar') not null,
calle varchar(25) not null,
numero varchar(5) not null,
ID_Localidad int, constraint fk_instalacion_localidad foreign key(ID_Localidad) references localidad(ID),
ID_Cliente int, constraint fk_instalacion_cliente foreign key(ID_Cliente) references cliente(ID),
ID_Venta int unique, constraint fk_venta_instalacion foreign key(ID_Venta) references venta(ID)
) comment 'Guarda los datos de las instalaciones que realizo la empresa.';

create table tecnico (
ID int auto_increment primary key,
CUIL_CUIT varchar(13) unique not null,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null unique,
email varchar(100) unique,
calle varchar(25) not null,
numero varchar(5) not null,
ID_Localidad int, constraint fk_tecnico_localidad foreign key(ID_Localidad) references localidad(ID)
) comment 'Guarda los datos de los técnicos que contrata la empresa para realizar las instalaciones y servicios técnicos.';

create table instalacion_tecnico (
ID int auto_increment primary key,
ID_Instalacion int, constraint fk_instec_instalacion foreign key(ID_Instalacion) references instalacion(ID),
ID_Tecnico int, constraint fk_instec_tecnico foreign key(ID_Tecnico) references tecnico(ID)
) comment 'Guarda el ID de la instalación y el ID del técnico que trabajo en esa instalación';

create table servicioTecnico (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
tipo enum('Mantenimiento', 'Reparacion', 'Cambio') not null,
costo decimal(14,2) not null,
calle varchar(25) not null,
numero varchar(5) not null,
ID_Localidad int, constraint fk_servtec_localidad foreign key(ID_Localidad) references localidad(ID),
ID_Tecnico int, constraint fk_servtec_tecnico foreign key(ID_Tecnico) references tecnico(ID),
ID_Cliente int, constraint fk_servtec_cliente foreign key(ID_Cliente) references cliente(ID)
) comment 'Guarda los datos de los servicios técnicos que realizo la empresa';

-- Insercion de datos en las tablas --------------------------------------------------------------------------------------

insert into producto (nombre, marca, modelo, precioLista, precioVenta, stock) values
('Alarma Centralizada', 'Seguritech', 'S-100', 7500.50 , 8000.50, 15),
('Cámara IP', 'VisionPro', 'V-200', 3000.75, 3500.75, 30),
('Sensor de Movimiento', 'SafeHome', 'SH-300', 1200.00, 1700.00, 50),
('Alarma Perimetral', 'SecureZone', 'SZ-400', 8500.90, 9000.90, 10),
('Cámara PTZ', 'Opticam', 'OC-500', 14500.80, 15000.80, 4),
('Detector de Humo', 'FireGuard', 'FG-600', 2000.00, 2500.60, 20),
('Cámara Domo', 'SafeView', 'SV-700', 5000.90, 5500.90, 25),
('Control de Acceso', 'AccessMaster', 'AM-800', 8700.10, 9200.10, 12),
('Sirena Exterior', 'AlarmPlus', 'AP-900', 2200.25, 2800.25, 40),
('Panel de Control', 'Guardian', 'G-1000', 10000.50, 10500.50, 5);

insert into provincia (nombre) values
('Ciudad Autonoma de Buenos Aires'),
('Buenos Aires'),
('Catamarca'),
('Chaco'),
('Chubut'),
('Córdoba'),
('Corrientes'),
('Entre Ríos'),
('Formosa'),
('Jujuy'),
('La Pampa'),
('La Rioja'),
('Mendoza'),
('Misiones'),
('Neuquén'),
('Río Negro'),
('Salta'),
('San Juan'),
('San Luis'),
('Santa Cruz'),
('Santa Fe'),
('Santiago del Estero'),
('Tierra del Fuego'),
('Tucumán');

insert into localidad (nombre, ID_provincia) values
('Palermo', 1),
('Belgrano', 1),
('Pilar', 2),
('Cordoba Capital', 6),
('Carlos Paz', 6),
('Alta Gracia', 6),
('Mendoza Capital', 13),
('San Rafael', 13),
('Posadas', 14),
('San Carlos de Bariloche', 16),
('Ciudad de Salta', 17),
('San Miguel de Tucuman', 24),
('Concepcion', 24);

insert into proveedor (nombre, email, telefono, paginaWeb, calle, numero, ID_Localidad) values
('Seguritech S.A.', 'contacto@seguritech.com', '3511234567', null, 'Av. Colon', '1234', 1),
('VisionPro Corp.', 'ventas@visionpro.com', '3519876543', 'www.visionpro.com', 'Av. Olmos', '567', 5),
('SafeHome Inc.', 'soporte@safehome.com', '3516543210', null, 'Calle San Martin', '890', 7),
('FireGuard Ltda.', 'info@fireguard.com', '3517654321', 'www.fireguard.com', 'Calle Mitre', '456', 2),
('Opticam SRL', 'ventas@opticam.com', '3512345678', null, 'Av. Sabattini', '321', 2);

insert into compra (precioUnitario, cantidad, total, ID_Producto, ID_Proveedor) values
(7500.50, 10, 75005.00, 1, 3),
(3000.75, 20, 60015.00, 2, 2),
(1200.00, 30, 36000.00, 3, 1),
(8500.90, 5, 42504.50, 4, 1),
(14500.80, 7, 101505.60, 5, 2);

insert into cliente (CUIL_CUIT, nombre, apellido, telefono, email, calle, numero, ID_Localidad) values
('21-00000001-9', 'Juan', 'Pérez', '3517894561', null, 'Calle Rivadavia', '101', 7),
('21-00000002-9', 'María', 'González', '3516549871', null, 'Calle San Juan', '202', 8),
('21-00000003-9', 'Carlos', 'López', '3514561237', 'carlos.lopez@email.com', 'Calle Sarmiento', '303', 10),
('21-00000004-9', 'Ana', 'Martínez', '3519871234', 'ana.martinez@email.com', 'Calle Belgrano', '404', 1),
('21-00000005-9', 'Pedro', 'Ramírez', '3513216548', null, 'Calle Caseros', '505', 3),
('21-00000006-9', 'Sofía', 'Torres', '3517893214', 'sofia.torres@email.com', 'Calle Sucre', '606', 1),
('21-00000007-9', 'Lucas', 'Fernández', '3519874563', 'lucas.fernandez@email.com', 'Calle Colón', '707', 2);

insert into venta (cantidad, total, ID_Producto, ID_Cliente) values
(2, 16001.00, 1, 1),
(3, 10502.25, 2, 2),
(4, 6800.00, 3, 1),
(1, 9000.90, 4, 1),
(2, 30001.60, 5, 3),
(5, 12503.00, 6, 4),
(3, 16502.70, 7, 5),
(1, 9200.10, 8, 6),
(4, 11201.00, 9, 7),
(2, 21001.00, 10, 7);

insert into instalacion (tipo, calle, numero, ID_Localidad, ID_Cliente, ID_Venta) values
(1, 'Calle Rivadavia', '101', 1, 1, 1),
(2, 'Calle San Juan', '202', 1, 2, 2),
(1, 'Calle Sarmiento', '303', 2, 1, 3),
(1, 'Calle Belgrano', '404', 4, 1, 4),
(2, 'Calle Caseros', '505', 4, 3, 5),
(3, 'Calle Sucre', '606', 5, 4, 6),
(1, 'Calle Rivadavia', '101', 6, 5, 7),
(2, 'Calle San Juan', '202', 6, 6, 8),
(3, 'Calle Belgrano', '404', 7, 7, 10),
(2, 'Calle Sarmiento', '303', 8, 7, 9);

insert into tecnico (CUIL_CUIT, nombre, apellido, telefono, email, calle, numero, ID_Localidad) values
('21-00000008-9', 'Lucas', 'Gómez', '3517894562', 'lucas.gomez@mail.com', 'Calle Mendoza', '123', 1),
('21-00000009-9', 'Javier', 'Sosa', '3516549872', 'javier.sosa@mail.com', 'Calle Corrientes', '456', 2),
('21-00000010-9', 'Santiago', 'Hernández', '3514561238', null, 'Calle La Rioja', '789', 4),
('21-00000020-9', 'Pablo', 'Alvarez', '3519871235', 'pablo.alvarez@mail.com', 'Calle Tucumán', '101', 7),
('21-00000030-9', 'Diego', 'Cruz', '3513216549', 'diego.cruz@mail.com', 'Calle Córdoba', '202', 7);

insert into instalacion_tecnico (ID_Instalacion, ID_Tecnico) values
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 4),
(10, 5);

insert into servicioTecnico (tipo, costo, calle, numero, ID_Localidad, ID_Tecnico, ID_Cliente) values
(1, 3500.50, 'Calle Rivadavia', '101', 7, 4, 1),
(2, 5000.75, 'Calle San Juan', '202', 8, 5, 2),
(3, 12000.00, 'Calle Sarmiento', '303', 8, 5, 3),
(3, 4500.90, 'Calle Belgrano', '404', 7, 4, 4),
(3, 8500.80, 'Calle Caseros', '505', 1, 1, 5),
(2, 2500.60, 'Calle Sucre', '606', 1, 1, 6),
(1, 14000.10, 'Calle Rivadavia', '101', 4, 3, 1),
(1, 9000.25, 'Calle San Juan', '202', 2, 2, 2),
(2, 3500.90, 'Calle Sarmiento', '303', 5, 3, 3),
(1, 10500.50, 'Calle Belgrano', '404', 6, 3, 4);

-- Creacion de las vistas --------------------------------------------------------------------------------------

create view vw_instalacion_ubicacion as
select 
provincia.nombre as Provincia,
localidad.nombre as Localidad,
instalacion.tipo as Tipo_Instalacion,
instalacion.calle,
instalacion.numero
from instalacion
join localidad on instalacion.ID_Localidad = localidad.ID
join provincia on localidad.ID_Provincia = provincia.ID
order by
count(instalacion.ID) over (partition by provincia.ID) desc,
count(instalacion.ID) over (partition by localidad.ID) desc;

create view vw_detalle_compra as
select
proveedor.nombre as Proveedor,
producto.nombre as Producto,
producto.marca, 
producto.modelo, 
compra.precioUnitario,
compra.cantidad,
compra.total,
compra.fecha
from compra
join producto on compra.ID_Producto = producto.ID
join proveedor on compra.ID_Proveedor = proveedor.ID;

create view vw_cantidad_compras_cliente as
select
cliente.nombre, 
cliente.apellido, 
count(venta.ID) as Cantidad_Compras
from cliente
left join venta on cliente.ID = venta.ID_Cliente
group by cliente.ID
order by Cantidad_compras desc;

create view vw_stock_bajo as
select
producto.nombre as Producto,
producto.marca,
producto.modelo,
producto.stock
from producto
where producto.stock <= 5;

delimiter //
-- Creacion de las funciones --------------------------------------------------------------------------------------

create function fn_calcular_total_producto(
ID_Producto int,
cantidadVendida int)
returns decimal(14,2)
reads sql data
begin
declare precio_venta_producto decimal(14,2);
declare precio_total_venta decimal(14,2);
select precioVenta into precio_venta_producto
from producto
where ID = ID_Producto;
set precio_total_venta = precio_venta_producto * cantidadVendida;
return precio_total_venta;
end//

create function fn_calcular_ganancia(
ID_Producto int, 
cantidadVendida int) 
returns decimal(14,2)
reads sql data
begin
declare ganancia decimal(14,2);
declare precio_lista_producto decimal(14,2);
declare precio_venta_producto decimal(14,2);
select precioLista, precioVenta into precio_lista_producto, precio_venta_producto
from producto
where ID = ID_Producto;
set ganancia = (precio_venta_producto - precio_lista_producto) * cantidadVendida;
return ganancia;
end//

-- Creacion de los procedimientos almacenados --------------------------------------------------------------------------------------

create procedure sp_update_stock_producto(
ID_Producto int,
cantidad int,
venta boolean)
begin
if venta then
update producto
set stock = stock - cantidad
where ID = ID_Producto;
else 
update producto
set stock = stock + cantidad
where ID = ID_Producto;
end if;
end//

create procedure sp_registrar_venta(
ID_Cliente int,
ID_Producto int, 
cantidad int, 
total decimal(14,2))
begin
declare venta boolean;
set venta = true;
insert into venta (ID_Cliente, ID_Producto, cantidad, total)
values (ID_Cliente, ID_Producto, cantidad, total);
call sp_update_stock_producto(ID_Producto, cantidad, venta);
end//

create procedure sp_registrar_compra(
ID_Proveedor int,
ID_Producto int,
precioUnitario decimal(14,2),
cantidad int, 
total decimal(14,2))
begin
declare venta boolean;
set venta = false;
insert into compra(ID_Proveedor, ID_Producto, precioUnitario, cantidad, total)
values (ID_Proveedor, ID_Producto, precioUnitario, cantidad, total);
call sp_update_stock_producto(ID_Producto, cantidad, venta);
end//

-- Creacion de los triggers --------------------------------------------------------------------------------------

create trigger tg_validar_stock_antes_venta
before insert on venta for each row
begin
declare stock_actual int;
select stock into stock_actual from producto where ID = new.ID_Producto;  
if new.cantidad > stock_actual then
signal sqlstate '45000' set message_text = 'Error: No hay stock suficiente para realizar la venta.';
end if;
end//

create trigger tg_validar_provincia_antes_instalacion
before insert on instalacion_tecnico for each row
begin
declare provincia_tecnico int;
declare provincia_instalacion int;
select ID_Provincia into provincia_tecnico from localidad where ID = (select ID_Localidad from tecnico where ID = new.ID_Tecnico);
select ID_Provincia into provincia_instalacion from localidad where ID = (select ID_Localidad from instalacion where ID = new.ID_Instalacion);
if provincia_tecnico != provincia_instalacion then
signal sqlstate '45000' set message_text = 'Error: El tecnico no se ubica en la misma provincia donde se realizara la instalacion.';
end if;
end//

create trigger tg_validar_provincia_antes_servicio
before insert on servicioTecnico for each row
begin
declare provincia_tecnico int;
declare provincia_servicio int;
select ID_Provincia into provincia_tecnico from localidad where ID = (select ID_Localidad from tecnico where ID = new.ID_Tecnico);
select ID_Provincia into provincia_servicio from localidad where ID = new.ID_Localidad;
if provincia_tecnico != provincia_servicio then
signal sqlstate '45000' set message_text = 'Error: El tecnico no se ubica en la misma provincia donde se realizara el servicio tecnico.';
end if;
end//

delimiter ;
-- Uso de las vistas --------------------------------------------------------------------------------------

-- select * from vw_instalacion_ubicacion;
-- select * from vw_detalle_compra;
-- select * from vw_cantidad_compras_cliente;
-- select * from vw_stock_bajo;

-- Uso de las funciones --------------------------------------------------------------------------------------

-- select fn_calcular_total_producto(1, 2) as total_producto; -- (ID_Producto, cantidad)
-- select fn_calcular_ganancia(1, 2) as ganancia; -- (ID_Producto, cantidad)
-- select * from producto where ID = 1;

-- Uso de los procedimientos almacenados --------------------------------------------------------------------------------------

-- call sp_update_stock_producto(1, 1, true); -- (ID_Producto, cantidad, venta?)
-- select * from producto where ID = 1;

-- call sp_update_stock_producto(2, 1, false); -- (ID_Producto, cantidad, venta?)
-- select * from producto where ID = 2;

-- call sp_registrar_venta(1, 1, 3, 24001.50); -- (ID_Cliente, ID_Producto, cantidad, total)
-- select * from producto where ID = 1;
-- select * from venta;

-- call sp_registrar_compra(1, 1, 7500.50, 3, 22501.50); -- (ID_Proveedor, ID_Producto, precioUnitario, cantidad, total)
-- select * from producto where ID = 1;
-- select * from compra;

-- Ejemplo del trigger tg_validar_stock_antes_venta --------------------------------------------------------------------------------------
-- call sp_registrar_venta (1, 1, 15, 128008);
-- select * from producto where id = 1;

-- Ejemplo del trigger tg_validar_provincia_antes_instalacion --------------------------------------------------------------------------------------
/*
insert into venta (cantidad, total, ID_Producto, ID_Cliente) values (3, 24001.50, 1, 1);
insert into instalacion (tipo, calle, numero, ID_Localidad, ID_Cliente, ID_Venta) values (1, 'Calle Rivadavia', '101', 10, 1, 12);
insert into instalacion_tecnico (ID_Instalacion, ID_Tecnico) values (11, 5);
*/

-- Ejemplo del trigger tg_validar_provincia_antes_servicio --------------------------------------------------------------------------------------
-- insert into servicioTecnico (tipo, costo, calle, numero, ID_Localidad, ID_Tecnico, ID_Cliente) values (1, 3500.50, 'Calle Rivadavia', '101', 10, 3, 1);