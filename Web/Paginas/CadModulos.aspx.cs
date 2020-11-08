using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Web.Paginas
{
    public partial class CadModulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ModuloDAL mDal = new ModuloDAL();
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            SecaoDAL sDal = new SecaoDAL();

            List<Modulo> ListModulo = mDal.GetALL();
            List<object> list = new List<object>();

            foreach (Modulo m in ListModulo)
            {
                Grupo_Usuario gu = guDal.GetId(m.id_grupo_usuario_fk);
                Secao secao = sDal.GetId(m.id_secao_fk);

                var newObj = new
                {
                    id = m.id,
                    descr_modulo = m.descr_modulo,
                    caminho = m.caminho,
                    descricao_com_caracter = secao.descricao_com_caracter,
                    desc_grupo = gu.desc_grupo
                };

                list.Add(newObj);
            }

            rptTabela.DataSource = list;
            rptTabela.DataBind();

            imgLupaGrupoUsuario.Attributes.Add("onclick", "return jsAbrirFiltroGrupoUsuarios();");
            imgLupaSecao.Attributes.Add("onclick", "return jsAbrirFiltroSecoes();");

            AltimgLupaGrupoUsuario.Attributes.Add("onclick", "return jsAbrirFiltroGrupoUsuarios();");
            AltimgLupaSecao.Attributes.Add("onclick", "return jsAbrirFiltroSecoes();");
        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            ModuloDAL mDal = new ModuloDAL();
            hfmodulos.Value = hfmodulos.Value.Replace("-", ",");
            mDal.Delete(hfmodulos.Value);
            Response.Redirect(ResolveUrl("CadModulos.aspx"));
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        protected void btnAlterar_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool GravarRegistro(string descr_modulo, string caminho, string secao_id, string usu_grupo_id, string acao, string id_alt)
        {
            Modulo m = new Modulo();
            ModuloDAL mDAL = new ModuloDAL();
            m.descr_modulo = descr_modulo;
            m.caminho = caminho;
            m.id_secao_fk = Convert.ToInt32(secao_id);
            m.id_grupo_usuario_fk = Convert.ToInt32(usu_grupo_id);

            if (acao == "Inserir")
            {
                mDAL.Insert(m);
            }
            else if (acao == "Alterar")
            {
                m.id = Convert.ToInt32(id_alt);
                mDAL.Update(m);
            }

            return true;
        }

        [WebMethod]
        public static List<object> montarModulo(string id)
        {
            ModuloDAL mDal = new ModuloDAL();
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            SecaoDAL sDal = new SecaoDAL();

            Modulo m = mDal.GetId(Convert.ToInt32(id));
            List<object> list = new List<object>();

            Grupo_Usuario gu = guDal.GetId(m.id_grupo_usuario_fk);
            Secao secao = sDal.GetId(m.id_secao_fk);

            var newObj = new
            {
                id = m.id,
                descr_modulo = m.descr_modulo,
                caminho = m.caminho,
                id_secao_fk = m.id_secao_fk,
                descricao_com_caracter = secao.descricao_com_caracter,
                id_grupo_usuario_fk = m.id_grupo_usuario_fk,
                desc_grupo = gu.desc_grupo
            };

            list.Add(newObj);

            return list;
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

            ModuloDAL mDal = new ModuloDAL();
            List<Modulo> ListModulo = mDal.relatorio(id);
            Grupo_UsuarioDAL guDal = new Grupo_UsuarioDAL();
            SecaoDAL sDal = new SecaoDAL();

            List<object> list = new List<object>();

            foreach (Modulo m in ListModulo)
            {
                Grupo_Usuario gu = guDal.GetId(m.id_grupo_usuario_fk);
                Secao secao = sDal.GetId(m.id_secao_fk);

                var newObj = new
                {
                    id = m.id,
                    descr_modulo = m.descr_modulo,
                    caminho = m.caminho,
                    descricao_com_caracter = secao.descricao_com_caracter,
                    desc_grupo = gu.desc_grupo
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;

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
        public static List<object> validarPesqSecao(string descricao_com_caracter)
        {
            SecaoDAL sDAL = new SecaoDAL();
            Secao s = sDAL.getSecao(descricao_com_caracter);
            List<object> objSecao = new List<object>();
            if (s != null)
            {
                var ListSecao = new
                {
                    id = s.id,
                    descricao_com_caracter = s.descricao_com_caracter
                };
                objSecao.Add(ListSecao);
            }
            else
            {
                var ListSecao = new
                {
                    id = 0,
                    descricao_com_caracter = ""
                };
                objSecao.Add(ListSecao);

            }

            return objSecao;
        }
    }
}