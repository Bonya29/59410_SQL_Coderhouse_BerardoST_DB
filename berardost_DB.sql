-- Creacion de la base de datos
create database berardost;
use berardost;

-- Creacion de las tablas de la base de datos

create table cliente (
ID int auto_increment primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null,
email varchar(100),
ID_domicilio int not null
) comment 'Guarda los datos de los clientes.';

create table venta (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
cantidad int not null,
total decimal(14,2) not null,
ID_producto int not null,
ID_cliente int not null
) comment 'Guarda los datos de las compras que realizan los clientes.';

create table producto (
ID int auto_increment primary key,
nombre varchar(50) not null,
marca varchar(50) not null,
modelo varchar(50) not null,
precio decimal(14,2) not null,
stock int not null,
ID_proveedor int not null
) comment 'Guarda los datos de los productos que comercializa la empresa.';

create table proveedor (
ID int auto_increment primary key,
nombre varchar(50) not null,
email varchar(100) not null,
telefono varchar(20) not null,
paginaWeb varchar(100)
) comment 'Guarda los datos de los proveedores de la empresa.';

create table compra (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
precioUnitario decimal(14,2) not null,
cantidad int not null,
total decimal(14,2) not null,
ID_producto int not null,
ID_proveedor int not null
) comment 'Guarda los datos de las compras que realiza la empresa a los proveedores.';

create table instalacion (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
tipo varchar(15) not null,
ID_ubicacion int not null,
ID_cliente int not null,
ID_venta int not null
) comment 'Guarda los datos de las instalaciones que realizo la empresa.';

create table tecnico (
ID int auto_increment primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null,
email varchar(100),
ID_domicilio int not null
) comment 'Guarda los datos de los técnicos que contrata la empresa para realizar las instalaciones y servicios técnicos.';

create table instalacion_tecnico (
ID int auto_increment primary key,
ID_instalacion int not null,
ID_tecnico int not null
) comment 'Guarda el ID de la instalación y el ID del técnico que trabajo en esa instalación';

create table servicioTecnico (
ID int auto_increment primary key,
fecha datetime default(current_timestamp),
tipo varchar(15) not null,
costo decimal(14,2) not null,
ID_tecnico int not null,
ID_cliente int not null,
ID_ubicacion int not null
) comment 'Guarda los datos de los servicios técnicos que realizo la empresa';

create table domicilio (
ID int auto_increment primary key,
calle varchar(25) not null,
numero varchar(5) not null,
ID_localidad int not null
) comment 'Guarda los datos de los domicilios de los clientes y técnicos.';

create table ubicacion (
ID int auto_increment primary key,
calle varchar(25) not null,
numero varchar(5) not null,
ID_localidad int not null
) comment 'Guarda los datos de las ubicaciones de las instalaciones y servicios técnicos.';

create table localidad (
ID int auto_increment primary key,
nombre varchar(50) not null
) comment 'Guarda el nombre de las localidades.';

-- Asignacion de foreigns keys

alter table cliente
add constraint fk_cliente_domicilio
foreign key (ID_domicilio) references domicilio(ID);

alter table venta
add constraint fk_venta_producto
foreign key (ID_producto) references producto(ID);

alter table venta
add constraint fk_venta_cliente
foreign key (ID_cliente) references cliente(ID);

alter table producto
add constraint fk_producto_proveedor
foreign key (ID_proveedor) references proveedor(ID);

alter table compra
add constraint fk_compra_producto
foreign key (ID_producto) references producto(ID);

alter table compra
add constraint fk_compra_proveedor
foreign key (ID_proveedor) references proveedor(ID);

alter table instalacion
add constraint fk_instalacion_ubicacion
foreign key (ID_ubicacion) references ubicacion(ID);

alter table instalacion
add constraint fk_instalacion_cliente
foreign key (ID_cliente) references cliente(ID);

