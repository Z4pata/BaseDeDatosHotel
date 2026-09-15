-- Creacion base de datos
CREATE DATABASE Hotel;
GO
USE Hotel;
GO

-- Estructuracion
-- Entidades fuertes

CREATE TABLE SERVICIO(
ID_servicio INT IDENTITY(1,1) PRIMARY KEY,
tipo_servicio VARCHAR(100) NOT NULL,
precio_servicio DECIMAL NOT NULL,
);
GO

CREATE TABLE CIUDAD(
ID_ciudad INT IDENTITY(1,1) PRIMARY KEY,
nombre_ciudad VARCHAR(100) NOT NULL,
);
GO

CREATE TABLE TIPO_HABITACION(
ID_tipo_habitacion INT IDENTITY(1,1) PRIMARY KEY,
nombre_tipo VARCHAR(100) NOT NULL,
capacidad INT NOT NULL,
precio_habitacion DECIMAL NOT NULL,
);
GO

CREATE TABLE HUESPED(
ID_huesped INT IDENTITY(1,1) PRIMARY KEY,
nombre_huesped VARCHAR(100) NOT NULL,
apellido_huesped VARCHAR(150),
documento INT NOT NULL,
correo varchar(200) NOT NULL,
edad TINYINT NOT NULL
);
GO

-- Entidades debiles

CREATE TABLE SEDE(
ID_sede INT IDENTITY(1,1) PRIMARY KEY,
ID_ciudad INT,
nombre_sede VARCHAR(100) NOT NULL,
direccion VARCHAR(100) NOT NULL,

-- Relacion entre Sede y Ciudad
CONSTRAINT FK_sede_ciudad FOREIGN KEY (ID_ciudad) REFERENCES CIUDAD(ID_ciudad)
);
GO

CREATE TABLE TELEFONO_SEDE(
ID_telefono INT IDENTITY(1,1) PRIMARY KEY,
ID_sede INT NOT NULL,
telefono VARCHAR(50) NOT NULL,
tipo_contacto VARCHAR(50),

-- Relacion entre telefono_sede y sede
CONSTRAINT FK_telefono_sede_sede FOREIGN KEY (ID_sede) REFERENCES SEDE(ID_sede)
);
GO

CREATE TABLE HABITACION(
ID_habitacion INT IDENTITY(1,1) PRIMARY KEY,
ID_tipo_habitacion INT,
ID_sede INT,
numero_habitacion VARCHAR(10) NOT NULL,
estado VARCHAR(30) NOT NULL,

-- Relaciones
CONSTRAINT FK_habitacion_tipo_habitacion FOREIGN KEY (ID_tipo_habitacion) 
REFERENCES TIPO_HABITACION(ID_tipo_habitacion),

CONSTRAINT FK_habitacion_sede FOREIGN KEY (ID_sede) REFERENCES SEDE(ID_sede)
);
GO

CREATE TABLE RESERVA(
ID_reserva INT IDENTITY(1,1) PRIMARY KEY,
ID_huesped INT,
fecha_reserva DATETIME NOT NULL,
fecha_entrada DATETIME,
fecha_salida DATETIME,
cantidad_adultos INT NOT NULL,
cantidad_menores INT DEFAULT 0,

-- Relaciones
CONSTRAINT FK_reserva_huesped FOREIGN KEY (ID_huesped) REFERENCES HUESPED(ID_huesped)
);
GO

CREATE TABLE RESERVA_HABITACION(
ID_reserva INT NOT NULL,
ID_habitacion INT NOT NULL,

PRIMARY KEY (ID_reserva, ID_habitacion),

-- Relaciones
CONSTRAINT FK_reserva_habitacion_reserva FOREIGN KEY (ID_reserva) REFERENCES RESERVA(ID_reserva),
CONSTRAINT FK_reserva_habitacion_habitacion FOREIGN KEY (ID_habitacion) REFERENCES HABITACION(ID_habitacion)
);
GO

CREATE TABLE FACTURA(
ID_factura INT IDENTITY(1,1) PRIMARY KEY,
ID_reserva INT NOT NULL,
fecha_factura DATETIME NOT NULL,
total_factura DECIMAL NOT NULL,
estado VARCHAR(50) NOT NULL,

-- Relaciones
CONSTRAINT FK_factura_reserva FOREIGN KEY (ID_reserva) REFERENCES RESERVA(ID_reserva)
);
GO

CREATE TABLE PAGO(
ID_pago INT IDENTITY(1,1) PRIMARY KEY,
ID_factura INT NOT NULL,
metodo_pago VARCHAR(100) NOT NULL,
monto_pago DECIMAL NOT NULL,
fecha_pago DATETIME NOT NULL,

-- Relaciones
CONSTRAINT FK_pago_factura FOREIGN KEY (ID_factura) REFERENCES FACTURA(ID_factura)
);
GO

CREATE TABLE TELEFONO_HUESPED(
ID_telefono INT IDENTITY(1,1) PRIMARY KEY,
ID_huesped INT NOT NULL,
telefono VARCHAR(50) NOT NULL,
tipo_contacto VARCHAR(50),

-- Relacion
CONSTRAINT FK_telefono_huesped_huesped FOREIGN KEY(ID_telefono) REFERENCES HUESPED(ID_huesped)
);
GO

CREATE TABLE RESERVA_SERVICIO(
ID_detalle INT IDENTITY(1,1) PRIMARY KEY,
ID_reserva INT NOT NULL,
ID_servicio INT NOT NULL,
cantidad_servicio INT NOT NULL DEFAULT(1),
subtotal DECIMAL NOT NULL,

-- Relaciones
CONSTRAINT FK_reserva_servicio_reserva FOREIGN KEY (ID_reserva) REFERENCES RESERVA(ID_reserva),
CONSTRAINT FK_reserva_servicio_servicio FOREIGN KEY (ID_servicio) REFERENCES SERVICIO(ID_servicio),
);

