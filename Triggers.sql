USE Hotel;

-- 1. Tabla de seguridad para registrar la firma de integridad 
CREATE TABLE PAGO_FIRMADO ( 
	ID_pago INT PRIMARY KEY, 
	hash_integridad VARBINARY(64) NOT NULL, 
	fecha_firma DATETIME DEFAULT GETDATE(), 
	CONSTRAINT FK_pago_firmado FOREIGN KEY (ID_pago) REFERENCES PAGO(ID_pago) 
); 
GO 

-- 2. Trigger que genera el hash automático al registrar un pago 
CREATE TRIGGER trg_FirmarPagoIntegridad 
ON PAGO 
AFTER INSERT 
AS 
BEGIN  
	INSERT INTO PAGO_FIRMADO (ID_pago, hash_integridad) 
		SELECT i.ID_pago, 
		-- Hasheo SHA2_512 que combina el ID, monto, método y una clave secreta 
		HASHBYTES(
			'SHA2_512', CONCAT(i.ID_pago, '|', i.monto_pago, '|', i.metodo_pago, '|KeyHotelSeguro2026') 
		) 
	FROM inserted i; 
END; 
GO

-- 3. Trigger para proteger una factura que ya fue pagada
CREATE TRIGGER trg_ProtegerFacturasPagadas 
ON FACTURA 
INSTEAD OF DELETE 
AS 
BEGIN 
	SET NOCOUNT ON; 
	IF EXISTS (SELECT 1 FROM deleted WHERE estado = 'PAGADA') 
	BEGIN 
		RAISERROR('Seguridad: No se permite eliminar facturas que ya han sido pagadas.', 16, 1); 
		ROLLBACK TRANSACTION; 
		RETURN; 
	END 
	-- Permitir eliminación si la factura no está pagada 
	DELETE FROM FACTURA 
	WHERE ID_factura IN (SELECT ID_factura FROM deleted);
END; 
GO

-- 4. Tabla de auditoria para verificar cambios o inserciones en RESERVA_SERVICIO
CREATE TABLE AUDITORIA_RESERVA_SERVICIO ( 
	ID_auditoria INT IDENTITY(1,1) PRIMARY KEY, 
	ID_detalle INT NOT NULL, 
	ID_reserva INT NOT NULL, 
	ID_servicio INT NOT NULL, 
	accion VARCHAR(10) NOT NULL, -- 'INSERT' o 'UPDATE' 
	usuario_bd VARCHAR(100) NOT NULL, 
	fecha_evento DATETIME DEFAULT GETDATE(), 
	cantidad_anterior INT NULL, 
	cantidad_nueva INT NULL, 
	subtotal_anterior DECIMAL NULL, 
	subtotal_nuevo DECIMAL NULL
); 
GO

-- 5. Trigger para la tabla de auditoria de RESERVA_SERVICIO
CREATE TRIGGER trg_AuditoriaReservaServicio 
ON RESERVA_SERVICIO 
AFTER INSERT, UPDATE 
AS 
BEGIN 
	-- Caso 1: INSERCIÓN (Existe en 'inserted' pero NO en 'deleted') 
	IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted) 
	BEGIN 
		INSERT INTO AUDITORIA_RESERVA_SERVICIO ( 
			ID_detalle, 
			ID_reserva, 
			ID_servicio, 
			accion, 
			usuario_bd, 
			cantidad_anterior, 
			cantidad_nueva, 
			subtotal_anterior, 
			subtotal_nuevo 
		) 
		SELECT i.ID_detalle, i.ID_reserva, i.ID_servicio, 'INSERT', SUSER_SNAME(), NULL, i.cantidad_servicio, NULL, i.subtotal 
		FROM inserted i; 
	END 
	-- Caso 2: ACTUALIZACIÓN (Existe en 'inserted' Y en 'deleted') 
	IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted) 
	BEGIN 
		INSERT INTO AUDITORIA_RESERVA_SERVICIO ( 
			ID_detalle, 
			ID_reserva, 
			ID_servicio, 
			accion, 
			usuario_bd, 
			cantidad_anterior, 
			cantidad_nueva, 
			subtotal_anterior, 
			subtotal_nuevo 
		) 
		SELECT i.ID_detalle, i.ID_reserva, i.ID_servicio, 'UPDATE', SUSER_SNAME(), d.cantidad_servicio, i.cantidad_servicio, d.subtotal, i.subtotal 
		FROM deleted d 
		INNER JOIN inserted i ON d.ID_detalle = i.ID_detalle; 
	END 
END; 
GO

