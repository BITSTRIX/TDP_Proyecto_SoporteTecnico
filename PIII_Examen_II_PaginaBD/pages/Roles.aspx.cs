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
    public partial class Roles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarTablaRol();
                LlenarTablaRolUsers();
                LlenarDropListUsuariosSistema();
                LlenarDropListRoles();
            }
        }

        protected void LlenarTablaRol()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM roles"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagridRol.DataSource = dt;
                            datagridRol.DataBind(); //Este comando refresca los datos.
                        }
                    }

                }
            }
        }

        protected void LlenarTablaRolUsers()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcTablaRolesUsuarios"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagrid1.DataSource = dt;
                            datagrid1.DataBind(); //Este comando refresca los datos.
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
                con.Open(); // Abre la conexión antes de ejecutar el comando
                using (SqlCommand cmd = new SqlCommand("PcDropListUsuariosRoles", con)) // Llama al procedimiento almacenado
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListUsuarioSistema.DataSource = dt;
                            DropListUsuarioSistema.DataValueField = "usuarioID";
                            DropListUsuarioSistema.DataTextField = "nombre";
                            DropListUsuarioSistema.DataBind();
                        }
                    }
                }
            }
        }

        protected void LlenarDropListRoles()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open(); // Abre la conexión antes de ejecutar el comando
                using (SqlCommand cmd = new SqlCommand("PcDropListRoles", con)) // Llama al procedimiento almacenado
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListRoles.DataSource = dt;
                            DropListRoles.DataValueField = "RolID";
                            DropListRoles.DataTextField = "nombreRol";
                            DropListRoles.DataBind();
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

        public void LimpiarRol()
        {
            txtIdRol.Text = string.Empty;
            txtNombreRol.Text = string.Empty;
            LlenarTablaRol();
        }

        protected void btnAgregarRol_Click(object sender, EventArgs e)
        {

            if (txtNombreRol.Text != string.Empty)
            {
                int resultado = clases.ClaseRoles.AgregarRol(txtNombreRol.Text);
                if (resultado > 0)
                {
                    Alertas("Rol registrado correctamente.");
                    LimpiarRol();
                }
                else
                {
                    Alertas("Error al ingresar el Rol.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }
        protected void btnConsultarRol_Click(object sender, EventArgs e)
        {
            if (txtIdRol.Text != string.Empty)
            {
                List<ClaseRoles> Lista;
                Lista = (ClaseRoles.ConsultarRol(Convert.ToInt32(txtIdRol.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    LimpiarRol();
                }
                else
                {
                    ClaseRoles DatoExtraido = Lista[0];
                    txtIdRol.Text = DatoExtraido.idRol.ToString();
                    txtNombreRol.Text = DatoExtraido.nombreRol.ToString();

                }
            }
            else
            {
                string script = "alert('Error: Consulta Invalida.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnEliminarRol_Click(object sender, EventArgs e)
        {
            if (txtIdRol.Text != string.Empty)
            {
                int resultado = clases.ClaseRoles.EliminarRol(Convert.ToInt32(txtIdRol.Text));
                if (resultado > 0)
                {
                    Alertas("Rol eliminado correctamente.");
                    LimpiarRol();
                }
                else
                {
                    Alertas("Error al intentar eliminar el Rol o se encuentra ligado a empleados.");
                }
            }
            else
            {
                string script = "alert('Error: ID del registro invalido.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnModificarRol_Click(object sender, EventArgs e)
        {
            if (txtIdRol.Text != string.Empty && txtNombreRol.Text != string.Empty)
            {
                int resultado = clases.ClaseRoles.ModificarRol(Convert.ToInt32(txtIdRol.Text), txtNombreRol.Text);
                if (resultado > 0)
                {
                    Alertas("Rol modificado correctamente.");
                    LimpiarRol();
                }
                else
                {
                    Alertas("Error al modificar el Rol.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        //CODIGO ROLUSER
        protected void btnAgregarRolUser_Click(object sender, EventArgs e)
        {

            {
                int resultado = clases.ClaseRolUsers.AgregarRolUser(int.Parse(DropListUsuarioSistema.SelectedValue),int.Parse(DropListRoles.SelectedValue));
                txtIdRol.Text = DropListUsuarioSistema.SelectedValue;
                txtNombreRol.Text =DropListUsuarioSistema.SelectedValue;
                if (resultado > 0)
                {
                    Alertas("Rol asignado al usuario correctamente.");
                    LimpiarRolUser();
                }
                else
                {
                    Alertas("Error al asogmar el rol al usuario.");
                }
            }
        }

        public void LimpiarRolUser()
        {
            DropListRoles.Text = null;
            DropListUsuarioSistema.Text = null;
            LlenarTablaRolUsers();
        }



        protected void btnConsultarRolUser_Click(object sender, EventArgs e)
        {
            if (DropListUsuarioSistema.SelectedValue!= null)
            {
                List<ClaseRolUsers> Lista;
                Lista = ClaseRolUsers.ConsultarRolUser(int.Parse(DropListUsuarioSistema.SelectedValue));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    LimpiarRolUser();
                }
                else
                {
                    ClaseRolUsers DatoExtraido = Lista[0];
                    DropListUsuarioSistema.Text = DatoExtraido.idUser.ToString();
                    DropListRoles.Text = DatoExtraido.idRol.ToString();

                }
            }
            else
            {
                string script = "alert('Error: Consulta Invalida.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnEliminarRolUser_Click(object sender, EventArgs e)
        {
            if (DropListUsuarioSistema.SelectedValue != null)
            {
                int resultado = clases.ClaseRolUsers.EliminarRolUser(Convert.ToInt32(DropListUsuarioSistema.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Rol del usuario eliminado correctamente.");
                    LimpiarRolUser();
                }
                else
                {
                    Alertas("Error al intentar eliminar el Rol del usuario.");
                }
            }
            else
            {
                string script = "alert('Error: ID del registro invalido.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnModificarRolUser_Click(object sender, EventArgs e)
        {
            if (DropListRoles.SelectedValue != null && DropListUsuarioSistema.SelectedValue != null)
            {
                int resultado = clases.ClaseRolUsers.ModificarRolUser(int.Parse(DropListUsuarioSistema.SelectedValue), int.Parse(DropListRoles.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Rol del Tecnico modificado correctamente.");
                    LimpiarRolUser();
                }
                else
                {
                    Alertas("Error al modificar el Rol del Tecnico.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }
    }
}