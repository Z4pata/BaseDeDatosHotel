USE Hotel;
GO

-- VISTA INDEXADA 1: vw_ingresos_por_servicio
-- Elimina la vista existente
IF OBJECT_ID('dbo.vw_ingresos_por_servicio', 'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_ingresos_por_servicio;
END;
GO

-- Configuracion de opciones para la creaciones de las indexadas
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
GO

-- Crea la vista usando SCHEMABINDING.
CREATE VIEW dbo.vw_ingresos_por_servicio
WITH SCHEMABINDING AS
SELECT
    s.ID_servicio,
    s.tipo_servicio,

    SUM(rs.cantidad_servicio) AS total_unidades,

    SUM(rs.subtotal) AS ingresos_totales,

    COUNT_BIG(*) AS num_contrataciones

-- Tabla qde servicios
FROM dbo.SERVICIO AS s
INNER JOIN dbo.RESERVA_SERVICIO AS rs
    ON rs.ID_servicio = s.ID_servicio
GROUP BY
    s.ID_servicio,
    s.tipo_servicio;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_ingresos_por_servicio
ON dbo.vw_ingresos_por_servicio (ID_servicio);
GO

-- Consulta los ingresos del servicio
SELECT * FROM dbo.vw_ingresos_por_servicio WITH (NOEXPAND)
ORDER BY ingresos_totales DESC;
GO