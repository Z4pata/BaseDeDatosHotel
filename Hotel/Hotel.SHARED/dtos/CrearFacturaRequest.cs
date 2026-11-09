namespace Hotel.SHARED.dtos
{
    public class CrearFacturaRequest
    {
        public int IdReserva { get; set; }
        public DateTime FechaFactura { get; set; }
        public decimal TotalFactura { get; set; }
        public string Estado { get; set; }
    }
}
