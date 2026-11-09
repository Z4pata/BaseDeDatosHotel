using Hotel.SHARED.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/tipo-habitaciones")]
    public class TipoHabitacionesController : ControllerBase
    {
        private readonly string connectionString = "Server=localhost;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

        [HttpPost]
        public async Task<IActionResult> CrearTipoHabitacion(TipoHabitacion tipoHabitacion)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_TipoHabitacion_Insertar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@nombre_tipo", tipoHabitacion.Nombre_Tipo);
            command.Parameters.AddWithValue("@capacidad", tipoHabitacion.capacidad);
            command.Parameters.AddWithValue("@precio_habitacion", tipoHabitacion.Precio);

            await connection.OpenAsync();
            await command.ExecuteNonQueryAsync();

            return StatusCode(StatusCodes.Status201Created, tipoHabitacion);
        }

        [HttpGet]
        public async Task<IActionResult> ObtenerTiposHabitacion()
        {
            var tiposHabitacion = new List<TipoHabitacion>();

            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_TipoHabitacion_Consultar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                tiposHabitacion.Add(new TipoHabitacion
                {
                    Id = Convert.ToInt32(reader["ID_tipo_habitacion"]),
                    Nombre_Tipo = Convert.ToString(reader["nombre_tipo"]),
                    capacidad = Convert.ToInt32(reader["capacidad"]),
                    Precio = Convert.ToDecimal(reader["precio_habitacion"])
                });
            }

            return Ok(tiposHabitacion);
        }

        [HttpPut("{Id}")]
        public async Task<IActionResult> ActualizarTipoHabitacion(int Id, TipoHabitacion tipoHabitacion)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_TipoHabitacion_Actualizar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@id_tipo_habitacion", Id);
            command.Parameters.AddWithValue("@nombre_tipo", tipoHabitacion.Nombre_Tipo);
            command.Parameters.AddWithValue("@capacidad", tipoHabitacion.capacidad);
            command.Parameters.AddWithValue("@precio_habitacion", tipoHabitacion.Precio);

            await connection.OpenAsync();
            var filasAfectadas = await command.ExecuteNonQueryAsync();

            if (filasAfectadas == 0)
                return NotFound("No se encontró el tipo de habitación.");

            tipoHabitacion.Id = Id;
            return Ok(tipoHabitacion);
        }

        [HttpDelete("{Id}")]
        public async Task<IActionResult> EliminarTipoHabitacion(int Id)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_TipoHabitacion_Eliminar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@id_tipo_habitacion", Id);

            await connection.OpenAsync();
            var filasAfectadas = await command.ExecuteNonQueryAsync();

            if (filasAfectadas == 0)
                return NotFound("No se encontró el tipo de habitación.");

            return Ok("Tipo de habitación eliminado correctamente.");
        }
    }
}
