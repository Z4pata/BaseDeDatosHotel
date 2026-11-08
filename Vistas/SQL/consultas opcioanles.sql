USE Hotel;
GO
--------CONSULTAS DE VERIFICACION-------

-- VERIFICAR LOS INDICES DE LAS VISTAS INDEXADAS
SELECT
    OBJECT_NAME(object_id) AS nombre_vista,
    name AS nombre_indice,
    type_desc AS tipo_indice,
    is_unique AS indice_unico

FROM sys.indexes
WHERE object_id IN (
    OBJECT_ID('dbo.vw_ingresos_por_servicio'),
    OBJECT_ID('dbo.vw_recaudo_por_metodo_pago')
)

-- Ordena los resultados
ORDER BY nombre_vista;
GO


GO
-- Consulta los ingresos actuales del bar
SELECT * FROM dbo.vw_ingresos_por_servicio WITH (NOEXPAND)
WHERE ID_servicio = 2;
GO


GO

-- Comprobar si existe una relacion entre la reserva 2 y el servicio 2
SELECT * FROM dbo.RESERVA_SERVICIO
WHERE ID_reserva = 2
  AND ID_servicio = 2;
GO


GO

-- Buscar reserva sin asociacion al servicio de bar
SELECT
    r.ID_reserva
FROM dbo.RESERVA AS r
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.RESERVA_SERVICIO AS rs
    WHERE rs.ID_reserva = r.ID_reserva
      AND rs.ID_servicio = 2
)
ORDER BY r.ID_reserva;
GO




GO
BEGIN TRANSACTION;

-- Consulta los valores originales del servicio del bar
SELECT 'ANTES' AS momento, * FROM dbo.vw_ingresos_por_servicio WITH (NOEXPAND)
WHERE ID_servicio = 2;

INSERT INTO dbo.RESERVA_SERVICIO
    (ID_reserva, ID_servicio, cantidad_servicio, subtotal)
VALUES
    (1, 2, 3, 135000);

SELECT 'DESPUES' AS momento, * FROM dbo.vw_ingresos_por_servicio WITH (NOEXPAND)
WHERE ID_servicio = 2;

ROLLBACK TRANSACTION;
GO


-- Prueba de valores originales
SELECT * FROM dbo.vw_ingresos_por_servicio WITH (NOEXPAND)
WHERE ID_servicio = 2;
GO