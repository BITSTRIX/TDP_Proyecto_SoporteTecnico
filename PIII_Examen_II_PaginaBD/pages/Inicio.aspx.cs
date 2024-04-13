using PIII_Examen_II_PaginaBD.clases;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PIII_Examen_II_PaginaBD.pages
{
    public partial class Inicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblNombre.Text = gVar.Nombre;
            lblRol.Text ="Rol: " + gVar.TipoRol;
        }
    }
}