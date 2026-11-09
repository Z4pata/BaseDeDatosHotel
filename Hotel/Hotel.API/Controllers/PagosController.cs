using Hotel.SHARED.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/pagos")]
    public class PagosController : ControllerBase
    {
        private readonly string connectionString = "Server=localhost;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

        [HttpGet("recaudo")]
        public async Task<IActionResult> ObtenerRecaudoPorMetodoPago()
        {
            var recaudos = new List<RecaudoPorMetodoPagoView>();

            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand(
                "SELECT metodo_pago, total_recaudado, num_pagos " +
                "FROM dbo.vw_recaudo_por_metodo_pago WITH (NOEXPAND) " +
                "ORDER BY total_recaudado DESC",
                connection)
            {
                CommandType = CommandType.Text
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                recaudos.Add(new RecaudoPorMetodoPagoView
                {
                    MetodoPago = Convert.ToString(reader["metodo_pago"]),
                    TotalRecaudado = Convert.ToDecimal(reader["total_recaudado"]),
                    NumPagos = Convert.ToInt64(reader["num_pagos"])
                });
            }

            return Ok(recaudos);
        }
    }
}