USE Hotel;
GO

--Huesped CRUD

CREATE OR ALTER PROCEDURE sp_Huesped_Insertar
    @nombre_huesped VARCHAR(100),
    @apellido_huesped VARCHAR(100),
    @documento VARCHAR(20),
    @correo VARCHAR(100),
    @edad INT
AS
BEGIN
    INSERT INTO HUESPED
    (
        nombre_huesped,
        apellido_huesped,
        documento,
        correo,
        edad
    )
    VALUES
    (
        @nombre_huesped,
        @apellido_huesped,
        @documento,
        @correo,
        @edad
    );
END
GO

CREATE OR ALTER PROCEDURE sp_Huesped_Consultar
AS
BEGIN
    SELECT *
    FROM HUESPED;
END
GO

CREATE OR ALTER PROCEDURE sp_Huesped_ConsultarId
    @id_huesped INT
AS
BEGIN
    SELECT *
    FROM HUESPED
    WHERE id_huesped = @id_huesped;
END
GO

CREATE OR ALTER PROCEDURE sp_Huesped_Actualizar
    @id_huesped INT,
    @nombre_huesped VARCHAR(100),
    @apellido_huesped VARCHAR(100),
    @documento VARCHAR(20),
    @correo VARCHAR(100),
    @edad INT
AS
BEGIN
    UPDATE HUESPED
    SET
        nombre_huesped = @nombre_huesped,
        apellido_huesped = @apellido_huesped,
        documento = @documento,
        correo = @correo,
        edad = @edad
    WHERE id_huesped = @id_huesped;
END
GO

CREATE OR ALTER PROCEDURE sp_Huesped_Eliminar
    @id_huesped INT
AS
BEGIN
    DELETE FROM HUESPED
    WHERE id_huesped = @id_huesped;
END
GO

--Servicio CRUD

CREATE OR ALTER PROCEDURE sp_Servicio_Insertar
    @tipo_servicio VARCHAR(100),
    @precio_servicio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO SERVICIO
    (
        tipo_servicio,
        precio_servicio
    )
    VALUES
    (
        @tipo_servicio,
        @precio_servicio
    );
END
GO

CREATE OR ALTER PROCEDURE sp_Servicio_Consultar
AS
BEGIN
    SELECT *
    FROM SERVICIO;
END
GO

CREATE OR ALTER PROCEDURE sp_Servicio_ConsultarId
    @id_servicio INT
AS
BEGIN
    SELECT *
    FROM SERVICIO
    WHERE id_servicio = @id_servicio;
END
GO

CREATE OR ALTER PROCEDURE sp_Servicio_Actualizar
    @id_servicio INT,
    @tipo_servicio VARCHAR(100),
    @precio_servicio DECIMAL(10,2)
AS
BEGIN
    UPDATE SERVICIO
    SET
        tipo_servicio = @tipo_servicio,
        precio_servicio = @precio_servicio
    WHERE id_servicio = @id_servicio;
END
GO

CREATE OR ALTER PROCEDURE sp_Servicio_Eliminar
    @id_servicio INT
AS
BEGIN
    DELETE FROM SERVICIO
    WHERE id_servicio = @id_servicio;
END
GO

--Ciudad CRUD

CREATE OR ALTER PROCEDURE sp_Ciudad_Insertar
    @nombre_ciudad VARCHAR(100)
AS
BEGIN
    INSERT INTO CIUDAD(nombre_ciudad)
    VALUES(@nombre_ciudad);
END
GO

CREATE OR ALTER PROCEDURE sp_Ciudad_Consultar
AS
BEGIN
    SELECT *
    FROM CIUDAD;
END
GO

CREATE OR ALTER PROCEDURE sp_Ciudad_Actualizar
    @id_ciudad INT,
    @nombre_ciudad VARCHAR(100)
AS
BEGIN
    UPDATE CIUDAD
    SET nombre_ciudad = @nombre_ciudad
    WHERE id_ciudad = @id_ciudad;