--Poblar las Tablas

USE Hotel
GO

INSERT INTO CIUDAD(nombre_ciudad)
VALUES ('Medellin'),
('Bogota'),
('Cali'),
('Barranquilla'),
('Cartagena'),
('Cúcuta'),
('Bucaramanga'),
('Pereira'),
('Santa Marta'),
('Ibagué'),
('Manizales'),
('Villavicencio'),
('Neiva'),
('Armenia'),
('Valledupar'),
('Montería'),
('Pasto'),
('Popayán'),
('Palmira'),
('Buenaventura');


INSERT INTO TIPO_HABITACION(nombre_tipo,capacidad,precio_habitacion)
VALUES ('Individual Estándar', 1, 80000),
('Individual Deluxe', 1, 120000),
('Doble Estándar', 2, 150000),
('Doble Deluxe', 2, 200000),
('Suite Junior', 2, 250000),
('Suite Ejecutiva', 2, 320000),
('Suite Presidencial', 4, 600000),
('Triple Familiar', 3, 220000),
('Cuádruple Familiar', 4, 280000),
('Matrimonial Estándar', 2, 140000),
('Matrimonial Deluxe', 2, 210000),
('Loft Moderno', 2, 270000),
('Habitación Económica', 1, 60000),
('Habitación Premium', 2, 230000),
('Habitación con Balcón', 2, 190000),
('Habitación con Vista al Mar', 2, 300000),
('Habitación Adaptada', 2, 160000),
('Habitación Temática', 2, 250000),
('Penthouse', 4, 700000),
('Estudio Compacto', 1, 100000);

INSERT INTO SERVICIO(tipo_servicio,precio_servicio)
VALUES('Servicio de Restaurante', 45000),
('Servicio de Bar', 30000),
('Spa y Masajes', 120000),
('Gimnasio', 25000),
('Piscina', 20000),
('Transporte Aeropuerto', 80000),
('Lavandería', 35000),
('Room Service', 40000),
('Wi-Fi Premium', 15000),
('Estacionamiento', 25000),
('Tours Turísticos', 100000),
('Alquiler de Bicicletas', 20000),
('Servicio de Concierge', 50000),
('Desayuno Buffet', 35000),
('Almuerzo Buffet', 60000),
('Cena Gourmet', 90000),
('Mini Bar', 25000),
('Servicio de Plancha', 15000),
('Guardería Infantil', 70000),
('Salón de Eventos', 200000);


INSERT INTO HUESPED(nombre_huesped,apellido_huesped,documento,correo,edad)
VALUES('Carlos', 'Ramírez', 1002456789, 'carlos.ramirez@gmail.com', 28),
('María', 'González', 1002456790, 'maria.gonzalez@hotmail.com', 34),
('Andrés', 'Hernández', 1002456791, 'andres.hernandez@gmail.com', 22),
('Laura', 'Martínez', 1002456792, 'laura.martinez@hotmail.com', 29),
('Felipe', 'Pérez', 1002456793, 'felipe.perez@gmail.com', 31),
('Camila', 'López', 1002456794, 'camila.lopez@hotmail.com', 25),
('Julián', 'Torres', 1002456795, 'julian.torres@gmail.com', 40),
('Valentina', 'Castro', 1002456796, 'valentina.castro@hotmail.com', 27),
('Sebastián', 'Morales', 1002456797, 'sebastian.morales@gmail.com', 33),
('Natalia', 'Vargas', 1002456798, 'natalia.vargas@hotmail.com', 21),
('Daniel', 'Suárez', 1002456799, 'daniel.suarez@gmail.com', 36),
('Paula', 'Jiménez', 1002456800, 'paula.jimenez@hotmail.com', 24),
('Juan', 'Cárdenas', 1002456801, 'juan.cardenas@gmail.com', 30),
('Sofía', 'Mejía', 1002456802, 'sofia.mejia@hotmail.com', 26),
('Mateo', 'Ríos', 1002456803, 'mateo.rios@gmail.com', 32),
('Isabella', 'Ortiz', 1002456804, 'isabella.ortiz@hotmail.com', 23),
('David', 'Salazar', 1002456805, 'david.salazar@gmail.com', 35),
('Carolina', 'Mendoza', 1002456806, 'carolina.mendoza@hotmail.com', 28),
('Hugo', 'Restrepo', 1002456807, 'hugo.restrepo@gmail.com', 41),
('Lucía', 'Arango', 1002456808, 'lucia.arango@hotmail.com', 20);

--poblando tablas con FK

USE Hotel
GO

INSERT INTO TELEFONO_HUESPED(ID_huesped,telefono,tipo_contacto)
VALUES (1,3004567890, 'Móvil'),
(2,3105678901, 'Móvil'),
(3,6041234567, 'Fijo'),
(4,6041234568, 'Fijo'),
(5,3156789012, 'Móvil'),
(6,3207890123, 'Móvil'),
(7,6041234569, 'Fijo'),
(8,6041234570, 'Fijo'),
(9,3218901234, 'Móvil'),
(10,3229012345, 'Móvil'),
(11,6041234571, 'Fijo'),
(12,6041234572, 'Fijo'),
(13,3130123456, 'Móvil'),
(14,3141234567, 'Móvil'),
(15,6041234573, 'Fijo'),
(16,6041234574, 'Fijo'),
(17,3162345678, 'Móvil'),
(18,3173456789, 'Móvil'),
(19,6041234575, 'Fijo'),
(20,6041234576, 'Fijo');

