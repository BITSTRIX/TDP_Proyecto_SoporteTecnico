using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace PIII_Examen_II_PaginaBD.clases
{
    public class ClaseUsuarioSistema
    {

        public int idAcceso { get; set; }
        public int idUsuario { get; set; }
        public string nombre { get; set; }
        public string correo { get; set; }
        public string password { get; set; }

        public ClaseUsuarioSistema() { }

        public ClaseUsuarioSistema(int IDAcceso, int IDUsuario, string nombre, string correo, string password)
        {
            this.idAcceso = IDAcceso;
            this.idUsuario = IDUsuario;
            this.nombre = nombre;
            this.correo = correo;
            this.password = password;
        }

        public static int AgregarUsuarioSistema(int IDUsuario, string password)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcAgregarUsuarioSistema", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@idUsuario", IDUsuario));
                    cmd.Parameters.Add(new SqlParameter("@Password ", password));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }
            return retorno;
        }

        public static int ModificarContraseñaUsuarioSistema(int ID, String password)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcModificarContraseñaUsuarioSistema", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@AccessID", ID));
                    cmd.Parameters.Add(new SqlParameter("@Password", password));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }
            return retorno;
        }

        public static List<ClaseUsuarioSistema> ConsultarUsuarioSistema(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            List<ClaseUsuarioSistema> List = new List<ClaseUsuarioSistema>();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcConsultarUsuarioSistema", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@AccesoID", ID));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClaseUsuarioSistema UsuarioSistema = new ClaseUsuarioSistema(reader.GetInt32(0), reader.GetInt32(1), reader.GetString(2), reader.GetString(3), reader.GetString(4));  // instancia
                            List.Add(UsuarioSistema);
                        }
                    }
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return List;
            }
            finally
            {
                Conn.Close();
                Conn.Dispose();
            }
            return List;
        }

        public static int EliminarUsuarioSistema(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcEliminarUsuarioSistema", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@AccessID", ID));
                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }
            return retorno;
        }
       
    }
}