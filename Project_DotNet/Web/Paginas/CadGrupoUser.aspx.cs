using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Web.Paginas
{
    public partial class CadGrupoUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Grupo_Usuario> ListGrupo_Usuario = guDal.GetALL();

            rptTabela.DataSource = ListGrupo_Usuario;
            rptTabela.DataBind();
        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            hfgrupoUser.Value = hfgrupoUser.Value.Replace("-", ",");
            guDal.DeleteUsuarios(hfgrupoUser.Value);
            guDal.DeleteModulos(hfgrupoUser.Value);
            guDal.Delete(hfgrupoUser.Value);
            Response.Redirect(ResolveUrl("CadGrupoUser.aspx"));
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        protected void btnAlterar_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
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

            return true;
        }

        [WebMethod]
        public static List<object> montarGrupo_Usuario(string id)
        {
            List<object> objgrupo_Usuario = new List<object>();
            Grupo_Usuario grupo_Usuario = new Grupo_Usuario();
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            grupo_Usuario = guDal.GetId(Convert.ToInt32(id));

            var Listgrupo_Usuario = new
            {
                desc_grupo = grupo_Usuario.desc_grupo
            };
            objgrupo_Usuario.Add(Listgrupo_Usuario);
            return objgrupo_Usuario;
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

            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            List<Grupo_Usuario> ListGrupo_Usuario = guDal.relatorio(id);

            List<object> list = new List<object>();

            foreach (Grupo_Usuario grupo_Usuario in ListGrupo_Usuario)
            {
                var newObj = new
                {
                    id = grupo_Usuario.id,
                    desc_grupo = grupo_Usuario.desc_grupo
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;
        }

    }
}