INSERT INTO SEDE(nombre_sede,ID_ciudad,direccion)
VALUES ('la clavada',1,'Cra. 43A #10-12, El Poblado'),
('rosales plaza',2,'Cl. 72 #5-83, Chapinero'),
('caleñas vip',3,'Av. 6N #22N-15, Granada'),
('puerta de oro',4,'Cl. 84 #53-20, Alto Prado'),
('ocean view',5,'Cra. 1 #9-34, Bocagrande'),
('caribe imperial',5,'Cra. 3 #6-45, El Laguito'),
('Hotel Frontera Cúcuta', 14, 'Avenida Libertadores #5-67'),
('Hotel Real Bucaramanga', 6, 'Calle 36 #27-15'),
('Hotel Café Pereira', 8, 'Avenida Circunvalar #18-20'),
('Hotel Playa Santa Marta', 7, 'Carrera 1 #20-45'),
('Hotel Musical Ibagué', 15, 'Carrera 5 #12-34'),
('Hotel Nevado Manizales', 9, 'Carrera 23 #45-67'),
('Hotel Llanos Villavicencio', 11, 'Carrera 40 #25-30'),
('Hotel Río Neiva', 16, 'Calle 10 #8-22'),
('Hotel Quindío Armenia', 10, 'Calle 14 #8-22'),
('Hotel Vallenato Valledupar', 17, 'Carrera 19 #15-40'),
('Hotel Río Montería', 13, 'Carrera 7 #34-56'),
('Hotel Sur Pasto', 12, 'Calle 18 #12-40'),
('Hotel Colonial Popayán', 18, 'Carrera 9 #5-67'),
('Hotel Palma Palmira', 19, 'Calle 20 #10-30'),
('Hotel Pacífico Buenaventura', 20, 'Carrera 1 #25-50');

INSERT INTO TELEFONO_SEDE(ID_sede,telefono,tipo_contacto)
VALUES (1, 3004567890, 'Móvil'),
(2, 6041234567, 'Fijo'),
(3, 3105678901, 'Móvil'),
(4, 6041234568, 'Fijo'),
(5, 3156789012, 'Móvil'),
(6, 6041234569, 'Fijo'),
(7, 3207890123, 'Móvil'),
(8, 6041234570, 'Fijo'),
(9, 3218901234, 'Móvil'),
(10, 6041234571, 'Fijo'),
(11, 3229012345, 'Móvil'),
(12, 6041234572, 'Fijo'),
(13, 3130123456, 'Móvil'),
(14, 6041234573, 'Fijo'),
(15, 3141234567, 'Móvil'),
(16, 6041234574, 'Fijo'),
(17, 3162345678, 'Móvil'),
(18, 6041234575, 'Fijo'),
(19, 3173456789, 'Móvil'),
(20, 6041234576, 'Fijo'),
(21, 3184567890, 'Móvil');

USE Hotel
GO

INSERT INTO HABITACION(ID_tipo_habitacion,ID_sede,numero_habitacion,estado)
VALUES (1, 1, 101, 'Disponible'),
(1, 1, 102, 'Disponible'),
(2, 1, 103, 'Disponible'),
(2, 1, 104, 'Disponible'),
(3, 1, 105, 'Disponible'),

(4, 1, 201, 'Disponible'),
(4, 1, 202, 'Disponible'),
(5, 1, 203, 'Disponible'),
(5, 1, 204, 'Disponible'),
(6, 1, 205, 'Disponible'),

(7, 1, 301, 'Disponible'),
(7, 1, 302, 'Disponible'),
(8, 1, 303, 'Disponible'),
(8, 1, 304, 'Disponible'),
(9, 1, 305, 'Disponible'),

(10, 1, 401, 'Disponible'),
(10, 1, 402, 'Disponible'),
(11, 1, 403, 'Disponible'),
(11, 1, 404, 'Disponible'),
(12, 1, 405, 'Disponible'),

(1, 2, 101, 'Disponible'),
(1, 2, 102, 'Disponible'),
(2, 2, 103, 'Disponible'),
(2, 2, 104, 'Disponible'),
(3, 2, 105, 'Disponible'),

(4, 2, 201, 'Disponible'),
(4, 2, 202, 'Disponible'),
(5, 2, 203, 'Disponible'),
(5, 2, 204, 'Disponible'),
(6, 2, 205, 'Disponible'),

(7, 2, 301, 'Disponible'),
(7, 2, 302, 'Disponible'),
(8, 2, 303, 'Disponible'),
(8, 2, 304, 'Disponible'),
(9, 2, 305, 'Disponible'),

(10, 2, 401, 'Disponible'),
(10, 2, 402, 'Disponible'),
(11, 2, 403, 'Disponible'),
(11, 2, 404, 'Disponible'),
(12, 2, 405, 'Disponible'),

(1, 3, 101, 'Disponible'),
(1, 3, 102, 'Disponible'),
(2, 3, 103, 'Disponible'),
(2, 3, 104, 'Disponible'),
(3, 3, 105, 'Disponible'),

(4, 3, 201, 'Disponible'),
(4, 3, 202, 'Disponible'),
(5, 3, 203, 'Disponible'),
(5, 3, 204, 'Disponible'),
(6, 3, 205, 'Disponible'),

(7, 3, 301, 'Disponible'),
(7, 3, 302, 'Disponible'),
(8, 3, 303, 'Disponible'),
(8, 3, 304, 'Disponible'),
(9, 3, 305, 'Disponible'),

(10, 3, 401, 'Disponible'),
(10, 3, 402, 'Disponible'),
(11, 3, 403, 'Disponible'),
(11, 3, 404, 'Disponible'),
(12, 3, 405, 'Disponible'),

(1, 4, 101, 'Disponible'),
(1, 4, 102, 'Disponible'),
(2, 4, 103, 'Disponible'),
(2, 4, 104, 'Disponible'),
(3, 4, 105, 'Disponible'),

