using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PIII_Examen_II_PaginaBD.clases
{
    public class gVar
    {
        public static string Nombre;
        public static string TipoRol;
    }
    public class ClaseInicioSesion
    {
        private static string clave;
        private static string usuario;
        private static int rol;

        public ClaseInicioSesion(string Clave, string Usuario, int Rol)
        {
            clave = Clave;
            usuario = Usuario;
            rol = Rol;
        }

        public ClaseInicioSesion(string Clave, string Usuario)
        {
            clave = Clave;
            usuario = Usuario;
        }

        public string Getclave()
        {
            return clave;   
        }

        public string Getusuario()
        {
            return usuario;
        }

        public int Getrol()
        {
            return rol;
        }

        public void Setclave(string contrasenna)
        {
            clave = contrasenna;
        }
        public void setusuario(string Usuario)
        {
            usuario = Usuario;
        }

        public void setrol(int Rol)
        {
            rol = Rol;
        }

    
 
        public static int ValidarLogin()
        {
            int retorno = 0;
            int tipoUsuario = 0;
            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = Dbconn.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("PCValidarUsuario", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@Clave", clave));
                    cmd.Parameters.Add(new SqlParameter("@Correo", usuario));

                    retorno = cmd.ExecuteNonQuery();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            retorno = 1;
                            gVar.Nombre = rdr.GetString(1);
                            gVar.TipoRol = rdr.GetString(3);

                        }
                        else
                        {
                            retorno = -1;
                        }
                    }
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