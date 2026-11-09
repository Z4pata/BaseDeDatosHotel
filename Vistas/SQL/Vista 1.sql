USE Hotel;
GO

SELECT
    DB_NAME() AS base_de_datos_actual;
GO

GO
-- VISTA 1: vw_reservas_detalle
-- Elimina la vista anterior 
DROP VIEW IF EXISTS dbo.vw_reservas_detalle;
GO

-- Crear la vista
CREATE VIEW dbo.vw_reservas_detalle
AS
SELECT
    r.ID_reserva,
    h.ID_huesped,

    CONCAT(h.nombre_huesped, ' ', h.apellido_huesped) AS huesped,
    r.fecha_reserva,
    r.fecha_entrada,
    r.fecha_salida,

    DATEDIFF(DAY, r.fecha_entrada, r.fecha_salida) AS noches,
    r.cantidad_adultos,

    ISNULL(r.cantidad_menores, 0) AS cantidad_menores,
    r.cantidad_adultos + ISNULL(r.cantidad_menores, 0) AS total_huespedes,

    COUNT(rh.ID_habitacion) AS habitaciones_reservadas

-- Tabla principal
FROM dbo.RESERVA AS r
INNER JOIN dbo.HUESPED AS h
    ON h.ID_huesped = r.ID_huesped
LEFT JOIN dbo.RESERVA_HABITACION AS rh
    ON rh.ID_reserva = r.ID_reserva

GROUP BY
    r.ID_reserva,
    h.ID_huesped,
    h.nombre_huesped,
    h.apellido_huesped,
    r.fecha_reserva,
    r.fecha_entrada,
    r.fecha_salida,
    r.cantidad_adultos,
    r.cantidad_menores;
GO

-- Consultar todos los registros de la vista 1
SELECT * FROM dbo.vw_reservas_detalle
ORDER BY ID_reserva;
GO