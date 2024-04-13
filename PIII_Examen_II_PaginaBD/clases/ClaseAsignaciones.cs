using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace PIII_Examen_II_PaginaBD.clases
{
    public class ClaseAsignaciones
    {
        public int IdAsignacion { get; set; }
        public int IdReparacion { get; set;}
        public int IdTecnico { get; set; }
        public DateTime fechaAsignacion { get; set;}

        public ClaseAsignaciones() { }

        public ClaseAsignaciones(int idAsignacion, int idReparacion, int idTecnico, DateTime fechaAsignacion)
        {
            IdAsignacion = idAsignacion;
            IdReparacion = idReparacion;
            IdTecnico = idTecnico;
            this.fechaAsignacion = fechaAsignacion;
        }

        public ClaseAsignaciones(int idReparacion, int idTecnico, DateTime fechaAsignacion)
        {
            IdReparacion = idReparacion;
            IdTecnico = idTecnico;
            this.fechaAsignacion = fechaAsignacion;
        }

        public ClaseAsignaciones(int idReparacion, int idTecnico)
        {
            IdReparacion = idReparacion;
            IdTecnico = idTecnico;
            this.fechaAsignacion = fechaAsignacion;
        }


        public static int AsignacionesAgregar(int idReparacion, int IdTecnico)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcAsignacionesAgregar", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@IDReparacion", idReparacion));
                    cmd.Parameters.Add(new SqlParameter("@IDTecnico", IdTecnico));

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

        public static List<ClaseAsignaciones> ConsultarAsignacion(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            List<ClaseAsignaciones> List = new List<ClaseAsignaciones>();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcAsignacionesConsultar", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@IDAsignacion", ID));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClaseAsignaciones Asignacion = new ClaseAsignaciones(reader.GetInt32(0), reader.GetInt32(1), reader.GetInt32(2), reader.GetDateTime(3));  // instancia
                            List.Add(Asignacion);
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

        public static int ModificarAsignacion(int IDAsignacion, int IDReparacion,  int IdTecnico)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcAsignacionModificar", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@IDAsignacion", IDAsignacion));
                    cmd.Parameters.Add(new SqlParameter("@IDReparacion", IDReparacion));
                    cmd.Parameters.Add(new SqlParameter("@IDTecnico", IdTecnico));

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