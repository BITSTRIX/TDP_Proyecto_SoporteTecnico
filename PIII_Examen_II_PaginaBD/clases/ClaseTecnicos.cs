using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace PIII_Examen_II_PaginaBD.clases
{
    public class ClaseTecnicos
    {
        public int id { get; set; }
        public string nombre { get; set; }
        public int idUser { get; set; }
        public string especialidad { get; set; }

        public ClaseTecnicos() { }

        public ClaseTecnicos(int id, string nombre, int idSystem, string especialidad)
        {
            this.id = id;
            this.nombre = nombre;
            this.idUser = idSystem;
            this.especialidad = especialidad;
        }

        public static int AgregarTecnico(string especialidad, int idSys)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcAgregarTecnico", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Especialidad", especialidad));
                    cmd.Parameters.Add(new SqlParameter("@SystemUser", idSys));

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

        public static int ModificarTecnico(int ID, String especialidad, int idSys)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcModificarTecnico", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@TecnicoID", ID));
                    cmd.Parameters.Add(new SqlParameter("@Especialidad", especialidad));
                    cmd.Parameters.Add(new SqlParameter("@SystemUser", idSys));
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

        public static int EliminarTecnico(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcEliminarTecnico", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@TecnicoID", ID));

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
        public static List<ClaseTecnicos> ConsultarTecnico(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            List<ClaseTecnicos> List = new List<ClaseTecnicos>();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcConsultarTecnico", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@TecnicoID", ID));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClaseTecnicos Tecnico = new ClaseTecnicos(reader.GetInt32(0), reader.GetString(1), reader.GetInt32(2), reader.GetString(3));  // instancia
                            List.Add(Tecnico);
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






















    }
}