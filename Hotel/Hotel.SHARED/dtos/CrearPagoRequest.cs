namespace Hotel.SHARED.dtos
{
    public class CrearPagoRequest
    {
        public int IdFactura { get; set; }
        public string MetodoPago { get; set; }
        public decimal MontoPago { get; set; }
    }
}
