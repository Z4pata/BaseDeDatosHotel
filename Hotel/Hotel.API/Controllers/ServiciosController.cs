using Hotel.SHARED.dtos;
using Hotel.SHARED.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/servicios")]
    public class ServiciosController : ControllerBase
    {
        private readonly string connectionString = "Server=localhost;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

        [HttpGet("ingresos")]
        public async Task<IActionResult> ObtenerIngresosPorServicio()
        {
            var ingresos = new List<IngresosPorServicioView>();

            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand(
                "SELECT ID_servicio, tipo_servicio, total_unidades, ingresos_totales, num_contrataciones " +
                "FROM dbo.vw_ingresos_por_servicio WITH (NOEXPAND) " +
                "ORDER BY ingresos_totales DESC",
                connection)
            {
                CommandType = CommandType.Text
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                ingresos.Add(new IngresosPorServicioView
                {
                    IdServicio = Convert.ToInt32(reader["ID_servicio"]),
                    TipoServicio = Convert.ToString(reader["tipo_servicio"]),
                    TotalUnidades = Convert.ToInt32(reader["total_unidades"]),
                    IngresosTotales = Convert.ToDecimal(reader["ingresos_totales"]),
                    NumContrataciones = Convert.ToInt64(reader["num_contrataciones"])
                });
            }

            return Ok(ingresos);
        }

        [HttpPost("contratar")]
        public async Task<IActionResult> ContratarServicio(ContratarServicioRequest request)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Reserva_Servicio_Insertar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@ID_reserva", request.IdReserva);
            command.Parameters.AddWithValue("@ID_servicio", request.IdServicio);
            command.Parameters.AddWithValue("@cantidad_servicio", request.CantidadServicio);

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();

            if (!await reader.ReadAsync())
                return BadRequest("No se pudo contratar el servicio.");

            var contratacion = new
            {
                IdDetalle = Convert.ToInt32(reader["ID_detalle"]),
                IdReserva = Convert.ToInt32(reader["ID_reserva"]),
                IdServicio = Convert.ToInt32(reader["ID_servicio"]),
                TipoServicio = Convert.ToString(reader["tipo_servicio"]),
                CantidadServicio = Convert.ToInt32(reader["cantidad_servicio"]),
                PrecioServicio = Convert.ToDecimal(reader["precio_servicio"]),
                Subtotal = Convert.ToDecimal(reader["subtotal"])
            };

            return StatusCode(StatusCodes.Status201Created, contratacion);
        }

    }
}
