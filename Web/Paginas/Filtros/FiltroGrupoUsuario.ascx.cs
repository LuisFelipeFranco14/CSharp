using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using System.Web.Script.Services;

namespace Web.Paginas.Filtros
{
    public partial class FiltroGrupoUsuario : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Grupo_Usuario> ListGrupo_Usuario = guDal.GetALL();

            rptTabela.DataSource = ListGrupo_Usuario;
            rptTabela.DataBind();
        } 
    }
}