(4, 4, 201, 'Disponible'),
(4, 4, 202, 'Disponible'),
(5, 4, 203, 'Disponible'),
(5, 4, 204, 'Disponible'),
(6, 4, 205, 'Disponible'),

(7, 5, 301, 'Disponible'),
(7, 5, 302, 'Disponible'),
(8, 5, 303, 'Disponible'),
(8, 5, 304, 'Disponible'),
(9, 5, 305, 'Disponible'),

(10, 5, 401, 'Disponible'),
(10, 5, 402, 'Disponible'),
(11, 5, 403, 'Disponible'),
(11, 5, 404, 'Disponible'),
(12, 5, 405, 'Disponible'),

(1, 6, 101, 'Disponible'),
(1, 6, 102, 'Disponible'),
(2, 6, 103, 'Disponible'),
(2, 6, 104, 'Disponible'),
(3, 6, 105, 'Disponible'),

(4, 6, 201, 'Disponible'),
(4, 6, 202, 'Disponible'),
(5, 6, 203, 'Disponible'),
(5, 6, 204, 'Disponible'),
(6, 6, 205, 'Disponible'),

(7, 6, 301, 'Disponible'),
(7, 6, 302, 'Disponible'),
(8, 6, 303, 'Disponible'),
(8, 6, 304, 'Disponible'),
(9, 6, 305, 'Disponible'),

(10, 6, 401, 'Disponible'),
(10, 6, 402, 'Disponible'),
(11, 6, 403, 'Disponible'),
(11, 6, 404, 'Disponible'),
(12, 6, 405, 'Disponible'),

(1, 7, 101, 'Disponible'),
(1, 7, 102, 'Disponible'),
(2, 7, 103, 'Disponible'),
(2, 7, 104, 'Disponible'),
(3, 7, 105, 'Disponible'),

(4, 7, 201, 'Disponible'),
(4, 7, 202, 'Disponible'),
(5, 7, 203, 'Disponible'),
(5, 7, 204, 'Disponible'),
(6, 7, 205, 'Disponible'),

(7, 7, 301, 'Disponible'),
(7, 7, 302, 'Disponible'),
(8, 7, 303, 'Disponible'),
(8, 7, 304, 'Disponible'),
(9, 7, 305, 'Disponible'),

(10, 7, 401, 'Disponible'),
(10, 7, 402, 'Disponible'),
(11, 7, 403, 'Disponible'),
(11, 7, 404, 'Disponible'),
(12, 7, 405, 'Disponible'),

(1, 8, 101, 'Disponible'),
(1, 8, 102, 'Disponible'),
(2, 8, 103, 'Disponible'),
(2, 8, 104, 'Disponible'),
(3, 8, 105, 'Disponible'),

(4, 8, 201, 'Disponible'),
(4, 8, 202, 'Disponible'),
(5, 8, 203, 'Disponible'),
(5, 8, 204, 'Disponible'),
(6, 8, 205, 'Disponible'),

(7, 8, 301, 'Disponible'),
(7, 8, 302, 'Disponible'),
(8, 8, 303, 'Disponible'),
(8, 8, 304, 'Disponible'),
(9, 8, 305, 'Disponible'),

(10, 8, 401, 'Disponible'),
(10, 8, 402, 'Disponible'),
(11, 8, 403, 'Disponible'),
(11, 8, 404, 'Disponible'),
(12, 8, 405, 'Disponible'),

(1, 9, 101, 'Disponible'),
(1, 9, 102, 'Disponible'),
(2, 9, 103, 'Disponible'),
(2, 9, 104, 'Disponible'),
(3, 9, 105, 'Disponible'),

(4, 9, 201, 'Disponible'),
(4, 9, 202, 'Disponible'),
(5, 9, 203, 'Disponible'),
(5, 9, 204, 'Disponible'),
(6, 9, 205, 'Disponible'),

(7, 9, 301, 'Disponible'),
(7, 9, 302, 'Disponible'),
(8, 9, 303, 'Disponible'),
(8, 9, 304, 'Disponible'),
(9, 9, 305, 'Disponible'),

(10, 9, 401, 'Disponible'),
(10, 9, 402, 'Disponible'),
(11, 9, 403, 'Disponible'),
(11, 9, 404, 'Disponible'),
(12, 9, 405, 'Disponible'),

(1, 10, 101, 'Disponible'),
(1, 10, 102, 'Disponible'),
(2, 10, 103, 'Disponible'),
(2, 10, 104, 'Disponible'),
(3, 10, 105, 'Disponible'),

(4, 10, 201, 'Disponible'),
(4, 10, 202, 'Disponible'),
(5, 10, 203, 'Disponible'),
(5, 10, 204, 'Disponible'),
(6, 10, 205, 'Disponible'),

(7, 10, 301, 'Disponible'),
(7, 10, 302, 'Disponible'),
(8, 10, 303, 'Disponible'),
(8, 10, 304, 'Disponible'),
(9, 10, 305, 'Disponible'),

(10, 10, 401, 'Disponible'),
(10, 10, 402, 'Disponible'),
(11, 10, 403, 'Disponible'),
(11, 10, 404, 'Disponible'),
(12, 10, 405, 'Disponible'),

(1, 11, 101, 'Disponible'),
(1, 11, 102, 'Disponible'),
(2, 11, 103, 'Disponible'),
(2, 11, 104, 'Disponible'),
(3, 11, 105, 'Disponible'),

(4, 11, 201, 'Disponible'),
(4, 11, 202, 'Disponible'),
(5, 11, 203, 'Disponible'),
(5, 11, 204, 'Disponible'),
(6, 11, 205, 'Disponible'),

