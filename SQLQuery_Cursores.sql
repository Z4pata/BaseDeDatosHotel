USE Hotel;
GO

CREATE OR ALTER PROCEDURE sp_ActualizarEstadoReservas
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdReserva INT;
    DECLARE @FechaSalida DATE;

    DECLARE curs_reservas CURSOR FOR
        SELECT ID_reserva, fecha_salida
        FROM RESERVA
        WHERE fecha_salida < GETDATE();

    OPEN curs_reservas;

    FETCH NEXT FROM curs_reservas
    INTO @IdReserva, @FechaSalida;

    WHILE @@FETCH_STATUS = 0
    BEGIN

        UPDATE HABITACION
        SET estado = 'Disponible'
        WHERE ID_habitacion IN
        (
            SELECT ID_habitacion
            FROM RESERVA_HABITACION
            WHERE ID_reserva = @IdReserva
        );


        FETCH NEXT FROM curs_reservas
        INTO @IdReserva, @FechaSalida;

    END

    CLOSE curs_reservas;
    DEALLOCATE curs_reservas;
END;
GO

CREATE OR ALTER PROCEDURE sp_ProgramarMantenimientoHabitaciones
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdHabitacion INT;
    DECLARE @CantidadReservas INT;

    DECLARE curs_habitaciones CURSOR FOR
        SELECT ID_habitacion
        FROM HABITACION;

    OPEN curs_habitaciones;

    FETCH NEXT FROM curs_habitaciones
    INTO @IdHabitacion;

    WHILE @@FETCH_STATUS = 0
    BEGIN

        SELECT @CantidadReservas = COUNT(*)
        FROM RESERVA_HABITACION
        WHERE ID_habitacion = @IdHabitacion;

        IF @CantidadReservas >= 50
        BEGIN
            UPDATE HABITACION
            SET estado = 'Mantenimiento'
            WHERE ID_habitacion = @IdHabitacion;
        END

        FETCH NEXT FROM curs_habitaciones
        INTO @IdHabitacion;
    END

    CLOSE curs_habitaciones;
    DEALLOCATE curs_habitaciones;
END;