-- 6. Actualiza una factura cuando se contrata un servicio
CREATE OR ALTER TRIGGER trg_ActualizarFacturaPorServicio
ON RESERVA_SERVICIO
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar que exista una factura para cada reserva afectada
    IF EXISTS
    (
        SELECT 1
        FROM
        (
            SELECT DISTINCT ID_reserva
            FROM inserted
        ) AS reservas
        LEFT JOIN dbo.FACTURA AS f
            ON f.ID_reserva = reservas.ID_reserva
        WHERE f.ID_factura IS NULL
    )
    BEGIN
        THROW 51002,
            'No existe una factura asociada a una de las reservas.',
            1;
    END;

    -- Agrupar por reserva para soportar varios servicios
    -- insertados en la misma operación
    ;WITH TotalesServicios AS
    (
        SELECT
            ID_reserva,
            SUM(subtotal) AS total_servicios
        FROM inserted
        GROUP BY ID_reserva
    )
    UPDATE f
    SET f.total_factura =
        f.total_factura + ts.total_servicios
    FROM dbo.FACTURA AS f
    INNER JOIN TotalesServicios AS ts
        ON ts.ID_reserva = f.ID_reserva;
END;
GO

-- 7. Actualiza el estado de una habitacion al hacer una reserva
CREATE TRIGGER trg_MarcarHabitacionOcupada 
ON RESERVA_HABITACION 
AFTER INSERT 
AS 
BEGIN 
	-- Actualiza el estado de la habitación asignada a 'Ocupada' 
	UPDATE HABITACION SET estado = 'Ocupada' 
		WHERE ID_habitacion IN ( SELECT ID_habitacion FROM inserted ); 
END; 
GO

-- 8. Generar factura al reservar una habitacion
CREATE OR ALTER TRIGGER trg_GenerarFacturaReservaHabitacion
ON RESERVA_HABITACION
AFTER INSERT
AS
BEGIN
    DECLARE @ReservasAfectadas TABLE
    (
        ID_reserva INT PRIMARY KEY
    );

    INSERT INTO @ReservasAfectadas (ID_reserva)
    SELECT DISTINCT ID_reserva
    FROM inserted;

    -- Validar que existan fechas válidas para calcular las noches
    IF EXISTS
    (
        SELECT 1
        FROM @ReservasAfectadas ra
        INNER JOIN dbo.RESERVA r
            ON r.ID_reserva = ra.ID_reserva
        WHERE r.fecha_entrada IS NULL
           OR r.fecha_salida IS NULL
           OR r.fecha_salida <= r.fecha_entrada
    )
    BEGIN
        THROW 51001,
            'No se puede generar la factura porque la reserva no tiene fechas válidas.',
            1;
    END;

    DECLARE @TotalesPorReserva TABLE
    (
        ID_reserva INT PRIMARY KEY,
        total_factura DECIMAL(18, 2)
    );

    -- Recalcular el total de cada reserva afectada
    INSERT INTO @TotalesPorReserva
    (
        ID_reserva,
        total_factura
    )
    SELECT
        ra.ID_reserva,
        SUM(
            CAST(t.precio_habitacion AS DECIMAL(18, 2))
            * DATEDIFF(DAY, r.fecha_entrada, r.fecha_salida)
        ) AS total_factura
    FROM @ReservasAfectadas ra
    INNER JOIN dbo.RESERVA r
        ON r.ID_reserva = ra.ID_reserva
    INNER JOIN dbo.RESERVA_HABITACION rh
        ON rh.ID_reserva = r.ID_reserva
    INNER JOIN dbo.HABITACION h
        ON h.ID_habitacion = rh.ID_habitacion
    INNER JOIN dbo.TIPO_HABITACION t
        ON t.ID_tipo_habitacion = h.ID_tipo_habitacion
    GROUP BY
        ra.ID_reserva;

    -- Si ya existe una factura, actualizar su total
    UPDATE f
    SET f.total_factura = t.total_factura
    FROM dbo.FACTURA f
    INNER JOIN @TotalesPorReserva t
        ON t.ID_reserva = f.ID_reserva;

    -- Si no existe una factura, crearla
    INSERT INTO dbo.FACTURA
    (
        ID_reserva,
        fecha_factura,
        total_factura,
        estado
    )
    SELECT
        t.ID_reserva,
        GETDATE(),
        t.total_factura,
        'PENDIENTE'
    FROM @TotalesPorReserva t
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM dbo.FACTURA f
        WHERE f.ID_reserva = t.ID_reserva
    );
END;
GO

-- 9. Actualiza el estado de una habitacion al terminar la reserva
CREATE TRIGGER trg_LiberarHabitacion 
ON RESERVA_HABITACION 
AFTER DELETE 
AS 
BEGIN 
	SET NOCOUNT ON; 
	-- Devuelve el estado de la habitación a 'Disponible' 
	UPDATE HABITACION SET estado = 'Disponible' 
		WHERE ID_habitacion IN ( SELECT ID_habitacion FROM deleted ); 
END; 
GO