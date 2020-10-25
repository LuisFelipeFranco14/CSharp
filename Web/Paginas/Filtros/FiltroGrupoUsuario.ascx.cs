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
            btnInserir.Attributes.Add("onclick", "jsValidarFiltroGrupoUsuarios();");

            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Grupo_Usuario> ListGrupo_Usuario = guDal.GetALL();

            rptTabela.DataSource = ListGrupo_Usuario;
            rptTabela.DataBind();
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static bool GravarRegistro(string desc_grupo, string acao, string id_alt)
        {
            Grupo_Usuario grupo_Usuario = new Grupo_Usuario();
            grupo_Usuario.desc_grupo = desc_grupo;

            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();

            if (acao == "Inserir")
            {
                guDal.Insert(grupo_Usuario);
            }
            else if (acao == "Alterar")
            {
                grupo_Usuario.id = Convert.ToInt32(id_alt);
                guDal.Update(grupo_Usuario);
            }

            FiltroGrupoUsuario LoadTabela = new FiltroGrupoUsuario();
            return LoadTabela.LoadTabela();

        }

        private bool LoadTabela()
        {
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Grupo_Usuario> ListGrupo_Usuario = guDal.GetALL();

            rptTabela.DataSource = ListGrupo_Usuario;
            rptTabela.DataBind();
            return true;
        }

        protected void btnInserirFiltroGrupoUsuarios_Click(object sender, EventArgs e)
        {

        }
    }
}