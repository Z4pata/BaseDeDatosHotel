USE Hotel;
GO

-- Consulta 1: huéspedes por edad
SELECT
    edad,
    COUNT(*) AS cantidad_huespedes
FROM HUESPED
WHERE edad BETWEEN 18 AND 60
GROUP BY edad
HAVING COUNT(*) >= 1
ORDER BY edad ASC;
GO

-- Consulta 2: tipos de habitación con precio mayor a 100000
SELECT
    nombre_tipo,
    COUNT(*) AS cantidad_tipos,
    AVG(precio_habitacion) AS precio_promedio
FROM TIPO_HABITACION
WHERE precio_habitacion > 100000
GROUP BY nombre_tipo
HAVING COUNT(*) >= 1
ORDER BY precio_promedio DESC;
GO

-- Consulta 3: habitaciones según estado
SELECT
    estado,
    COUNT(*) AS total_habitaciones
FROM HABITACION
WHERE estado IN ('Disponible', 'Ocupada', 'Mantenimiento')
GROUP BY estado
HAVING COUNT(*) > 0
ORDER BY total_habitaciones DESC;
GO

-- Consulta 4: reservas por cantidad de adultos
SELECT
    cantidad_adultos,
    COUNT(*) AS total_reservas
FROM RESERVA
WHERE cantidad_adultos >= 1
GROUP BY cantidad_adultos
HAVING COUNT(*) >= 1
ORDER BY total_reservas DESC, cantidad_adultos ASC;
GO

-- Consulta 5: teléfonos por tipo de contacto
SELECT
    tipo_contacto,
    COUNT(*) AS total_telefonos
FROM TELEFONO_HUESPED
WHERE tipo_contacto IS NOT NULL
GROUP BY tipo_contacto
HAVING COUNT(*) >= 1
ORDER BY total_telefonos DESC, tipo_contacto ASC;
GO
