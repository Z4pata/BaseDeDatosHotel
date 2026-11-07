using Hotel.SHARED.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/habitaciones")]
    public class HabitacionesController: ControllerBase
    {
        private readonly string connectionString = "Server=ANDRESAYALA18;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

        [HttpPost]
        public async Task<IActionResult> CrearHabitacion(Habitacion habitacion)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Habitacion_Insertar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@id_sede", habitacion.id_sede);
            command.Parameters.AddWithValue("@id_tipo_habitacion", habitacion.id_tipo_habitacion);
            command.Parameters.AddWithValue("@numero_habitacion", habitacion.numero_habitacion);
            command.Parameters.AddWithValue("@estado", habitacion.estado);

            await connection.OpenAsync();
            await command.ExecuteNonQueryAsync();

            return StatusCode(StatusCodes.Status201Created, habitacion);
        }

        [HttpGet]
        public async Task<IActionResult> ObtenerHabitaciones()
        {
            var habitaciones = new List<Habitacion>();
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Habitacion_Consultar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                var habitacion = new Habitacion
                {
                    id = Convert.ToInt32(reader["Id_Habitacion"]),
                    id_sede = Convert.ToInt32(reader["id_sede"]),
                    id_tipo_habitacion = Convert.ToInt32(reader["id_tipo_habitacion"]),
                    numero_habitacion = reader["numero_habitacion"].ToString(),
                    estado = reader["estado"].ToString(),
                };
                habitaciones.Add(habitacion);
            }
            return Ok(habitaciones);
        }

        [HttpGet("{Id}")]

        public async Task<IActionResult> ObtenerHabitacionesId(int Id)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Habitacion_Consultar_Id", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@Id_habitacion", Id);

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();
            if (!await reader.ReadAsync())
                return NotFound();

            var habitacion = new Habitacion
            {
                id = Convert.ToInt32(reader["Id_Habitacion"]),
                id_sede = Convert.ToInt32(reader["id_sede"]),
                id_tipo_habitacion = Convert.ToInt32(reader["id_tipo_habitacion"]),
                numero_habitacion = reader["numero_habitacion"].ToString(),
                estado = reader["estado"].ToString(),
            };

            return Ok(habitacion);

        }

        [HttpPut("{Id}")]

        public async Task<IActionResult> ActualizarHabitacion(int id, Habitacion habitacion)
        {
            await using var connection =
            new SqlConnection(connectionString);

            await using var command =
            new SqlCommand(
            "sp_Habitacion_Actualizar",
            connection);

            command.CommandType =
            CommandType.StoredProcedure;

            command.Parameters.AddWithValue("@Id_habitacion", id);

            command.Parameters.AddWithValue("@id_sede", habitacion.id_sede);

            command.Parameters.AddWithValue("@id_tipo_habitacion", habitacion.id_tipo_habitacion);

            command.Parameters.AddWithValue("@numero_habitacion", habitacion.numero_habitacion);

            command.Parameters.AddWithValue("@estado", habitacion.estado);

            await connection.OpenAsync();

            int filasAfectadas =
            await command.ExecuteNonQueryAsync();

            if (filasAfectadas == 0)
                return NotFound("No se encontró la habitación.");

            return Ok("Habitación actualizada correctamente.");
        }

        [HttpDelete("{Id}")]

        public async Task<IActionResult> EliminarHabitacion(int Id)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Habitacion_Eliminar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@Id_habitacion", Id);

            await connection.OpenAsync();

            command.ExecuteNonQuery();

            return Ok();

        }
    }
}
