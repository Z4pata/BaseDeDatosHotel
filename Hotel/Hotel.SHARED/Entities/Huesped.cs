using System;
using System.Collections.Generic;
using System.Text;

namespace Hotel.SHARED.Entities
{
    public class Huesped
    {
        public int Id { get; set; }
        public string NombreHuesped { get; set; }
        public string ApellidoHuesped { get; set; }
        public int Documento { get; set; }
        public string Correo { get; set; }
        public int Edad { get; set; }
    }
}
