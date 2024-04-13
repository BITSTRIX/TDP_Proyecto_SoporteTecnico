using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace PIII_Examen_II_PaginaBD.clases
{
    public class ClaseReparaciones
    {
        public int idReparacion { get; set; }
        public int idEquipo { get; set; }
        public DateTime Fecha { get; set; }
        public string Estado { get; set; }

        public ClaseReparaciones()
        {

        }
        public ClaseReparaciones(int idReparacion, int idEquipo, DateTime fecha, string estado)
        {
            this.idReparacion = idReparacion;
            this.idEquipo = idEquipo;
            this.Fecha = fecha;
            this.Estado = estado;
        }

        public ClaseReparaciones(int idEquipo, DateTime fecha, string estado)
        {
            this.idEquipo = idEquipo;
            this.Fecha = fecha;
            this.Estado = estado;
        }

        public static int AgregarReparacion(int idReparacion, DateTime fecha, char estado)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcReparacionesAgregar", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@IDEquipo", idReparacion));
                    cmd.Parameters.Add(new SqlParameter("@Fecha", fecha));
                    cmd.Parameters.Add(new SqlParameter("@Estado", estado));

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

        public static List<ClaseReparaciones> ConsultarReparacion(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            List<ClaseReparaciones> List = new List<ClaseReparaciones>();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcReparacionesConsultar", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@IDReparacion", ID));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClaseReparaciones Reparacion = new ClaseReparaciones(reader.GetInt32(0), reader.GetInt32(1), reader.GetDateTime(2), reader.GetString(3));  // instancia
                            List.Add(Reparacion);
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

        public static int ModificarReparacion(int IDReparacion, int IDEquipo, DateTime fecha, char estado)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcReparacionesActualizar", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@IDReparacion", IDReparacion));
                    cmd.Parameters.Add(new SqlParameter("@EquipoID", IDEquipo));
                    cmd.Parameters.Add(new SqlParameter("@Fecha", fecha));
                    cmd.Parameters.Add(new SqlParameter("@Estado", estado));

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