(7, 11, 301, 'Disponible'),
(7, 11, 302, 'Disponible'),
(8, 11, 303, 'Disponible'),
(8, 11, 304, 'Disponible'),
(9, 11, 305, 'Disponible'),

(10, 11, 401, 'Disponible'),
(10, 11, 402, 'Disponible'),
(11, 11, 403, 'Disponible'),
(11, 11, 404, 'Disponible'),
(12, 11, 405, 'Disponible'),

(1, 12, 101, 'Disponible'),
(1, 12, 102, 'Disponible'),
(2, 12, 103, 'Disponible'),
(2, 12, 104, 'Disponible'),
(3, 12, 105, 'Disponible'),

(4, 12, 201, 'Disponible'),
(4, 12, 202, 'Disponible'),
(5, 12, 203, 'Disponible'),
(5, 12, 204, 'Disponible'),
(6, 12, 205, 'Disponible'),

(7, 12, 301, 'Disponible'),
(7, 12, 302, 'Disponible'),
(8, 12, 303, 'Disponible'),
(8, 12, 304, 'Disponible'),
(9, 12, 305, 'Disponible'),

(10, 12, 401, 'Disponible'),
(10, 12, 402, 'Disponible'),
(11, 12, 403, 'Disponible'),
(11, 12, 404, 'Disponible'),
(12, 12, 405, 'Disponible'),

(1, 13, 101, 'Disponible'),
(1, 13, 102, 'Disponible'),
(2, 13, 103, 'Disponible'),
(2, 13, 104, 'Disponible'),
(3, 13, 105, 'Disponible'),

(4, 13, 201, 'Disponible'),
(4, 13, 202, 'Disponible'),
(5, 13, 203, 'Disponible'),
(5, 13, 204, 'Disponible'),
(6, 13, 205, 'Disponible'),

(7, 13, 301, 'Disponible'),
(7, 13, 302, 'Disponible'),
(8, 13, 303, 'Disponible'),
(8, 13, 304, 'Disponible'),
(9, 13, 305, 'Disponible'),

(10, 13, 401, 'Disponible'),
(10, 13, 402, 'Disponible'),
(11, 13, 403, 'Disponible'),
(11, 13, 404, 'Disponible'),
(12, 13, 405, 'Disponible'),

(1, 14, 101, 'Disponible'),
(1, 14, 102, 'Disponible'),
(2, 14, 103, 'Disponible'),
(2, 14, 104, 'Disponible'),
(3, 14, 105, 'Disponible'),

(4, 14, 201, 'Disponible'),
(4, 14, 202, 'Disponible'),
(5, 14, 203, 'Disponible'),
(5, 14, 204, 'Disponible'),
(6, 14, 205, 'Disponible'),

(7, 14, 301, 'Disponible'),
(7, 14, 302, 'Disponible'),
(8, 14, 303, 'Disponible'),
(8, 14, 304, 'Disponible'),
(9, 14, 305, 'Disponible'),

(10, 14, 401, 'Disponible'),
(10, 14, 402, 'Disponible'),
(11, 14, 403, 'Disponible'),
(11, 14, 404, 'Disponible'),
(12, 14, 405, 'Disponible'),

(1, 15, 101, 'Disponible'),
(1, 15, 102, 'Disponible'),
(2, 15, 103, 'Disponible'),
(2, 15, 104, 'Disponible'),
(3, 15, 105, 'Disponible'),

(4, 15, 201, 'Disponible'),
(4, 15, 202, 'Disponible'),
(5, 15, 203, 'Disponible'),
(5, 15, 204, 'Disponible'),
(6, 15, 205, 'Disponible'),

(7, 15, 301, 'Disponible'),
(7, 15, 302, 'Disponible'),
(8, 15, 303, 'Disponible'),
(8, 15, 304, 'Disponible'),
(9, 15, 305, 'Disponible'),

(10, 15, 401, 'Disponible'),
(10, 15, 402, 'Disponible'),
(11, 15, 403, 'Disponible'),
(11, 15, 404, 'Disponible'),
(12, 15, 405, 'Disponible'),

(1, 16, 101, 'Disponible'),
(1, 16, 102, 'Disponible'),
(2, 16, 103, 'Disponible'),
(2, 16, 104, 'Disponible'),
(3, 16, 105, 'Disponible'),

(4, 16, 201, 'Disponible'),
(4, 16, 202, 'Disponible'),
(5, 16, 203, 'Disponible'),
(5, 16, 204, 'Disponible'),
(6, 16, 205, 'Disponible'),

(7, 16, 301, 'Disponible'),
(7, 16, 302, 'Disponible'),
(8, 16, 303, 'Disponible'),
(8, 16, 304, 'Disponible'),
(9, 16, 305, 'Disponible'),

(10, 16, 401, 'Disponible'),
(10, 16, 402, 'Disponible'),
(11, 16, 403, 'Disponible'),
(11, 16, 404, 'Disponible'),
(12, 16, 405, 'Disponible'),

(1, 17, 101, 'Disponible'),
(1, 17, 102, 'Disponible'),
(2, 17, 103, 'Disponible'),
(2, 17, 104, 'Disponible'),
(3, 17, 105, 'Disponible'),

(4, 17, 201, 'Disponible'),
(4, 17, 202, 'Disponible'),
(5, 17, 203, 'Disponible'),
(5, 17, 204, 'Disponible'),
(6, 17, 205, 'Disponible'),

(7, 17, 301, 'Disponible'),
(7, 17, 302, 'Disponible'),
(8, 17, 303, 'Disponible'),
(8, 17, 304, 'Disponible'),
(9, 17, 305, 'Disponible'),

(10, 17, 401, 'Disponible'),
(10, 17, 402, 'Disponible'),
(11, 17, 403, 'Disponible'),
(11, 17, 404, 'Disponible'),
(12, 17, 405, 'Disponible'),

