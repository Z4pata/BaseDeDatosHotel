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