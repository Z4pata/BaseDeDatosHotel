using Hotel.SHARED.dtos;
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

        [HttpPost]
        public async Task<IActionResult> RegistrarPago(CrearPagoRequest request)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Pago_Insertar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@id_factura", request.IdFactura);
            command.Parameters.AddWithValue("@metodo_pago", request.MetodoPago);
            command.Parameters.AddWithValue("@monto_pago", request.MontoPago);

            await connection.OpenAsync();
            await command.ExecuteNonQueryAsync();

            return StatusCode(StatusCodes.Status201Created, request);
        }

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