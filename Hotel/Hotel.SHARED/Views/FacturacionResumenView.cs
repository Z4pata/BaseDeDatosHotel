namespace Hotel.SHARED.Views
{
    public class FacturacionResumenView
    {
        public int IdFactura { get; set; }
        public int IdReserva { get; set; }
        public string Huesped { get; set; }
        public DateTime FechaFactura { get; set; }
        public decimal TotalFactura { get; set; }
        public decimal TotalPagado { get; set; }
        public int NumPagos { get; set; }
        public decimal SaldoPendiente { get; set; }
        public string SituacionPago { get; set; }
    }
}
