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
                    descricao_sem_caracter = secao.descricao_sem_caracter,
                    desc_grupo = gu.desc_grupo
                };

                list.Add(newObj);
            }

            rptTabela.DataSource = list;
            rptTabela.DataBind();
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
                    descricao_sem_caracter = secao.descricao_sem_caracter,
                    desc_grupo = gu.desc_grupo
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;

        }
    }
}