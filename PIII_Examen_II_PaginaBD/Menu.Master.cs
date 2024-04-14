using PIII_Examen_II_PaginaBD.pages;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PIII_Examen_II_PaginaBD
{
    public partial class Menu : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar el tipo de usuario
                string userType = clases.gVar.TipoRol; // Puedes obtener este valor de donde lo estés almacenando (por ejemplo, una variable de sesión)

                // Ocultar opciones del menú basado en el tipo de usuario
                if (userType == "Tecnico")
                {
                    navbar__itemUsuariosSistema.Visible = false;
                    navbar__itemReportes.Visible = false;
                    navbar__itemTecnicos.Visible = false;
                    navbar__itemRoles.Visible = false;
                }
                else if (userType == "Admin")
                {
                  //No se oculta ninguna opcion
                }
                else
                {
                    navbar__itemInicio.Visible = false;
                    navbar__itemUsuariosSistema.Visible = false;
                    navbar__itemReportes.Visible = false;
                    navbar__itemTecnicos.Visible = false;
                    navbar__itemRoles.Visible = false;
                    navbar__itemUsuarios.Visible = false;
                    navbar__itemReparaciones.Visible = false;
                }
            }
        }
    }
}