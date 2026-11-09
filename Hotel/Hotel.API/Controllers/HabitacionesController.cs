using Hotel.SHARED.Entities;
using Hotel.SHARED.Views;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/habitaciones")]
    public class HabitacionesController: ControllerBase
    {
        private readonly string connectionString = "Server=localhost;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

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

        [HttpGet("detalle")]
        public async Task<IActionResult> ObtenerHabitacionesDetalle()
        {
            var habitaciones = new List<HabitacionesSedeView>();

            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand(
                "SELECT ID_habitacion, numero_habitacion, nombre_tipo, capacidad, precio_habitacion, ID_sede, nombre_sede, nombre_ciudad " +
                "FROM dbo.vw_habitaciones_sede ORDER BY ID_habitacion",
                connection)
            {
                CommandType = CommandType.Text
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                habitaciones.Add(new HabitacionesSedeView
                {
                    IdHabitacion = Convert.ToInt32(reader["ID_habitacion"]),
                    NumeroHabitacion = Convert.ToString(reader["numero_habitacion"]),
                    NombreTipo = Convert.ToString(reader["nombre_tipo"]),
                    Capacidad = Convert.ToInt32(reader["capacidad"]),
                    PrecioHabitacion = Convert.ToDecimal(reader["precio_habitacion"]),
                    IdSede = Convert.ToInt32(reader["ID_sede"]),
                    NombreSede = Convert.ToString(reader["nombre_sede"]),
                    NombreCiudad = Convert.ToString(reader["nombre_ciudad"])
                });
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
