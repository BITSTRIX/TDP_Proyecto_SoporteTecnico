using PIII_Examen_II_PaginaBD.clases;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PIII_Examen_II_PaginaBD.pages
{
    public partial class UsuariosSistema : System.Web.UI.Page
    {
        ClaseUsuarioSistema ClaseUsuarioSistema = new ClaseUsuarioSistema();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarTabla();
                LlenarDropListUsuariosSistema();
            }
        }

        protected void LlenarTabla()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcTablaAcesos"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagrid.DataSource = dt;
                            datagrid.DataBind(); //Este comando refresca los datos.
                        }
                    }

                }
            }
        }

        protected void LlenarDropListUsuariosSistema()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcDropListUsuarios", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            con.Open(); // Abre la conexión antes de ejecutar el comando
                            sda.Fill(dt);
                            DropListUsuarioSistema.DataSource = dt;
                            DropListUsuarioSistema.DataValueField = "usuarioID"; // Reemplaza con el nombre correcto de la columna
                            DropListUsuarioSistema.DataTextField = "nombre"; // Reemplaza con el nombre correcto de la columna
                            DropListUsuarioSistema.DataBind();
                        }
                    }
                }
            }
        }

        public void Alertas(String texto)
        {
            string message = texto;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {

            if (txtIdUsuario.Text != string.Empty && txtPassword.Text != string.Empty)
            {
                int resultado = clases.ClaseUsuarioSistema.AgregarUsuarioSistema(int.Parse(txtIdUsuario.Text), txtPassword.Text);
                if (resultado > 0)
                {
                    Alertas("Acceso registrado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar el Acceso.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        public void Limpiar()
        {
            txtIdUsuario.Text = string.Empty;
            txtCorreo.Text = string.Empty;
            txtIdAcceso.Text = string.Empty;
            txtPassword.Text = string.Empty;
            LlenarTabla();
        }



        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            if (txtIdAcceso.Text != string.Empty)
            {
                List<ClaseUsuarioSistema> Lista;
                Lista = (ClaseUsuarioSistema.ConsultarUsuarioSistema(Convert.ToInt32(txtIdAcceso.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    Limpiar();
                }
                else
                {
                    ClaseUsuarioSistema DatoExtraido = Lista[0];
                    txtIdAcceso.Text = DatoExtraido.idAcceso.ToString();
                    txtIdUsuario.Text = DatoExtraido.idUsuario.ToString();
                    DropListUsuarioSistema.SelectedValue = DatoExtraido.idUsuario.ToString();
                    txtCorreo.Text = DatoExtraido.correo.ToString();
                    txtPassword.Text = DatoExtraido.password.ToString();
                }
            }
            else
            {
                string script = "alert('Error: Consulta Invalida. Ingrese un valor existente en ID del Acceso:');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (txtIdUsuario.Text != string.Empty)
            {
                int resultado = clases.ClaseUsuarioSistema.EliminarUsuarioSistema(Convert.ToInt32(txtIdAcceso.Text));
                if (resultado > 0)
                {
                    Alertas("Acceso eliminado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al intentar eliminar el Acceso.");
                }
            }
            else
            {
                string script = "alert('Error: ID del registro invalido.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (txtIdUsuario.Text != string.Empty && txtPassword.Text != string.Empty)
            {
                int resultado = clases.ClaseUsuarioSistema.ModificarContraseñaUsuarioSistema(Convert.ToInt32(txtIdUsuario.Text), txtPassword.Text);
                if (resultado > 0)
                {
                    Alertas("Acceso modificado correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar el Acceso.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void DropListUsuarioSistema_SelectedIndexChanged(object sender, EventArgs e)
        {
            Limpiar();
            txtIdUsuario.Text = DropListUsuarioSistema.SelectedValue;
        }
    }
}