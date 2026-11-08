using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Hotel.SHARED.Entities;
using System.Data;

namespace Hotel.API.Controllers
{
    [ApiController]
    [Route("api/huespedes")]
    public class HuespedesControllers : ControllerBase
    {
        private readonly string connectionString = "Server=ANDRESAYALA18;Database=Hotel;Trusted_Connection=True;TrustServerCertificate=True;";

        [HttpPost]
        public async Task<IActionResult> CrearHuesped(Huesped huesped)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Huesped_Insertar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@nombre_huesped", huesped.NombreHuesped);
            command.Parameters.AddWithValue("@apellido_huesped", huesped.ApellidoHuesped);
            command.Parameters.AddWithValue("@documento", huesped.Documento);
            command.Parameters.AddWithValue("@correo", huesped.Correo);
            command.Parameters.AddWithValue("@edad", huesped.Edad);

            await connection.OpenAsync();
            await command.ExecuteNonQueryAsync();

            return StatusCode(StatusCodes.Status201Created, huesped);
        }

        [HttpGet]
        public async Task<IActionResult> ObtenerHuespedes()
        {
            var huespedes = new List<Huesped>();
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Huesped_Consultar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                var huesped = new Huesped
                {
                    Id = Convert.ToInt32(reader["Id_huesped"]),
                    NombreHuesped = reader["nombre_huesped"].ToString(),
                    ApellidoHuesped = reader["apellido_huesped"].ToString(),
                    Documento = Convert.ToInt32(reader["documento"]),
                    Correo = reader["correo"].ToString(),
                    Edad = Convert.ToInt32(reader["edad"])
                };
                huespedes.Add(huesped);
            }
            return Ok(huespedes);
        }

        [HttpGet("{Id}")]

        public async Task<IActionResult> ObtenerHuespedesId(int Id)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Huesped_ConsultarId", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@Id_huesped", Id);

            await connection.OpenAsync();
            await using var reader = await command.ExecuteReaderAsync();
            if (!await reader.ReadAsync())
                return NotFound();

            var huesped = new Huesped
            {
                Id = Convert.ToInt32(reader["Id_huesped"]),
                NombreHuesped = reader["nombre_huesped"].ToString(),
                ApellidoHuesped = reader["apellido_huesped"].ToString(),
                Documento = Convert.ToInt32(reader["documento"]),
                Correo = reader["correo"].ToString(),
                Edad = Convert.ToInt32(reader["edad"])
            };

            return Ok(huesped);

        }

        [HttpPut("{Id}")]

        public async Task<IActionResult> ActualizarHuesped(int id, Huesped huesped)
        {
            await using var connection =
            new SqlConnection(connectionString);

            await using var command =
            new SqlCommand(
            "sp_Huesped_Actualizar",
            connection);

            command.CommandType =
            CommandType.StoredProcedure;

            command.Parameters.AddWithValue("@Id_huesped", id);

            command.Parameters.AddWithValue("@nombre_huesped", huesped.NombreHuesped);

            command.Parameters.AddWithValue("@apellido_huesped", huesped.ApellidoHuesped);

            command.Parameters.AddWithValue("@documento", huesped.Documento);

            command.Parameters.AddWithValue("@correo", huesped.Correo);

            command.Parameters.AddWithValue("@edad", huesped.Edad);

            await connection.OpenAsync();

            int filasAfectadas =
            await command.ExecuteNonQueryAsync();

            if (filasAfectadas == 0)
                return NotFound("No se encontró el huésped.");

            return Ok("Huésped actualizado correctamente.");
        }

        [HttpDelete("{Id}")]

        public async Task<IActionResult> EliminarHuespedes(int Id)
        {
            await using var connection = new SqlConnection(connectionString);
            await using var command = new SqlCommand("sp_Huesped_Eliminar", connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            command.Parameters.AddWithValue("@Id_huesped", Id);

            await connection.OpenAsync();

            command.ExecuteNonQuery();

            return Ok();

        }


    }
}
