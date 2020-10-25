using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Web.Paginas
{
    public partial class CadSecao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SecaoDAL sDal = new SecaoDAL();
            List<Secao> ListSecao = sDal.GetALL();

            rptTabela.DataSource = ListSecao;
            rptTabela.DataBind();
        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            SecaoDAL sDal = new SecaoDAL();
            hfsecoes.Value = hfsecoes.Value.Replace("-", ",");
            sDal.DeleteModulos(hfsecoes.Value);
            sDal.Delete(hfsecoes.Value);
            Response.Redirect(ResolveUrl("CadSecao.aspx"));
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        protected void btnAlterar_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool GravarRegistro(string descricao_sem_caracter, string descricao_com_caracter, string icon, string acao, string id_alt)
        {
            Secao secao = new Secao();
            secao.descricao_sem_caracter = descricao_sem_caracter;
            secao.descricao_com_caracter = descricao_com_caracter;
            secao.icon = icon;

            SecaoDAL secaoDal = new SecaoDAL();

            if (acao == "Inserir")
            {
                secaoDal.Insert(secao);
            }
            else if (acao == "Alterar")
            {
                secao.id = Convert.ToInt32(id_alt);
                secaoDal.Update(secao);
            }

            return true;
        }

        [WebMethod]
        public static List<object> montarSecao(string id)
        {
            List<object> objsecao = new List<object>();
            Secao secao = new Secao();
            SecaoDAL sDal = new SecaoDAL();
            secao = sDal.GetId(Convert.ToInt32(id));

            var Listsecao = new
            {
                descricao_sem_caracter = secao.descricao_sem_caracter,
                descricao_com_caracter = secao.descricao_com_caracter,
                icon = secao.icon
            };
            objsecao.Add(Listsecao);
            return objsecao;
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

            SecaoDAL sDal = new SecaoDAL();
            List<Secao> ListSecao = sDal.relatorio(id);

            List<object> list = new List<object>();

            foreach (Secao secao in ListSecao)
            {
                var newObj = new
                {
                    id = secao.id,
                    descricao_sem_caracter = secao.descricao_sem_caracter,
                    descricao_com_caracter = secao.descricao_com_caracter,
                    icon = secao.icon
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;
        }
    }
}