-- Creacion de la base de datos
create database berardost;
use berardost;

-- Creacion de las tablas de la base de datos

create table cliente (
ID int auto_increment primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null,
email varchar(100)
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
ID_ubicacion int unique not null,
ID_cliente int not null,
ID_venta int unique not null
) comment 'Guarda los datos de las instalaciones que realizo la empresa.';

create table tecnico (
ID int auto_increment primary key,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null,
email varchar(100)
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
ID_ubicacion int unique not null,
ID_tecnico int not null,
ID_cliente int not null
) comment 'Guarda los datos de los servicios técnicos que realizo la empresa';

create table domicilio (
ID int auto_increment primary key,
calle varchar(50) not null,
numero varchar(5) not null,
ID_localidad int not null,
ID_cliente int,
ID_tecnico int
) comment 'Guarda los datos de los domicilios de los clientes y técnicos.';

create table ubicacion (
ID int auto_increment primary key,
calle varchar(50) not null,
numero varchar(5) not null,
ID_localidad int not null
) comment 'Guarda los datos de las ubicaciones de las instalaciones y servicios técnicos.';

create table localidad (
ID int auto_increment primary key,
nombre varchar(50) not null,
ID_provincia int not null
) comment 'Guarda el nombre de las localidades.';

create table provincia (
ID int auto_increment primary key,
nombre varchar(50) not null
) comment 'Guarda el nombre de las provincias de Argentina.';

-- Asignacion de Foreigns Keys

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

alter table domicilio
add constraint fk_domicilio_cliente
foreign key (ID_cliente) references cliente(ID);

alter table domicilio
add constraint fk_domicilio_tecnico
foreign key (ID_tecnico) references tecnico(ID);

alter table ubicacion
add constraint fk_ubicacion_localidad
foreign key (ID_localidad) references localidad(ID);

alter table localidad
add constraint fk_localidad_provincia
foreign key (ID_provincia) references provincia(ID);

-- Insertado de datos en las tablas

insert into cliente (nombre, apellido, telefono, email) values
('Juan', 'Pérez', '555-1234', 'juan.perez@example.com'),
('Ana', 'Gómez', '555-5678', null),
('Luis', 'Martínez', '555-8765', null);

insert into tecnico (nombre, apellido, telefono, email) values
('Juan', 'Martínez', '111222333', 'juan.martinez@example.com'),
('Ana', 'Fernández', '444555666', null),
('Pablo', 'García', '777888999', 'pablo.garcia@example.com');

insert into proveedor (nombre, email, telefono, paginaWeb) values
('SmartGadgets', 'support@smartgadgets.com', '555-8765', 'www.smartgadgets.com'),
('CameraWorld', 'contact@cameraworld.com', '555-6789', 'www.cameraworld.com'),
('AudioPro', 'service@audiopro.com', '555-3456', null);

insert into producto (nombre, marca, modelo, precio, stock, ID_proveedor) values
('Alarma', 'Ajax', 'Inspiron 15', 499.99, 10, 3),
('Camara', 'IMOU', 'M170', 15.99, 50, 2),
('Sensor', 'DSC', 'K500', 19.99, 30, 1);

insert into compra (precioUnitario, cantidad, total, ID_producto, ID_proveedor) values
(399.99, 5, 1999.95, 1, 1),
(10.00, 100, 1000.00, 2, 2),
(18.00, 40, 720.00, 3, 3);

insert into venta (cantidad, total, ID_producto, ID_cliente) values
(2, 999.99, 1, 1),
(1, 15.99, 2, 2),
(3, 59.97, 3, 3);

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
('Cordoba Capital', 6),
('Palermo', 1),
('San Carlos de Bariloche', 16),
('Ciudad de Salta', 17),
('San Rafael', 13),
('San Miguel de Tucuman', 24),
('Mendoza Capital', 13),
('Concepcion', 24),
('Pilar', 2),
('Posadas', 14),
('Carlos Paz', 6),
('Alta Gracia', 6);

insert into domicilio (calle, numero, ID_localidad, ID_cliente, ID_tecnico) values
('Av. Libertad', '123', 1, 1, null),
('Egipto', '456', 2, 2, null),
('Besuri', '789', 3, 3, null),
('Bv. Constitución', '101', 4, null, 1),
('Esperanza', '202', 5, null, 2),
('Pablo Slovski', '303', 6, null, 3);

insert into ubicacion (calle, numero, ID_localidad) values
('Avenida de la Paz', '111', 7),
('Calle de la Alegría', '222', 8),
('Calle del Mar', '333', 9),
('Ronda Norte', '444', 10),
('Calle del Río', '555', 11),
('Avenida del Parque', '666', 12);

insert into instalacion (tipo, ID_ubicacion, ID_cliente, ID_venta) values
('Supermercado', 1, 1, 1),
('Hogar', 2, 2, 2),
('Comercio', 3, 3, 3);

insert into instalacion_tecnico (ID_instalacion, ID_tecnico) values
(1, 1),
(2, 2),
(3, 3);

insert into servicioTecnico (tipo, costo, ID_ubicacion, ID_tecnico, ID_cliente) values
('Reparación', 50.00, 4, 1, 1),
('Mantenimiento', 120.00, 5, 2, 2),
('Cambio', 200.00, 6, 3, 3);