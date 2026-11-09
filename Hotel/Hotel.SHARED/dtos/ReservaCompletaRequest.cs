namespace Hotel.SHARED.dtos
{
    public class ReservaCompletaRequest
    {
        public int IdHuesped { get; set; }
        public DateTime FechaReserva { get; set; } = DateTime.Now;
        public DateTime FechaEntrada { get; set; }
        public DateTime FechaSalida { get; set; }
        public int CantidadAdultos { get; set; }
        public int CantidadMenores { get; set; }
        public int IdHabitacion { get; set; }
    }
}