(1, 18, 101, 'Disponible'),
(1, 18, 102, 'Disponible'),
(2, 18, 103, 'Disponible'),
(2, 18, 104, 'Disponible'),
(3, 18, 105, 'Disponible'),

(4, 18, 201, 'Disponible'),
(4, 18, 202, 'Disponible'),
(5, 18, 203, 'Disponible'),
(5, 18, 204, 'Disponible'),
(6, 18, 205, 'Disponible'),

(7, 18, 301, 'Disponible'),
(7, 18, 302, 'Disponible'),
(8, 18, 303, 'Disponible'),
(8, 18, 304, 'Disponible'),
(9, 18, 305, 'Disponible'),

(10, 18, 401, 'Disponible'),
(10, 18, 402, 'Disponible'),
(11, 18, 403, 'Disponible'),
(11, 18, 404, 'Disponible'),
(12, 18, 405, 'Disponible'),

(1, 19, 101, 'Disponible'),
(1, 19, 102, 'Disponible'),
(2, 19, 103, 'Disponible'),
(2, 19, 104, 'Disponible'),
(3, 19, 105, 'Disponible'),

(4, 19, 201, 'Disponible'),
(4, 19, 202, 'Disponible'),
(5, 19, 203, 'Disponible'),
(5, 19, 204, 'Disponible'),
(6, 19, 205, 'Disponible'),

(7, 19, 301, 'Disponible'),
(7, 19, 302, 'Disponible'),
(8, 19, 303, 'Disponible'),
(8, 19, 304, 'Disponible'),
(9, 19, 305, 'Disponible'),

(10, 19, 401, 'Disponible'),
(10, 19, 402, 'Disponible'),
(11, 19, 403, 'Disponible'),
(11, 19, 404, 'Disponible'),
(12, 19, 405, 'Disponible'),

(1, 20, 101, 'Disponible'),
(1, 20, 102, 'Disponible'),
(2, 20, 103, 'Disponible'),
(2, 20, 104, 'Disponible'),
(3, 20, 105, 'Disponible'),

(4, 20, 201, 'Disponible'),
(4, 20, 202, 'Disponible'),
(5, 20, 203, 'Disponible'),
(5, 20, 204, 'Disponible'),
(6, 20, 205, 'Disponible'),

(7, 20, 301, 'Disponible'),
(7, 20, 302, 'Disponible'),
(8, 20, 303, 'Disponible'),
(8, 20, 304, 'Disponible'),
(9, 20, 305, 'Disponible'),

(10, 20, 401, 'Disponible'),
(10, 20, 402, 'Disponible'),
(11, 20, 403, 'Disponible'),
(11, 20, 404, 'Disponible'),
(12, 20, 405, 'Disponible'),

(1, 21, 101, 'Disponible'),
(1, 21, 102, 'Disponible'),
(2, 21, 103, 'Disponible'),
(2, 21, 104, 'Disponible'),
(3, 21, 105, 'Disponible'),

(4, 21, 201, 'Disponible'),
(4, 21, 202, 'Disponible'),
(5, 21, 203, 'Disponible'),
(5, 21, 204, 'Disponible'),
(6, 21, 205, 'Disponible'),

(7, 21, 301, 'Disponible'),
(7, 21, 302, 'Disponible'),
(8, 21, 303, 'Disponible'),
(8, 21, 304, 'Disponible'),
(9, 21, 305, 'Disponible'),

(10, 21, 401, 'Disponible'),
(10, 21, 402, 'Disponible'),
(11, 21, 403, 'Disponible'),
(11, 21, 404, 'Disponible'),
(12, 21, 405, 'Disponible');

SET DATEFORMAT ymd;

INSERT INTO RESERVA(ID_huesped,fecha_reserva,fecha_entrada,fecha_salida,cantidad_menores,cantidad_adultos)
VALUES (1, '2026-09-01', '2026-09-05', '2026-09-10', 0, 2),
(2, '2026-09-02', '2026-09-06', '2026-09-08', 1, 2),
(3, '2026-09-03', '2026-09-07', '2026-09-12', 2, 3),
(4, '2026-09-04', '2026-09-09', '2026-09-11', 0, 1),
(5, '2026-09-05', '2026-09-10', '2026-09-15', 1, 4),
(6, '2026-09-06', '2026-09-11', '2026-09-13', 0, 2),
(7, '2026-09-07', '2026-09-12', '2026-09-14', 2, 2),
(8, '2026-09-08', '2026-09-13', '2026-09-16', 0, 3),
(9, '2026-09-09', '2026-09-14', '2026-09-18', 1, 2),
(10, '2026-09-10', '2026-09-15', '2026-09-19', 0, 1),
(11, '2026-09-11', '2026-09-16', '2026-09-20', 3, 2),
(12, '2026-09-12', '2026-09-17', '2026-09-21', 0, 4),
(13, '2026-09-13', '2026-09-18', '2026-09-22', 1, 1),
(14, '2026-09-14', '2026-09-19', '2026-09-23', 2, 3),
(15, '2026-09-15', '2026-09-20', '2026-09-24', 0, 2),
(16, '2026-09-16', '2026-09-21', '2026-09-25', 1, 2),
(17, '2026-09-17', '2026-09-22', '2026-09-26', 0, 5),
(18, '2026-09-18', '2026-09-23', '2026-09-27', 2, 2),
(19, '2026-09-19', '2026-09-24', '2026-09-28', 0, 3),
(20, '2026-09-20', '2026-09-25', '2026-09-29', 1, 2);

