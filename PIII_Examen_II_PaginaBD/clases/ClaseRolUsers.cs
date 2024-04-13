using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace PIII_Examen_II_PaginaBD.clases
{
    public class ClaseRolUsers
    {
        public int idUser;
        public int idRol;

        public ClaseRolUsers(int idUser, int idRol)
        {
            this.idUser = idUser;
            this.idRol = idRol;
            
        }

        public ClaseRolUsers()
        {
        }

        public ClaseRolUsers(int idUser)
        {
            this.idUser = idUser;
        }

        public static int AgregarRolUser(int User, int rol)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcAgregarRoleUser", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@idUserSystem", User));
                    cmd.Parameters.Add(new SqlParameter("@idRol", rol));
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

        public static int ModificarRolUser(int User, int Rol)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcModificarRoleUser", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@idUserSystem", User));
                    cmd.Parameters.Add(new SqlParameter("@idRol", Rol));
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

        public static int EliminarRolUser(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcEliminarRoleUser", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@idUserSystem", ID));

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
        public static List<ClaseRolUsers> ConsultarRolUser(int ID)
        {
            int retorno = 0;
            SqlConnection Conn = new SqlConnection();
            List<ClaseRolUsers> List = new List<ClaseRolUsers>();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PcConsultarRolUser", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@idUser", ID));
                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            ClaseRolUsers Rol = new ClaseRolUsers(reader.GetInt32(0), reader.GetInt32(1));  // instancia
                            List.Add(Rol);
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