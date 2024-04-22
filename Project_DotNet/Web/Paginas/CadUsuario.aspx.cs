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
            List<Usuario> ListUsuario = uDal.GetALL();
            List<object> list = new List<object>();

            foreach (Usuario u in ListUsuario)
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
            AltimgLupaGrupoUsuario.Attributes.Add("onclick", "return jsAbrirFiltroGrupoUsuarios();");
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

        protected void btnAlterar_Click(object sender, EventArgs e)
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

        [WebMethod]
        public static List<object> validarPesqGrupo_Usuario(string GrupoUsuario)
        {
            Grupo_UsuarioDAL guDAL = new Grupo_UsuarioDAL();
            Grupo_Usuario gu = guDAL.getGrupo_Usuario(GrupoUsuario);
            List<object> objGrupo_Usuario = new List<object>();
            if (gu != null)
            {
                var ListGrupo_Usuario = new
                {
                    id = gu.id,
                    desc_grupo = gu.desc_grupo
                };
                objGrupo_Usuario.Add(ListGrupo_Usuario);
            }
            else
            {
                var ListGrupo_Usuario = new
                {
                    id = 0,
                    desc_grupo = ""
                };
                objGrupo_Usuario.Add(ListGrupo_Usuario);

            }
            
            return objGrupo_Usuario;
        }

        [WebMethod]
        public static string relatorio(string id)
        {
            id = id.Trim();
            if (id.Contains("-"))
            {
                id = id.Replace("-", ",");
                id = id.Replace("'", "");
            }

            UsuarioDAL uDal = new UsuarioDAL();
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Usuario> ListUsuario = uDal.relatorio(id);

            List<object> list = new List<object>();

            foreach (Usuario usuario in ListUsuario)
            {
                if (usuario.flg_ativo == "S") usuario.flg_ativo = "Sim";
                else if (usuario.flg_ativo == "N") usuario.flg_ativo = "Não";

                Grupo_Usuario gu = new Grupo_Usuario();
                gu = guDal.GetId(usuario.id_grupo_usuario_fk);

                var newObj = new
                {
                    id = usuario.id,
                    login = usuario.login,
                    desc_grupo = gu.desc_grupo,
                    flg_ativo = usuario.flg_ativo 
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;
        }

        [WebMethod]
        public static List<object> montarUsuario(string id)
        {
            List<object> objusuario = new List<object>();
            Usuario usuario = new Usuario();
            UsuarioDAL uDal = new UsuarioDAL();
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            usuario = uDal.getId(id);

            if (usuario.flg_ativo == "S") usuario.flg_ativo = "Sim";
            else if (usuario.flg_ativo == "N") usuario.flg_ativo = "Não";

            Grupo_Usuario gu = guDal.GetId(usuario.id_grupo_usuario_fk);

            var Listusuario = new
            {
                id = usuario.id,
                login = usuario.login,
                senha = usuario.senha,
                id_grupo_usuario = gu.id,
                desc_grupo = gu.desc_grupo,
                flg_ativo = usuario.flg_ativo
            };
            objusuario.Add(Listusuario);
            return objusuario;
        }

    }
}