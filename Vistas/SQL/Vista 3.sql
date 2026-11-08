USE Hotel;
GO

-- VISTA 3: vw_facturacion_resumen
-- Elimina la vista anterior
DROP VIEW IF EXISTS dbo.vw_facturacion_resumen;
GO

-- Crea la vista 
CREATE VIEW dbo.vw_facturacion_resumen AS
SELECT
    f.ID_factura,
    f.ID_reserva,

    CONCAT(h.nombre_huesped, ' ', h.apellido_huesped) AS huesped,
    f.fecha_factura,
    f.total_factura,

    ISNULL(p.total_pagado, 0) AS total_pagado,

    ISNULL(p.num_pagos, 0) AS num_pagos,
    f.total_factura - ISNULL(p.total_pagado, 0)
        AS saldo_pendiente,

    CASE
        WHEN f.total_factura - ISNULL(p.total_pagado, 0) <= 0
            THEN 'Pagada'
        ELSE 'Con saldo'
    END AS situacion_pago

-- Tabla principal
FROM dbo.FACTURA AS f
INNER JOIN dbo.RESERVA AS r
    ON r.ID_reserva = f.ID_reserva
INNER JOIN dbo.HUESPED AS h
    ON h.ID_huesped = r.ID_huesped
LEFT JOIN (
    SELECT
        ID_factura,
        SUM(monto_pago) AS total_pagado,
        COUNT(*) AS num_pagos
    FROM dbo.PAGO
    GROUP BY ID_factura
) AS p
    ON p.ID_factura = f.ID_factura;
GO

-- Consultar los registros de la vista 3
SELECT *
FROM dbo.vw_facturacion_resumen
ORDER BY ID_factura;
GO