alter table instalacion
add constraint fk_instalacion_venta
foreign key (ID_venta) references venta(ID);

alter table tecnico
add constraint fk_tecnico_domicilio
foreign key (ID_domicilio) references domicilio(ID);

alter table instalacion_tecnico
add constraint fk_instec_instalacion
foreign key (ID_instalacion) references instalacion(ID);

alter table instalacion_tecnico
add constraint fk_instec_tecnico
foreign key (ID_tecnico) references tecnico(ID);

alter table servicioTecnico
add constraint fk_servtec_tecnico
foreign key (ID_tecnico) references tecnico(ID);

alter table servicioTecnico
add constraint fk_servtec_cliente
foreign key (ID_cliente) references cliente(ID);

alter table servicioTecnico
add constraint fk_servtec_ubicacion
foreign key (ID_ubicacion) references ubicacion(ID);

alter table domicilio
add constraint fk_domicilio_localidad
foreign key (ID_localidad) references localidad(ID);

alter table ubicacion
add constraint fk_ubicacion_localidad
foreign key (ID_localidad) references localidad(ID);

-- Insertado de datos en las tablas

INSERT INTO localidad (nombre) VALUES
('Cordoba Capital'),
('Alta Gracia'),
('Anisacate');

INSERT INTO domicilio (calle, numero, ID_localidad) VALUES
('Av. Colon', '123', 1),
('Bv. Granaderos', '456', 2),
('Santa Fe', '789', 3);

INSERT INTO ubicacion (calle, numero, ID_localidad) VALUES
('La Paz', '101', 1),
('Av. Libertad', '202', 2),
('Jujuy', '303', 3);

INSERT INTO cliente (nombre, apellido, telefono, ID_domicilio) VALUES
('Carlos', 'Pérez', '123456789', 1),
('María', 'Gómez', '987654321', 2),
('Luis', 'Rodríguez', '456789123', 3);

INSERT INTO proveedor (nombre, email, telefono) VALUES
('Distribuidora Tech', 'ventas@distribuidoratech.com', '5551234567'),
('Logitech Partners', 'contacto@logitechpartners.com', '5559876543'),
('HP Supplies', 'info@hpsupplies.com', '5556789123');

INSERT INTO producto (nombre, marca, modelo, precio, stock, ID_proveedor) VALUES
('Alarma', 'Ajax', 'Inspiron 15', 499.99, 10, 1),
('Camara', 'IMOU', 'M170', 15.99, 50, 2),
('Sensor', 'DSC', 'K500', 19.99, 30, 3);

INSERT INTO compra (precioUnitario, cantidad, total, ID_producto, ID_proveedor) VALUES
(399.99, 5, 1999.95, 1, 1),
(10.00, 100, 1000.00, 2, 2),
(18.00, 40, 720.00, 3, 3);

INSERT INTO venta (cantidad, total, ID_producto, ID_cliente) VALUES
(2, 999.99, 1, 1),
(1, 15.99, 2, 2),
(3, 59.97, 3, 3);

INSERT INTO instalacion (tipo, ID_ubicacion, ID_cliente, ID_venta) VALUES
('Supermercado', 1, 1, 1),
('Hogar', 2, 2, 2),
('Comercio', 3, 3, 3);

INSERT INTO tecnico (nombre, apellido, telefono, email, ID_domicilio) VALUES
('Juan', 'Martínez', '111222333', 'juan.martinez@example.com', 1),
('Ana', 'Fernández', '444555666', null, 2),
('Pablo', 'García', '777888999', 'pablo.garcia@example.com', 3);

INSERT INTO instalacion_tecnico (ID_instalacion, ID_tecnico) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO servicioTecnico (tipo, costo, ID_tecnico, ID_cliente, ID_ubicacion) VALUES
('Reparación', 50.00, 1, 1, 1),
('Mantenimiento', 120.00, 2, 2, 2),
('Cambio', 200.00, 3, 3, 3);