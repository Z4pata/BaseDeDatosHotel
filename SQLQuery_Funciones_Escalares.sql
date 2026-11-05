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
  
CREATE OR ALTER FUNCTION ClienteFrecuente(  
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
  
CREATE OR ALTER FUNCTION DisponibilidadHabitacion(  
    @Id_Habitación INT,  
    @Id_Sede INT  
)  
RETURNS BIT  
AS  
BEGIN  
    DECLARE @Estado_Habitación VARCHAR(50);  
  
    SELECT @Estado_Habitación = estado  
    FROM HABITACION  
    WHERE @Id_Habitación = ID_habitacion AND @Id_Sede = ID_sede;  
  
    IF(@Estado_Habitación = 'Disponible')  
        RETURN 1;  
    RETURN 0;  
END*/  