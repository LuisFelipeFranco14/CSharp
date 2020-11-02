using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Web.UI.WebControls;

namespace Web.Paginas
{
    public partial class CadUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UsuarioDAL uDal = new UsuarioDAL();
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Usuario> ListGrupo_Usuario = uDal.GetALL();
            List<object> list = new List<object>();

            foreach (Usuario u in ListGrupo_Usuario)
            {
                if (u.flg_ativo == "S") u.flg_ativo = "Sim";
                else if (u.flg_ativo == "N") u.flg_ativo = "Não";

                Grupo_Usuario gu = guDal.GetId(u.id_grupo_usuario_fk);

                var newObj = new
                {
                    id = u.id,
                    login = u.login,
                    desc_grupo = gu.desc_grupo,
                    flg_ativo = u.flg_ativo
                };

                list.Add(newObj);
            }

            rptTabela.DataSource = list;
            rptTabela.DataBind();

            imgLupaGrupoUsuario.Attributes.Add("onclick", "return jsAbrirFiltroGrupoUsuarios();");
        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            UsuarioDAL uDal = new UsuarioDAL();
            hfusuarios.Value = hfusuarios.Value.Replace("-", ",");
            uDal.Delete(hfusuarios.Value);
            Response.Redirect(ResolveUrl("CadUsuario.aspx"));
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool validarLogin(string login)
        {
            UsuarioDAL uDal = new UsuarioDAL();
            Usuario u = uDal.GetLogin(login);

            if (u != null)
            {
                return true;
            } else
            {
                return false;
            }
        }

        [WebMethod]
        public static bool GravarRegistro(string login, string senha, string flag_Ativo, string usu_grupo_id, string acao, string id_alt)
        {
            Usuario u = new Usuario();
            u.login = login;
            u.senha = senha;
            u.flg_ativo = flag_Ativo;
            u.id_grupo_usuario_fk = Convert.ToInt32(usu_grupo_id);

            UsuarioDAL uDal = new UsuarioDAL();

            if (acao == "Inserir")
            {
                uDal.Insert(u);
            }
            else if (acao == "Alterar")
            {
                u.id = Convert.ToInt32(id_alt);
                uDal.Update(u);
            }

            return true;

        }


    }
}