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

-- 6. Actualiza el estado de una habitacion al hacer una reserva
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

-- 7. Actualiza el estado de una habitacion al terminar la reserva
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