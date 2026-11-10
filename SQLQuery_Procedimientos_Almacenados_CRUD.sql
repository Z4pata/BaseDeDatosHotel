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

-- Insert tabla intermedia RESERVA_HABITACION
CREATE OR ALTER PROCEDURE sp_ReservaHabitacion_Insertar 
    @id_reserva INT, 
    @id_habitacion INT 
AS 
BEGIN 
    SET NOCOUNT ON; 
    -- 1. Validar que la reserva exista 
    IF NOT EXISTS (SELECT 1 FROM RESERVA WHERE ID_reserva = @id_reserva) 
        BEGIN 
            RAISERROR('La reserva especificada no existe.', 16, 1); 
            RETURN; 
        END 
    -- 2. Validar que la habitación exista 
    IF NOT EXISTS (SELECT 1 FROM HABITACION WHERE ID_habitacion = @id_habitacion) 
        BEGIN 
            RAISERROR('La habitación especificada no existe.', 16, 1); 
            RETURN; 
        END 
    -- 3. Validar que la habitación esté disponible 
    IF EXISTS (SELECT 1 FROM HABITACION WHERE ID_habitacion = @id_habitacion AND estado <> 'Disponible') 
    BEGIN 
        RAISERROR('La habitación seleccionada no se encuentra disponible.', 16, 1); 
        RETURN; 
    END 
    -- 4. Validar que la habitación no esté asignada previamente a esta misma reserva 
    IF EXISTS (SELECT 1 FROM RESERVA_HABITACION WHERE ID_reserva = @id_reserva AND ID_habitacion = @id_habitacion) 
    BEGIN 
        RAISERROR('La habitación ya está asignada a esta reserva.', 16, 1); 
        RETURN; 
    END 
    -- 5. Insertar la relación (El trigger trg\_MarcarHabitacionOcupada cambiará el estado a 'Ocupada') 
    INSERT INTO RESERVA_HABITACION (ID_reserva, ID_habitacion) VALUES (@id_reserva, @id_habitacion); 
END; 
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

-- Creacion completa de la reserva, con su habitacion

CREATE OR ALTER PROCEDURE sp_ReservaCompleta_Insertar 
    @id_huesped INT, 
    @fecha_reserva DATE, 
    @fecha_entrada DATE, 
    @fecha_salida DATE, 
    @cantidad_adultos INT, 
    @cantidad_menores INT, 
    @id_habitacion INT 
AS 
BEGIN 
    SET NOCOUNT ON; 
    BEGIN TRY 
    -- 1. Iniciar la transacción 
        BEGIN TRANSACTION; 
        -- Validar fechas 
            IF @fecha_salida <= @fecha_entrada 
            BEGIN 
                RAISERROR('La fecha de salida debe ser mayor a la fecha de entrada.', 16, 1); 
            END 
        -- 2. Insertar en la tabla RESERVA 
        INSERT INTO RESERVA (
            ID_huesped, 
            fecha_reserva, 
            fecha_entrada, 
            fecha_salida, 
            cantidad_adultos, 
            cantidad_menores) 
            VALUES (@id_huesped, @fecha_reserva, @fecha_entrada, @fecha_salida, @cantidad_adultos, @cantidad_menores); 
            -- Obtener el ID de la reserva recién generada 
            DECLARE @id_reserva INT = SCOPE_IDENTITY(); 
            
            -- 3. Llamar al SP para asignar la habitación (ejecuta validaciones y dispara el trigger) 
            EXEC sp_ReservaHabitacion_Insertar @id_reserva = @id_reserva, @id_habitacion = @id_habitacion; 
            
            -- 4. Si todo salió bien, confirmar la transacción en la base de datos 
        COMMIT TRANSACTION; 
    END TRY 
    BEGIN CATCH 
    -- 5. Si ocurrió cualquier error en el proceso, revertir TODO 
        IF @@TRANCOUNT > 0 
            ROLLBACK TRANSACTION; 
        -- Relanzar el mensaje de error para que lo reciba el Backend (.NET) 
        THROW; 
    END CATCH 
END; 
GO

CREATE OR ALTER PROCEDURE sp_Reserva_Consultar
AS
BEGIN
    SELECT *
    FROM RESERVA;
END
GO

CREATE OR ALTER PROCEDURE sp_Reserva_ConsultarId
    @id_reserva INT
AS
BEGIN
    SELECT *
    FROM RESERVA
    WHERE ID_reserva = @id_reserva;
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

-- Reserva completa eliminar
CREATE OR ALTER PROCEDURE sp_ReservaCompleta_Eliminar
    @id_reserva INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

            DELETE FROM RESERVA_HABITACION
                WHERE id_reserva = @id_reserva;

            EXEC sp_Reserva_Eliminar @id_reserva = @id_reserva;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 
                ROLLBACK TRANSACTION; 
            -- Relanzar el mensaje de error para que lo reciba el Backend (.NET) 
            THROW; 
    END CATCH
END;

-- Contratar un servicio
CREATE OR ALTER PROCEDURE sp_Reserva_Servicio_Insertar
    @ID_reserva INT,
    @ID_servicio INT,
    @cantidad_servicio INT = 1
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @precio_servicio DECIMAL(18, 2);
    DECLARE @subtotal DECIMAL(18, 2);
    DECLARE @ID_detalle INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @cantidad_servicio <= 0
        BEGIN
            THROW 50001, 'La cantidad del servicio debe ser mayor que cero.', 1;
        END;

        IF NOT EXISTS (
            SELECT 1
            FROM dbo.RESERVA
            WHERE ID_reserva = @ID_reserva
        )
        BEGIN
            THROW 50002, 'La reserva indicada no existe.', 1;
        END;

        SELECT @precio_servicio = precio_servicio
        FROM dbo.SERVICIO
        WHERE ID_servicio = @ID_servicio;

        IF @precio_servicio IS NULL
        BEGIN
            THROW 50003, 'El servicio indicado no existe.', 1;
        END;

        SET @subtotal = @precio_servicio * @cantidad_servicio;

        INSERT INTO dbo.RESERVA_SERVICIO
        (
            ID_reserva,
            ID_servicio,
            cantidad_servicio,
            subtotal
        )
        VALUES
        (
            @ID_reserva,
            @ID_servicio,
            @cantidad_servicio,
            @subtotal
        );

        SET @ID_detalle = CONVERT(INT, SCOPE_IDENTITY());

        COMMIT TRANSACTION;

        SELECT
            rs.ID_detalle,
            rs.ID_reserva,
            rs.ID_servicio,
            s.tipo_servicio,
            rs.cantidad_servicio,
            s.precio_servicio,
            rs.subtotal
        FROM dbo.RESERVA_SERVICIO AS rs
        INNER JOIN dbo.SERVICIO AS s
            ON s.ID_servicio = rs.ID_servicio
        WHERE rs.ID_detalle = @ID_detalle;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        THROW;
    END CATCH;
END;
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
        monto_pago,
        fecha_pago
    )
    VALUES
    (
        @id_factura,
        @metodo_pago,
        @monto_pago,
        GETDATE()
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