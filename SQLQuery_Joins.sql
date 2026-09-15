USE Hotel
GO

--π_{nombre_huesped, apellido_huesped, fecha_entrada, fecha_salida}( σ_{h.ID_huesped = r.ID_huesped}(HUESPED × RESERVA) )

SELECT nombre_huesped,h.apellido_huesped,r.fecha_entrada,r.fecha_salida
FROM HUESPED h
INNER JOIN RESERVA r
ON r.ID_huesped = h.ID_huesped

-- π_{ID_reserva, ID_sede, numero_habitacion}( HABITACION ⟕_{h.ID_habitacion = rh.ID_habitacion} RESERVA_HABITACION )

SELECT rh.ID_reserva,h.ID_sede,h.numero_habitacion
FROM HABITACION h
LEFT JOIN RESERVA_HABITACION rh
ON rh.ID_habitacion = h.ID_habitacion

-- π_{nombre_tipo, numero_habitacion}( HABITACION ⟖_{h.ID_tipo_habitacion = tp.ID_tipo_habitacion} TIPO_HABITACION )

SELECT tp.nombre_tipo,h.numero_habitacion
FROM HABITACION h
RIGHT JOIN TIPO_HABITACION tp
ON h.ID_tipo_habitacion = tp.ID_tipo_habitacion

-- π_{ID_habitacion, numero_habitacion}( HABITACION ⟗_{h.ID_habitacion = rh.ID_habitacion} RESERVA_HABITACION )

SELECT rh.ID_habitacion, h.numero_habitacion
FROM HABITACION h
FULL JOIN RESERVA_HABITACION rh
ON h.ID_habitacion = rh.ID_habitacion

-- π_{nombre_huesped, apellido_huesped, tipo_servicio}(HUESPED × SERVICIO)

SELECT h.nombre_huesped,h.apellido_huesped, s.tipo_servicio
FROM HUESPED h
CROSS JOIN SERVICIO s