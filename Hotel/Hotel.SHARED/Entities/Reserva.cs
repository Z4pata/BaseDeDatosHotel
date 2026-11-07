using System;
using System.Collections.Generic;
using System.Text;

namespace Hotel.SHARED.Entities
{
    public class Reserva
    {
        public int IdReserva { get; set; }
        public DateTime Fecha_Reserva { get; set; } = DateTime.Now;
        public DateTime Fecha_Entrada { get; set; }
        public DateTime Fecha_Salida { get; set; }
        public int CantidadAdultos { get; set; }
        public int CantidadMenores { get; set; }
    }
}
