USE Hotel;
GO

/*CREATE OR ALTER FUNCTION ReservasPorHuesped
(
	@Id_Huesped INT
)
RETURNS TABLE
AS
Return SELECT ID_reserva, fecha_entrada, fecha_salida 
		FROM RESERVA
		WHERE ID_huesped = @Id_Huesped


CREATE OR ALTER FUNCTION ReservasAlMes
(
	@Mes INT,
	@Año INT
)
RETURNS TABLE
AS
RETURN  SELECT ID_reserva,ID_huesped, fecha_reserva, fecha_entrada, fecha_salida, cantidad_adultos+cantidad_menores AS Cantidad_Huespedes
		FROM RESERVA
		WHERE MONTH(fecha_reserva) = @Mes AND YEAR(fecha_reserva) = @Año


CREATE OR ALTER FUNCTION fn_FacturasPendientes()
RETURNS TABLE
AS
RETURN  SELECT f.ID_factura, h.nombre_huesped+' '+h.apellido_huesped AS Nombre_Completo, f.total_factura
		FROM FACTURA AS f
		INNER JOIN RESERVA AS r 
			ON f.ID_reserva = r.ID_reserva
		INNER JOIN HUESPED AS h
			ON r.ID_huesped = h.ID_huesped
		WHERE f.estado = 'Pendiente'
*/
