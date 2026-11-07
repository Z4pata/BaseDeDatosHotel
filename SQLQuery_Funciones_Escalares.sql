USE Hotel;
GO


/*CREATE OR ALTER FUNCTION fn_CalcularNoches  
(  
    @FechaEntrada DATE,  
    @FechaSalida DATE  
)  
RETURNS INT  
AS  
BEGIN  
    RETURN DATEDIFF(DAY, @FechaEntrada, @FechaSalida)  
END  
  
CREATE OR ALTER FUNCTION fn_TotalReserva  
(  
    @PrecioNoche DECIMAL(10,2),  
    @Noches INT  
)  
RETURNS DECIMAL(10,2)  
AS  
BEGIN  
    RETURN @PrecioNoche * @Noches  
END
  
CREATE OR ALTER FUNCTION fn_HuespedFrecuente(  
    @Id_Huesped INT  
)  
RETURNS BIT  
AS  
BEGIN  
    DECLARE @NumeroReservas INT;  
  
    SELECT @NumeroReservas = COUNT(ID_huesped)    
    FROM RESERVA   
    WHERE ID_huesped = @Id_Huesped;  
  
    IF(@NumeroReservas >= 5)  
        RETURN 1;  
    RETURN 0;  
END 
  
CREATE OR ALTER FUNCTION dbo.fn_DisponibilidadHabitacion(  
    @Id_Habitacion INT,  
    @Id_Sede INT  
)  
RETURNS BIT  
AS  
BEGIN  
    DECLARE @Estado_Habitacion VARCHAR(50);  
  
    SELECT @Estado_Habitacion = estado  
    FROM HABITACION  
    WHERE @Id_Habitacion = ID_habitacion AND @Id_Sede = ID_sede;  
  
    IF(@Estado_Habitacion = 'Disponible')  
        RETURN 1;  
    RETURN 0;  
END  

CREATE OR ALTER FUNCTION dbo.fn_TotalServicios
(
    @Id_Reserva INT
)
RETURNS DECIMAL
AS
BEGIN
    
    DECLARE @TotalServicios Decimal;

    SELECT @TotalServicios = ISNULL(SUM(cantidad_servicio*subtotal),0)
    FROM RESERVA_SERVICIO
    WHERE ID_reserva = @Id_Reserva

    RETURN @TotalServicios
    
END*/

CREATE OR ALTER FUNCTION dbo.fn_TotalHabitacionesReservadas
(
    @Id_Reserva INT
)
RETURNS DECIMAL
AS
BEGIN
    
    DECLARE @TotalHabitaciones Decimal;

    SELECT @TotalHabitaciones = COUNT(ID_reserva)
    FROM RESERVA_HABITACION
    WHERE ID_reserva = @Id_Reserva

    RETURN @TotalHabitaciones
    
END