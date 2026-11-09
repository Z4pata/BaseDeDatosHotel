namespace Hotel.SHARED.Views
{
    public class ReservasDetalleView
    {
        public int IdReserva { get; set; }
        public int IdHuesped { get; set; }
        public string Huesped { get; set; }
        public DateTime Fecha_Reserva { get; set; }
        public DateTime Fecha_Entrada { get; set; }
        public DateTime Fecha_Salida { get; set; }
        public int Noches { get; set; }
        public int CantidadAdultos { get; set; }
        public int CantidadMenores { get; set; }
        public int TotalHuespedes { get; set; }
        public int HabitacionesReservadas { get; set; }
    }
}
