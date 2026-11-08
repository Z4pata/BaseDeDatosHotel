USE Hotel;
GO

-- VISTA INDEXADA 2: vw_recaudo_por_metodo_pago
-- Elimina la vista anterior
IF OBJECT_ID('dbo.vw_recaudo_por_metodo_pago', 'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.vw_recaudo_por_metodo_pago;
END;
GO

-- Configura opciones para crear la vista indexada
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
GO

-- Crea la vista con SCHEMABINDING 
CREATE VIEW dbo.vw_recaudo_por_metodo_pago
WITH SCHEMABINDING AS
SELECT
    p.metodo_pago,
    SUM(p.monto_pago) AS total_recaudado,
    COUNT_BIG(*) AS num_pagos

-- Tabla de pagos
FROM dbo.PAGO AS p
GROUP BY
    p.metodo_pago;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_recaudo_por_metodo_pago
ON dbo.vw_recaudo_por_metodo_pago (metodo_pago);
GO

-- Consulta el total
SELECT * FROM dbo.vw_recaudo_por_metodo_pago WITH (NOEXPAND)
ORDER BY total_recaudado DESC;
GO