using Hotel.SHARED.Entities;
using Hotel.SHARED.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
        [ApiController]
        [Route("api/reservas")]
        public class ReservasControllers : ControllerBase
        {
            private readonly string connectionString = "Server=localhost;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

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

            [HttpGet("detalle")]
            public async Task<IActionResult> ObtenerReservasDetalle()
            {
                var reservas = new List<ReservasDetalleView>();
                await using var connection = new SqlConnection(connectionString);
                await using var command = new SqlCommand(
                    "SELECT * FROM dbo.vw_reservas_detalle ORDER BY ID_reserva",
                    connection)
                {
                    CommandType = CommandType.Text
                };

                await connection.OpenAsync();
                await using var reader = await command.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    reservas.Add(new ReservasDetalleView
                    {
                        IdReserva = Convert.ToInt32(reader["ID_reserva"]),
                        IdHuesped = Convert.ToInt32(reader["ID_huesped"]),
                        Huesped = Convert.ToString(reader["huesped"]),
                        Fecha_Reserva = Convert.ToDateTime(reader["fecha_reserva"]),
                        Fecha_Entrada = Convert.ToDateTime(reader["fecha_entrada"]),
                        Fecha_Salida = Convert.ToDateTime(reader["fecha_salida"]),
                        Noches = Convert.ToInt32(reader["noches"]),
                        CantidadAdultos = Convert.ToInt32(reader["cantidad_adultos"]),
                        CantidadMenores = Convert.ToInt32(reader["cantidad_menores"]),
                        TotalHuespedes = Convert.ToInt32(reader["total_huespedes"]),
                        HabitacionesReservadas = Convert.ToInt32(reader["habitaciones_reservadas"])
                    });
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