INSERT INTO RESERVA_HABITACION(ID_reserva,ID_habitacion)
VALUES (1, 1),
(2, 5), 
(2, 6),
(3, 10), 
(3, 11), 
(3, 12),
(4, 15),
(5, 20), 
(5, 21),
(6, 25),
(7, 30), 
(7, 31),
(8, 35),
(9, 40), 
(9, 41),
(10, 45),
(11, 50), 
(11, 51), 
(11, 52),
(12, 55), 
(12, 56),
(13, 60),
(14, 65), 
(14, 66),
(15, 70),
(16, 75), 
(16, 76),
(17, 80), 
(17, 81), 
(17, 82),
(18, 85), 
(18, 86),
(19, 90),
(20, 95), 
(20, 96);

INSERT INTO RESERVA_SERVICIO(ID_reserva,ID_servicio,cantidad_servicio,subtotal)
VALUES (1, 1, 2, 90000),   
(2, 2, 3, 90000),   
(3, 3, 1, 120000),  
(4, 4, 2, 50000),   
(5, 5, 1, 20000),   
(6, 6, 1, 80000),   
(7, 7, 2, 70000),  
(8, 8, 1, 40000),   
(9, 9, 3, 45000),   
(10, 10, 1, 25000), 
(11, 11, 1, 100000),
(12, 12, 2, 40000), 
(13, 13, 1, 50000), 
(14, 14, 2, 70000), 
(15, 15, 1, 60000), 
(16, 16, 1, 90000), 
(17, 17, 2, 50000), 
(18, 18, 1, 15000), 
(19, 19, 1, 70000), 
(20, 20, 1, 200000);

INSERT INTO FACTURA(ID_reserva,fecha_factura,total_factura,estado)
VALUES (1, '2026-09-01', 170000, 'Pagada'),
(2, '2026-09-02', 330000, 'Pagada'),
(3, '2026-09-03', 570000, 'Pagada'),
(4, '2026-09-04', 250000, 'Pagada'),
(5, '2026-09-05', 520000, 'Pagada'),
(6, '2026-09-06', 400000, 'Pagada'),
(7, '2026-09-07', 1270000, 'Pagada'),
(8, '2026-09-08', 260000, 'Pagada'),
(9, '2026-09-09', 605000, 'Pagada'),
(10, '2026-09-10', 165000, 'Pagada'),
(11, '2026-09-11', 730000, 'Pagada'),
(12, '2026-09-12', 580000, 'Pagada'),
(13, '2026-09-13', 130000, 'Pagada'),
(14, '2026-09-14', 310000, 'Pagada'),
(15, '2026-09-15', 210000, 'Pagada'),
(16, '2026-09-16', 490000, 'Pagada'),
(17, '2026-09-17', 800000, 'Pagada'),
(18, '2026-09-18', 655000, 'Pagada'),
(19, '2026-09-19', 670000, 'Pagada'),
(20, '2026-09-20', 740000, 'Pagada');

INSERT INTO PAGO(ID_factura,metodo_pago,monto_pago,fecha_pago)
VALUES (1, 'Tarjeta Crédito', 170000, '2026-09-02'),
(2, 'Transferencia Bancaria', 150000, '2026-09-03'),
(2, 'Transferencia Bancaria', 180000, '2026-09-04'),
(3, 'Tarjeta Débito', 300000, '2026-09-05'),
(3, 'Tarjeta Débito', 270000, '2026-09-06'),
(4, 'Efectivo', 250000, '2026-09-05'),
(5, 'Tarjeta Crédito', 300000, '2026-09-06'),
(5, 'Tarjeta Crédito', 220000, '2026-09-07'),
(6, 'Transferencia Bancaria', 400000, '2026-09-07'),
(7, 'Tarjeta Crédito', 600000, '2026-09-08'),
(7, 'Tarjeta Crédito', 670000, '2026-09-09'),
(8, 'Efectivo', 260000, '2026-09-09'),
(9, 'Tarjeta Débito', 305000, '2026-09-10'),
(9, 'Tarjeta Débito', 300000, '2026-09-11'),
(10, 'Transferencia Bancaria', 165000, '2026-09-10'),
(11, 'Tarjeta Crédito', 400000, '2026-09-12'),
(11, 'Tarjeta Crédito', 330000, '2026-09-13'),
(12, 'Efectivo', 580000, '2026-09-13'),
(13, 'Tarjeta Débito', 130000, '2026-09-14'),
(14, 'Transferencia Bancaria', 310000, '2026-09-14'),
(15, 'Efectivo', 210000, '2026-09-15'),
(16, 'Tarjeta Crédito', 250000, '2026-09-16'),
(16, 'Tarjeta Crédito', 240000, '2026-09-17'),
(17, 'Transferencia Bancaria', 400000, '2026-09-17'),
(17, 'Transferencia Bancaria', 400000, '2026-09-18'),
(18, 'Tarjeta Débito', 655000, '2026-09-18'),
(19, 'Efectivo', 670000, '2026-09-19'),
(20, 'Tarjeta Crédito', 370000, '2026-09-20'),
(20, 'Tarjeta Crédito', 370000, '2026-09-21');

-- CONSULTAS SELECT

-- Consulta 1: huéspedes por edad
SELECT
    edad,
    COUNT(*) AS cantidad_huespedes
FROM HUESPED
WHERE edad BETWEEN 18 AND 60
GROUP BY edad
HAVING COUNT(*) >= 1
ORDER BY edad ASC;
GO

-- Consulta 2: tipos de habitación con precio mayor a 100000
SELECT
    nombre_tipo,
    COUNT(*) AS cantidad_tipos,
    AVG(precio_habitacion) AS precio_promedio
FROM TIPO_HABITACION
WHERE precio_habitacion > 100000
GROUP BY nombre_tipo
HAVING COUNT(*) >= 1
ORDER BY precio_promedio DESC;
GO

-- Consulta 3: habitaciones según estado
SELECT
    estado,
    COUNT(*) AS total_habitaciones