END
GO

CREATE OR ALTER PROCEDURE sp_Ciudad_Eliminar
    @id_ciudad INT
AS
BEGIN
    DELETE FROM CIUDAD
    WHERE id_ciudad = @id_ciudad;
END
GO

-- Sede CRUD

CREATE OR ALTER PROCEDURE sp_Sede_Insertar
    @id_ciudad INT,
    @nombre_sede VARCHAR(100),
    @direccion VARCHAR(200)
AS
BEGIN
    INSERT INTO SEDE
    (
        id_ciudad,
        nombre_sede,
        direccion
    )
    VALUES
    (
        @id_ciudad,
        @nombre_sede,
        @direccion
    );
END
GO

CREATE OR ALTER PROCEDURE sp_Sede_Consultar
AS
BEGIN
    SELECT *
    FROM SEDE;
END
GO

CREATE OR ALTER PROCEDURE sp_Sede_Actualizar
    @id_sede INT,
    @id_ciudad INT,
    @nombre_sede VARCHAR(100),
    @direccion VARCHAR(200)
AS
BEGIN
    UPDATE SEDE
    SET
        id_ciudad = @id_ciudad,
        nombre_sede = @nombre_sede,
        direccion = @direccion
    WHERE id_sede = @id_sede;
END
GO

CREATE OR ALTER PROCEDURE sp_Sede_Eliminar
    @id_sede INT
AS
BEGIN
    DELETE FROM SEDE
    WHERE id_sede = @id_sede;
END
GO

--Tipo Habitacion CRUD

CREATE OR ALTER PROCEDURE sp_TipoHabitacion_Insertar
    @nombre_tipo VARCHAR(100),
    @capacidad INT,
    @precio_habitacion DECIMAL(10,2)
AS
BEGIN
    INSERT INTO TIPO_HABITACION
    (
        nombre_tipo,
        capacidad,
        precio_habitacion
    )
    VALUES
    (
        @nombre_tipo,
        @capacidad,
        @precio_habitacion
    );
END
GO

CREATE OR ALTER PROCEDURE sp_TipoHabitacion_Consultar
AS
BEGIN
    SELECT *
    FROM TIPO_HABITACION;
END
GO

CREATE OR ALTER PROCEDURE sp_TipoHabitacion_Actualizar
    @id_tipo_habitacion INT,
    @nombre_tipo VARCHAR(100),
    @capacidad INT,
    @precio_habitacion DECIMAL(10,2)
AS
BEGIN
    UPDATE TIPO_HABITACION
    SET
        nombre_tipo = @nombre_tipo,
        capacidad = @capacidad,
        precio_habitacion = @precio_habitacion
    WHERE id_tipo_habitacion = @id_tipo_habitacion;
END
GO

CREATE OR ALTER PROCEDURE sp_TipoHabitacion_Eliminar
    @id_tipo_habitacion INT
AS
BEGIN
    DELETE FROM TIPO_HABITACION
    WHERE id_tipo_habitacion = @id_tipo_habitacion;
END
GO

--Habitacion CRUD

CREATE OR ALTER PROCEDURE sp_Habitacion_Insertar
    @id_sede INT,
    @id_tipo_habitacion INT,
    @numero_habitacion VARCHAR(20),
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO HABITACION
    (
        id_sede,
        id_tipo_habitacion,
        numero_habitacion,
        estado
    )
    VALUES
    (
        @id_sede,
        @id_tipo_habitacion,
        @numero_habitacion,
        @estado
    );
END
GO

CREATE OR ALTER PROCEDURE sp_Habitacion_Consultar
AS
BEGIN
    SELECT *
    FROM HABITACION;
END
GO

CREATE OR ALTER PROCEDURE sp_Habitacion_Actualizar
    @id_habitacion INT,
    @id_sede INT,
    @id_tipo_habitacion INT,
    @numero_habitacion VARCHAR(20),
    @estado VARCHAR(50)
