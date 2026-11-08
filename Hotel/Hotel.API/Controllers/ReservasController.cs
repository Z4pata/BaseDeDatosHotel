using Hotel.SHARED.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
        [ApiController]
        [Route("api/reservas")]
        public class ReservasControllers : ControllerBase
        {
            private readonly string connectionString = "Server=ANDRESAYALA18;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

            [HttpPost]
            public async Task<IActionResult> CrearReserva(Reserva reserva)
            {
                await using var connection = new SqlConnection(connectionString);
                await using var command = new SqlCommand("sp_Reserva_Insertar", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@fecha_entrada", reserva.Fecha_Entrada);
                command.Parameters.AddWithValue("@fecha_salida", reserva.Fecha_Salida);
                command.Parameters.AddWithValue("@cantidad_adultos", reserva.CantidadAdultos);
                command.Parameters.AddWithValue("@cantidad_menores", reserva.CantidadMenores);

                await connection.OpenAsync();
                await command.ExecuteNonQueryAsync();

                return StatusCode(StatusCodes.Status201Created, reserva);
            }

            [HttpGet]
            public async Task<IActionResult> ObtenerReservas()
            {
                var reservas = new List<Reserva>();
                await using var connection = new SqlConnection(connectionString);
                await using var command = new SqlCommand("sp_Reserva_Consultar", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                await connection.OpenAsync();
                await using var reader = await command.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    var reserva = new Reserva
                    {
                        IdReserva = Convert.ToInt32(reader["id_reserva"]),
                        Fecha_Reserva = Convert.ToDateTime(reader["fecha_reserva"]),
                        Fecha_Entrada = Convert.ToDateTime(reader["fecha_entrada"]),
                        Fecha_Salida = Convert.ToDateTime(reader["fecha_salida"]),
                        CantidadAdultos = Convert.ToInt32(reader["cantidad_adultos"]),
                        CantidadMenores = Convert.ToInt32(reader["cantidad_menores"])
                    };
                    reservas.Add(reserva);
                }
                return Ok(reservas);
            }

            [HttpGet("{Id}")]

            public async Task<IActionResult> ObtenerReservasId(int Id)
            {
                await using var connection = new SqlConnection(connectionString);
                await using var command = new SqlCommand("sp_Reserva_ConsultarId", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@Id_reserva", Id);

                await connection.OpenAsync();
                await using var reader = await command.ExecuteReaderAsync();
                if (!await reader.ReadAsync())
                    return NotFound();

                var reserva = new Reserva
                {
                    IdReserva = Convert.ToInt32(reader["id_reserva"]),
                    Fecha_Reserva = Convert.ToDateTime(reader["fecha_reserva"]),
                    Fecha_Entrada = Convert.ToDateTime(reader["fecha_entrada"]),
                    Fecha_Salida = Convert.ToDateTime(reader["fecha_salida"]),
                    CantidadAdultos = Convert.ToInt32(reader["cantidad_adultos"]),
                    CantidadMenores = Convert.ToInt32(reader["cantidad_menores"])
                };

                return Ok(reserva);

            }

            [HttpPut("{Id}")]

            public async Task<IActionResult> ActualizarReserva(int id, Reserva reserva)
            {
                await using var connection =
                new SqlConnection(connectionString);

                await using var command =
                new SqlCommand(
                "sp_Reserva_Actualizar",
                connection);

                command.CommandType =
                CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@fecha_entrada", reserva.Fecha_Entrada);

                command.Parameters.AddWithValue("@fecha_salida", reserva.Fecha_Salida);

                command.Parameters.AddWithValue("@cantidad_adultos", reserva.CantidadAdultos);

                command.Parameters.AddWithValue("@cantidad_menores", reserva.CantidadMenores);

                await connection.OpenAsync();

                int filasAfectadas =
                await command.ExecuteNonQueryAsync();

                if (filasAfectadas == 0)
                    return NotFound("No se encontró la reserva.");

                return Ok("Reserva actualizada correctamente.");
            }

            [HttpDelete("{Id}")]

            public async Task<IActionResult> EliminarReserva(int Id)
            {
                await using var connection = new SqlConnection(connectionString);
                await using var command = new SqlCommand("sp_Reserva_Eliminar", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.AddWithValue("@Id_reserva", Id);

                await connection.OpenAsync();

                command.ExecuteNonQuery();

                return Ok();

            }
        }
}
