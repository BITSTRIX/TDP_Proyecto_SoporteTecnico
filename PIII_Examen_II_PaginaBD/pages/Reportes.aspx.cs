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

    public partial class Reportes : System.Web.UI.Page
    {
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
            CargarTabla();
            
            dt = ClaseReportes.LlenarTablaInicial("STPCReporteEquipos");
            datagridEquipos.DataSource = dt;
            datagridEquipos.DataBind();
            dt = ClaseReportes.LlenarTablaInicial("STPCReporteAccesosUsuarios");
            datagridAccesos.DataSource = dt;
            datagridAccesos.DataBind();
            dt = ClaseReportes.LlenarTablaInicial("STPCReporteDetalladoReparaciones");
            datagridReparaciones.DataSource = dt;
            datagridReparaciones.DataBind();
        }
        protected void CargarTabla()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Usuarios"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagridUsuarios.DataSource = dt;
                            datagridUsuarios.DataBind(); //Este comando refresca los datos.
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



        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            string opcionSeleccionada = RadioButtonListUsuarios.SelectedValue;
            string STPC = "";
            DataTable dt = new DataTable();
            if (txtConsulta.Text != string.Empty)
            {

                switch (opcionSeleccionada)
                {
                    case "Nombre del Usuario":
                        STPC = "STPCReporteUsuarioNombre";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsulta.Text);
                        datagridUsuarios.DataSource = dt;
                        datagridUsuarios.DataBind();
                        break;

                    case "ID del Usuario":
                        STPC = "STPCReporteUsuarioID";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsulta.Text);
                        datagridUsuarios.DataSource = dt;
                        datagridUsuarios.DataBind();
                        break;

                    case "Correo":
                        STPC = "STPCReporteUsuarioCorreo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsulta.Text);
                        datagridUsuarios.DataSource = dt;
                        datagridUsuarios.DataBind();
                        break;

                    case "Telefono":
                        STPC = "STPCReporteUsuarioID";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsulta.Text);
                        datagridUsuarios.DataSource = dt;
                        datagridUsuarios.DataBind();
                        break;

                    default:
                        Alertas("Debe seleccionar una opcion de filtro.");
                        break;
                }
            }
            else
            {
                Alertas("Debe seleccionar una opcion de filtro e ingresar un dato de busqueda.");
            }

        }

        protected void btnConsultaEquipos_Click(object sender, EventArgs e)
        {
            string opcionSeleccionada = RadioButtonListEquipos.SelectedValue;
            string STPC = "";
            DataTable dt = new DataTable();
            if (txtConsultaEquipos.Text != string.Empty)
            {

                switch (opcionSeleccionada)
                {
                    case "ID del Equipo":
                        STPC = "STPCReporteEquiposIDEquipo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaEquipos.Text);
                        datagridEquipos.DataSource = dt;
                        datagridEquipos.DataBind();
                        break;

                    case "Tipo de Equipo":
                        STPC = "STPCReporteEquiposTipoEquipo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaEquipos.Text);
                        datagridEquipos.DataSource = dt;
                        datagridEquipos.DataBind();
                        break;

                    case "Modelo":
                        STPC = "STPCReporteEquiposModelo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaEquipos.Text);
                        datagridEquipos.DataSource = dt;
                        datagridEquipos.DataBind();
                        break;

                    case "Estado":
                        STPC = "STPCReporteEquiposEstado";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaEquipos.Text);
                        datagridEquipos.DataSource = dt;
                        datagridEquipos.DataBind();
                        break;
                    case "ID Usuario":
                        STPC = "STPCReporteEquiposUsuarioID";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaEquipos.Text);
                        datagridEquipos.DataSource = dt;
                        datagridEquipos.DataBind();
                        break;
                    case "Nombre del Usuario":
                        STPC = "STPCReporteEquiposNombreUsuario";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaEquipos.Text);
                        datagridEquipos.DataSource = dt;
                        datagridEquipos.DataBind();
                        break;

                    default:
                        Alertas("Debe seleccionar una opcion de filtro.");
                        break;
                }
            }
            else
            {
                Alertas("Debe seleccionar una opcion de filtro e ingresar un dato de busqueda.");
            }
        }

        protected void btnConsultarAccesos_Click(object sender, EventArgs e)
        {
            string opcionSeleccionada = RadioButtonListAccesos.SelectedValue;
            string STPC = "";
            DataTable dt = new DataTable();
            if (txtConsultaAccesos.Text != string.Empty)
            {

                switch (opcionSeleccionada)
                {
                    case "Numero de Acceso":
                        STPC = "STPCReporteAccesosNumeroAcceso";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaAccesos.Text);
                        datagridAccesos.DataSource = dt;
                        datagridAccesos.DataBind();
                        break;

                    case "ID del Usuario":
                        STPC = "STPCReporteAccesosIDUsuario";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaAccesos.Text);
                        datagridAccesos.DataSource = dt;
                        datagridAccesos.DataBind();
                        break;

                    case "Nombre del Usuario":
                        STPC = "STPCReporteAccesosNombre";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaAccesos.Text);
                        datagridAccesos.DataSource = dt;
                        datagridAccesos.DataBind();
                        break;

                    case "Correo":
                        STPC = "STPCReporteAccesosCorreo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaAccesos.Text);
                        datagridAccesos.DataSource = dt;
                        datagridAccesos.DataBind();
                        break;
                    case "Rol":
                        STPC = "STPCReporteAccesosRol";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaAccesos.Text);
                        datagridAccesos.DataSource = dt;
                        datagridAccesos.DataBind();
                        break;
                    default:
                        Alertas("Debe seleccionar una opcion de filtro.");
                        break;
                }
            }
            else
            {
                Alertas("Debe seleccionar una opcion de filtro e ingresar un dato de busqueda.");
            }
        }



        protected void btnConsultaReparacion_Click(object sender, EventArgs e)
        {
            string opcionSeleccionada = RadioButtonListReparaciones.SelectedValue;
            string STPC = "";
            DataTable dt = new DataTable();
            if (txtConsultaReparacion.Text != string.Empty)
            {

                switch (opcionSeleccionada)
                {
                    case "Dueño del equipo":
                        STPC = "STPCReporteReparacionesNombre";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;

                    case "ID Equipo":
                        STPC = "STPCReporteReparacionesIDEquipo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;

                    case "Tipo de Equipo":
                        STPC = "STPCReporteReparacionesTipoEquipo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;

                    case "Modelo de Equipo":
                        STPC = "STPCReporteReparacionesModeloEquipo";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;
                    case "ID Reparacion":
                        STPC = "STPCReporteReparacionesIDReparacion";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;
                    case "Estado":
                        STPC = "STPCReporteReparacionesEstado";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;
                    case "ID Asignacion":
                        STPC = "STPCReporteReparacionesIDAsignacion";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;
                    case "ID Tecnico Asignado":
                        STPC = "STPCReporteReparacionesIDTecnico";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;
                    case "Descripcion Reparacion":
                        STPC = "STPCReporteReparacionesDescripcion";
                        dt = ClaseReportes.LlenarTabla(STPC, txtConsultaReparacion.Text);
                        datagridReparaciones.DataSource = dt;
                        datagridReparaciones.DataBind();
                        break;

                    default:
                        Alertas("Debe seleccionar una opcion de filtro.");
                        break;
                }
            }
            else
            {
                Alertas("Debe seleccionar una opcion de filtro e ingresar un dato de busqueda.");
            }
        }

    }
}