USE Hotel;
GO

-- ==========================================
-- 1. OPERACIONES CRUD
-- ==========================================

-- CREATE: Insertar un huesped

INSERT INTO HUESPED
(nombre_huesped, apellido_huesped, documento, correo, edad)
VALUES
('Pedro', 'Gomez', 1002456810, 'pedro@gmail.com', 25);
GO

-- READ: Consultar todos los huespedes

SELECT *
FROM HUESPED;
GO

-- UPDATE: Actualizar el correo de un huesped

UPDATE HUESPED
SET correo = 'pedro.nuevo@gmail.com'
WHERE documento = 1002456810;
GO

-- DELETE: Eliminar un huesped especifico

DELETE FROM HUESPED
WHERE documento = 1002456810;
GO


-- ==========================================
-- 2. MANIPULACION DE DATOS
-- DELETE VS TRUNCATE
-- ==========================================

-- DELETE: Elimina un registro especifico

DELETE FROM HUESPED
WHERE ID_huesped = 5;
GO

-- DELETE: Permite eliminar todos los registros.
-- IMPORTANTE: No ejecutar en la base de datos real.
-- DELETE FROM HUESPED;
-- GO

-- TRUNCATE: Elimina todos los registros
-- y reinicia el contador IDENTITY.
-- IMPORTANTE: No ejecutar en la base de datos real.
-- TRUNCATE TABLE HUESPED;
-- GO


-- ==========================================
-- 3. OPERADORES ESPECIALES: ANY Y ALL
-- ==========================================

-- ANY: Compara el precio con al menos
-- uno de los precios de la subconsulta.

SELECT nombre_tipo, precio_habitacion
FROM TIPO_HABITACION
WHERE precio_habitacion > ANY
(
    SELECT precio_habitacion
    FROM TIPO_HABITACION
    WHERE capacidad = 1
);
GO

-- ALL: Compara el precio con todos
-- los precios de la subconsulta.

SELECT nombre_tipo, precio_habitacion
FROM TIPO_HABITACION
WHERE precio_habitacion > ALL
(
    SELECT precio_habitacion
    FROM TIPO_HABITACION
    WHERE capacidad = 1
);
GO


-- ==========================================
-- 4. OPERADOR LIKE Y COMODINES
-- ==========================================

-- %: Nombres que comienzan por C

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE 'C%';
GO

-- %: Nombres que terminan en A

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE '%a';
GO

-- %: Nombres que contienen AR

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE '%ar%';
GO

-- _: Representa exactamente un caracter

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE 'C____';
GO

-- [ ]: Nombres que comienzan por C o M

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE '[CM]%';
GO

-- [ ]: Nombres que comienzan entre A y F

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE '[A-F]%';
GO

-- [^]: Excluye nombres que comienzan por C o M

SELECT *
FROM HUESPED
WHERE nombre_huesped LIKE '[^CM]%';
GO