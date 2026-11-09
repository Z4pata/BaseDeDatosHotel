namespace Hotel.SHARED.dtos
{
    public class ContratarServicioRequest
    {
        public int IdReserva { get; set; }
        public int IdServicio { get; set; }
        public int CantidadServicio { get; set; } = 1;
    }
}
