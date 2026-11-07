using System;
using System.Collections.Generic;
using System.Text;

namespace Hotel.SHARED.Entities
{
    public class Factura
    {
        public int Id { get; set; }
        public int IdReserva { get; set; }
        public DateTime Fecha_Factura { get; set; } = DateTime.Now;
        public decimal Total { get; set; }
        public string estado { get; set; }

    }
}
