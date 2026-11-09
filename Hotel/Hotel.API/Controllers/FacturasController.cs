using Hotel.SHARED.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/facturas")]
    public class FacturasController: ControllerBase
    {
        private readonly string connectionString = "Server=localhost;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

        [HttpGet("resumen")]
        public async Task<IActionResult> ObtenerFacturacionResumen()
        {
            var facturas = new List<FacturacionResumenView>();

            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand(
                "SELECT ID_factura, ID_reserva, huesped, fecha_factura, total_factura, " +
                "total_pagado, num_pagos, saldo_pendiente, situacion_pago " +
                "FROM dbo.vw_facturacion_resumen ORDER BY ID_factura",
                connection)
            {
                CommandType = CommandType.Text
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                facturas.Add(new FacturacionResumenView
                {
                    IdFactura = Convert.ToInt32(reader["ID_factura"]),
                    IdReserva = Convert.ToInt32(reader["ID_reserva"]),
                    Huesped = Convert.ToString(reader["huesped"]),
                    FechaFactura = Convert.ToDateTime(reader["fecha_factura"]),
                    TotalFactura = Convert.ToDecimal(reader["total_factura"]),
                    TotalPagado = Convert.ToDecimal(reader["total_pagado"]),
                    NumPagos = Convert.ToInt32(reader["num_pagos"]),
                    SaldoPendiente = Convert.ToDecimal(reader["saldo_pendiente"]),
                    SituacionPago = Convert.ToString(reader["situacion_pago"])
                });
            }

            return Ok(facturas);
        }
    }
}