AS
BEGIN
    UPDATE HABITACION
    SET
        id_sede = @id_sede,
        id_tipo_habitacion = @id_tipo_habitacion,
        numero_habitacion = @numero_habitacion,
        estado = @estado
    WHERE id_habitacion = @id_habitacion;
END
GO

CREATE OR ALTER PROCEDURE sp_Habitacion_Eliminar
    @id_habitacion INT
AS
BEGIN
    DELETE FROM HABITACION
    WHERE id_habitacion = @id_habitacion;
END
GO

-- Reserva CRUD

CREATE OR ALTER PROCEDURE sp_Reserva_Insertar
    @id_huesped INT,
    @fecha_reserva DATE,
    @fecha_entrada DATE,
    @fecha_salida DATE,
    @cantidad_adultos INT,
    @cantidad_menores INT
AS
BEGIN

    IF @fecha_salida <= @fecha_entrada
    BEGIN
        RAISERROR('La fecha de salida debe ser mayor a la fecha de entrada.',16,1);
        RETURN;
    END

    INSERT INTO RESERVA
    (
        id_huesped,
        fecha_reserva,
        fecha_entrada,
        fecha_salida,
        cantidad_adultos,
        cantidad_menores
    )
    VALUES
    (
        @id_huesped,
        @fecha_reserva,
        @fecha_entrada,
        @fecha_salida,
        @cantidad_adultos,
        @cantidad_menores
    );
END
GO

CREATE OR ALTER PROCEDURE sp_Reserva_Consultar
AS
BEGIN
    SELECT *
    FROM RESERVA;
END
GO

CREATE OR ALTER PROCEDURE sp_Reserva_Eliminar
    @id_reserva INT
AS
BEGIN
    DELETE FROM RESERVA
    WHERE id_reserva = @id_reserva;
END
GO

-- Factura insertar

CREATE OR ALTER PROCEDURE sp_Factura_Insertar
    @id_reserva INT,
    @fecha_factura DATE,
    @total_factura DECIMAL(12,2),
    @estado VARCHAR(50)
AS
BEGIN
    INSERT INTO FACTURA
    (
        id_reserva,
        fecha_factura,
        total_factura,
        estado
    )
    VALUES
    (
        @id_reserva,
        @fecha_factura,
        @total_factura,
        @estado
    );
END
GO

--Pago insertar

CREATE OR ALTER PROCEDURE sp_Pago_Insertar
    @id_factura INT,
    @metodo_pago VARCHAR(50),
    @monto_pago DECIMAL(12,2)
AS
BEGIN
    INSERT INTO PAGO
    (
        id_factura,
        metodo_pago,
        monto_pago
    )
    VALUES
    (
        @id_factura,
        @metodo_pago,
        @monto_pago
    );
END
GO

--Telefono Huesped Insertar

CREATE OR ALTER PROCEDURE sp_TelefonoHuesped_Insertar
(
    @ID_telefono INT,
    @ID_huesped INT,
    @telefono VARCHAR(50),
    @tipo_contacto VARCHAR(50)
)
AS
BEGIN
    INSERT INTO TELEFONO_HUESPED
    (
        ID_telefono,
        ID_huesped,
        telefono,
        tipo_contacto
    )
    VALUES
    (
        @ID_telefono,
        @ID_huesped,
        @telefono,
        @tipo_contacto
    );
END
GO

--Telefono Sede Insertar

CREATE OR ALTER PROCEDURE sp_TelefonoSede_Insertar
(
    @ID_telefono INT,
    @ID_sede INT,
    @telefono VARCHAR(50),
    @tipo_contacto VARCHAR(50)
)
AS
BEGIN
    INSERT INTO TELEFONO_SEDE
    (
        ID_telefono,
        ID_sede,
        telefono,
        tipo_contacto
    )
    VALUES
    (
        @ID_telefono,
        @ID_sede,
        @telefono,
        @tipo_contacto
    );
END
GO