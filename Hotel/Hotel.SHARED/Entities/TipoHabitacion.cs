using System;
using System.Collections.Generic;
using System.Text;

namespace Hotel.SHARED.Entities
{
    public class TipoHabitacion
    {
        public int Id { get; set; }
        public string Nombre_Tipo { get; set; }
        public decimal Precio { get; set; }
        public int capacidad { get; set; }
    }
}
