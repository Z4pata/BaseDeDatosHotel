using System;
using System.Collections.Generic;
using System.Text;

namespace Hotel.SHARED.Entities
{
    public class Habitacion
    {
        public int id { get; set; }
        public int id_sede { get; set; }
        public int id_tipo_habitacion { get; set; }
        public string numero_habitacion { get; set; }
        public string estado { get; set; }
    }
}
