USE Hotel;
GO

-- VISTA 2: vw_habitaciones_sede

-- Eliminar la vista anterior
DROP VIEW IF EXISTS dbo.vw_habitaciones_sede;
GO

-- Creamos la vista 
CREATE VIEW dbo.vw_habitaciones_sede AS 
SELECT
    hb.ID_habitacion,
    hb.numero_habitacion,
    t.nombre_tipo,
    t.capacidad,
    t.precio_habitacion,
    s.ID_sede,
    s.nombre_sede,
    c.nombre_ciudad

-- Tabla principal
FROM dbo.HABITACION AS hb
INNER JOIN dbo.TIPO_HABITACION AS t
    ON t.ID_tipo_habitacion = hb.ID_tipo_habitacion
INNER JOIN dbo.SEDE AS s
    ON s.ID_sede = hb.ID_sede
INNER JOIN dbo.CIUDAD AS c
    ON c.ID_ciudad = s.ID_ciudad;
GO

-- Consultar los registros de la vista 2
SELECT *
FROM dbo.vw_habitaciones_sede
ORDER BY ID_habitacion;
GO