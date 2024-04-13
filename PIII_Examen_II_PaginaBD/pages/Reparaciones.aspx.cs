using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PIII_Examen_II_PaginaBD.clases;

namespace PIII_Examen_II_PaginaBD.pages
{
    public partial class Reparaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarTablaReparaciones();
                LlenarTablaAsignaciones();
                LlenarDropListEquipos();
                LlenarDropListReparacionesID();
                LlenarDropListTecnicos();
            }
        }

        protected void LlenarTablaReparaciones()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcTablaReparaciones"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DGReparaciones.DataSource = dt;
                            DGReparaciones.DataBind();

                        }
                    }

                }
            }
        }

        protected void LlenarTablaAsignaciones()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcTablaAsignaciones"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DGAsignaciones.DataSource = dt;
                            DGAsignaciones.DataBind();

                        }
                    }

                }
            }
        }

        protected void LlenarDropListEquipos()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcDropListEquipos"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListEquipos.DataSource = dt;
                            DropListEquipos.DataValueField = dt.Columns["equipoID"].ToString();
                            DropListEquipos.DataTextField = dt.Columns["equipoID"].ToString();
                            DropListEquipos.DataBind(); //Este comando refresca los datos.
                        }
                    }

                }
            }
        }

        protected void LlenarDropListReparacionesID()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcDropListReparaciones"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListReparacionID.DataSource = dt;
                            DropListReparacionID.DataValueField = dt.Columns["reparacionID"].ToString();
                            DropListReparacionID.DataTextField = dt.Columns["reparacionID"].ToString();
                            DropListReparacionID.DataBind(); //Este comando refresca los datos.
                        }
                    }

                }
            }
        }

        protected void LlenarDropListTecnicos()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("PcDropListTecnicos"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            DropListTecnicos.DataSource = dt;
                            DropListTecnicos.DataValueField = dt.Columns["tecnicoID"].ToString();
                            DropListTecnicos.DataTextField = dt.Columns["nombre"].ToString();
                            DropListTecnicos.DataBind(); //Este comando refresca los datos.
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

        public void Limpiar()
        {
            txtIDReparacion.Text = string.Empty;
            txtFecha.Text = string.Empty;
            DropListEquipos.SelectedValue = null;
            DropListEstado.SelectedValue = null;
            LlenarTablaReparaciones();
            LlenarTablaAsignaciones();
            LlenarDropListEquipos();
            LlenarDropListReparacionesID();
            LlenarDropListTecnicos();

        }

        protected void btnAgregarReparacion_Click(object sender, EventArgs e)
        {

            if (txtFecha.Text != string.Empty && DropListEquipos.SelectedValue != null)
            {
                int resultado = clases.ClaseReparaciones.AgregarReparacion(int.Parse(DropListEquipos.SelectedValue), Convert.ToDateTime(txtFecha.Text), Convert.ToChar(DropListEstado.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Reparacion registrada correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar la Reparacion.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnConsultarReparacion_Click(object sender, EventArgs e)
        {
            if (txtIDReparacion.Text != string.Empty)
            {
                List<ClaseReparaciones> Lista;
                Lista = (ClaseReparaciones.ConsultarReparacion(Convert.ToInt32(txtIDReparacion.Text)));

                if (Lista.Count == 0)
                {
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                    Limpiar();
                }
                else
                {
                    ClaseReparaciones DatoExtraido = Lista[0];
                    txtIDReparacion.Text = DatoExtraido.idReparacion.ToString();
                    DropListEquipos.Text = DatoExtraido.idEquipo.ToString();
                    txtFecha.Text = DatoExtraido.Fecha.ToString();
                    DropListEstado.Text = DatoExtraido.Estado.ToString();
                }

            }
            else
            {
                string script = "alert('Error: Consulta Invalida.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnActualizarReparacion_Click(object sender, EventArgs e)
        {
            if (txtIDReparacion.Text != string.Empty && txtFecha.Text != string.Empty && DropListEquipos.Text != string.Empty)
            {
                int resultado = clases.ClaseReparaciones.ModificarReparacion(Convert.ToInt32(txtIDReparacion.Text), int.Parse(DropListEquipos.SelectedValue), Convert.ToDateTime(txtFecha.Text), Convert.ToChar(DropListEstado.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Reparacion modificada correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar la Reparacion.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }
        //ASIGNACIONES ***************************************************************************************************
        protected void btnAsignar_Click(object sender, EventArgs e)
        {

            if (DropListReparacionID.SelectedValue != null && DropListTecnicos.SelectedValue != null)
            {
                int resultado = clases.ClaseAsignaciones.AsignacionesAgregar(int.Parse(DropListReparacionID.SelectedValue), int.Parse(DropListTecnicos.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Asignacion registrada correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al ingresar la Asignacion.");
                }
            }
            else
            {
                string script = "alert('Error: Los datos no fueron ingresados correctamente.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnConsultarAsignacion_Click(object sender, EventArgs e)
        {
            if (txtIDAsignacion.Text != string.Empty)
            {
                List<ClaseAsignaciones> Lista;
                Lista = (ClaseAsignaciones.ConsultarAsignacion(Convert.ToInt32(txtIDAsignacion.Text)));

                if (Lista.Count == 0)
                {
                    Limpiar();
                    Alertas("No se ha encontrando ningun registro en la Base de Datos.");
                }
                else
                {
                    ClaseAsignaciones DatoExtraido = Lista[0];
                    txtIDAsignacion.Text = DatoExtraido.IdAsignacion.ToString();
                    DropListReparacionID.Text = DatoExtraido.IdReparacion.ToString();
                    DropListTecnicos.Text = DatoExtraido.IdTecnico.ToString();
                    txtFechaAsignacion.Text = DatoExtraido.fechaAsignacion.ToString();
                }

            }
            else
            {
                string script = "alert('Error: Consulta Invalida.');";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "alerta", script, true);
            }
        }

        protected void btnActualizarAsignacion_Click(object sender, EventArgs e)
        {
            if (txtIDAsignacion.Text != string.Empty && DropListReparacionID.Text != string.Empty && DropListTecnicos.Text != string.Empty)
            {
                int resultado = clases.ClaseAsignaciones.ModificarAsignacion(Convert.ToInt32(txtIDAsignacion.Text), int.Parse(DropListReparacionID.SelectedValue), int.Parse(DropListTecnicos.SelectedValue));
                if (resultado > 0)
                {
                    Alertas("Asignacion modificada correctamente.");
                    Limpiar();
                }
                else
                {
                    Alertas("Error al modificar la Asignacion.");
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