FROM HABITACION
WHERE estado IN ('Disponible', 'Ocupada', 'Mantenimiento')
GROUP BY estado
HAVING COUNT(*) > 0
ORDER BY total_habitaciones DESC;
GO

-- Consulta 4: reservas por cantidad de adultos
SELECT
    cantidad_adultos,
    COUNT(*) AS total_reservas
FROM RESERVA
WHERE cantidad_adultos >= 1
GROUP BY cantidad_adultos
HAVING COUNT(*) >= 1
ORDER BY total_reservas DESC, cantidad_adultos ASC;
GO

-- Consulta 5: teléfonos por tipo de contacto
SELECT
    tipo_contacto,
    COUNT(*) AS total_telefonos
FROM TELEFONO_HUESPED
WHERE tipo_contacto IS NOT NULL
GROUP BY tipo_contacto
HAVING COUNT(*) >= 1
ORDER BY total_telefonos DESC, tipo_contacto ASC;
GO


-- CONSULTAS JOIN

--π_{nombre_huesped, apellido_huesped, fecha_entrada, fecha_salida}( σ_{h.ID_huesped = r.ID_huesped}(HUESPED × RESERVA) )

SELECT nombre_huesped,h.apellido_huesped,r.fecha_entrada,r.fecha_salida
FROM HUESPED h
INNER JOIN RESERVA r
ON r.ID_huesped = h.ID_huesped

-- π_{ID_reserva, ID_sede, numero_habitacion}( HABITACION ⟕_{h.ID_habitacion = rh.ID_habitacion} RESERVA_HABITACION )

SELECT rh.ID_reserva,h.ID_sede,h.numero_habitacion
FROM HABITACION h
LEFT JOIN RESERVA_HABITACION rh
ON rh.ID_habitacion = h.ID_habitacion

-- π_{nombre_tipo, numero_habitacion}( HABITACION ⟖_{h.ID_tipo_habitacion = tp.ID_tipo_habitacion} TIPO_HABITACION )

SELECT tp.nombre_tipo,h.numero_habitacion
FROM HABITACION h
RIGHT JOIN TIPO_HABITACION tp
ON h.ID_tipo_habitacion = tp.ID_tipo_habitacion

-- π_{ID_habitacion, numero_habitacion}( HABITACION ⟗_{h.ID_habitacion = rh.ID_habitacion} RESERVA_HABITACION )

SELECT rh.ID_habitacion, h.numero_habitacion
FROM HABITACION h
FULL JOIN RESERVA_HABITACION rh
ON h.ID_habitacion = rh.ID_habitacion

-- π_{nombre_huesped, apellido_huesped, tipo_servicio}(HUESPED × SERVICIO)

SELECT h.nombre_huesped,h.apellido_huesped, s.tipo_servicio
FROM HUESPED h
CROSS JOIN SERVICIO s

-- MANIPULACION DE DATOS Y ESTRUCTURA

-- 1.1 
DELETE TOP (1)
FROM PAGO;

GO
-- 1.2

DELETE TOP (1)
FROM RESERVA_SERVICIO;

GO
-- 1.3 

DELETE TOP (1)
FROM RESERVA_HABITACION;

GO

-- 1.4

DELETE TOP (1)
FROM TELEFONO_SEDE;

GO

-- 1.5 

DELETE TOP (1)
FROM TELEFONO_HUESPED;

GO

-- 2.1
UPDATE TOP (1) SERVICIO
SET precio_servicio = precio_servicio + 5000;
GO

-- 2.2
UPDATE TOP (1) CIUDAD
SET nombre_ciudad = 'Medellin';
GO

-- 2.3
UPDATE TOP (1) HUESPED
SET correo = 'correo_actualizado@hotel.com';
GO

-- 2.4
UPDATE TOP (1) SEDE
SET direccion = 'Carrera 50 # 50-20';
GO

-- 2.5
UPDATE TOP (1) HABITACION
SET estado = 'Disponible';
GO


-- 3.1
ALTER TABLE TELEFONO_SEDE
DROP COLUMN tipo_contacto;
GO

-- 3.2
ALTER TABLE TELEFONO_HUESPED
DROP COLUMN tipo_contacto;
GO

-- 3.3
ALTER TABLE HABITACION
DROP COLUMN estado;
GO

-- 3.4
ALTER TABLE FACTURA
DROP COLUMN estado;
GO

-- 3.5
ALTER TABLE SEDE
DROP COLUMN direccion;
GO

-- 4.1
ALTER TABLE CIUDAD
ALTER COLUMN nombre_ciudad VARCHAR(150) NOT NULL;
GO

-- 4.2
ALTER TABLE SERVICIO
ALTER COLUMN tipo_servicio VARCHAR(150) NOT NULL;
GO

-- 4.3
ALTER TABLE HUESPED
ALTER COLUMN correo VARCHAR(250) NOT NULL;
GO

-- 4.4
ALTER TABLE SEDE
ALTER COLUMN nombre_sede VARCHAR(150) NOT NULL;
GO

-- 4.5
ALTER TABLE HABITACION
ALTER COLUMN numero_habitacion VARCHAR(20) NOT NULL;
GO

-- 5.1
ALTER TABLE SERVICIO
ADD descripcion VARCHAR(250) NULL;
GO

-- 5.2
ALTER TABLE CIUDAD
ADD codigo_postal VARCHAR(20) NULL;
GO

-- 5.3
ALTER TABLE HUESPED
ADD telefono_emergencia VARCHAR(50) NULL;
GO

-- 5.4
ALTER TABLE HABITACION
ADD observaciones VARCHAR(250) NULL;
GO

-- 5.5
ALTER TABLE FACTURA
ADD observaciones VARCHAR(250) NULL;
GO