using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Web.Paginas
{
    public partial class CadParametro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ParametroDAL pDal = new ParametroDAL();
            List<Parametro> ListParametro = pDal.GetALL();
            foreach (Parametro p in ListParametro)
            {
                if (p.flg_acesso_desenvolvimento == "S") p.flg_acesso_desenvolvimento = "Sim";
                else if (p.flg_acesso_desenvolvimento == "N") p.flg_acesso_desenvolvimento = "Não";
            }
            rptTabela.DataSource = ListParametro;
            rptTabela.DataBind();
        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            ParametroDAL pDal = new ParametroDAL();
            hfparametros.Value = hfparametros.Value.Replace("-", ",");
            pDal.Delete(hfparametros.Value);
            Response.Redirect(ResolveUrl("CadParametro.aspx"));
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<object> montarParametro(string id)
        {
            List<object> objparaemtro = new List<object>();
            Parametro parametro = new Parametro();
            ParametroDAL pDal = new ParametroDAL();
            parametro = pDal.GetId(Convert.ToInt32(id));

            if (parametro.flg_acesso_desenvolvimento == "S") parametro.flg_acesso_desenvolvimento = "Sim";
            else if (parametro.flg_acesso_desenvolvimento == "N") parametro.flg_acesso_desenvolvimento = "Não";

            var Listparametro = new
            {
                desc_parametro = parametro.desc_parametro,
                flg_acesso_desenvolvimento = parametro.flg_acesso_desenvolvimento,
            };
            objparaemtro.Add(Listparametro);
            return objparaemtro;
        }

        protected void btnAlterar_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool GravarRegistro(string desc_parametro, string flg_acesso_desenvolvimento, string acao, string id_alt)
        {

            Parametro parametro = new Parametro();
            parametro.desc_parametro = desc_parametro;
            parametro.flg_acesso_desenvolvimento = flg_acesso_desenvolvimento;

            ParametroDAL parametroDal = new ParametroDAL();

            if (acao == "Inserir")
            {
                parametroDal.Insert(parametro);
            }
            else if (acao == "Alterar")
            {
                parametro.id = Convert.ToInt32(id_alt);
                parametroDal.Update(parametro);
            }

            return true;
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

            ParametroDAL parametroDal = new ParametroDAL();
            List<Parametro> ListParametro = parametroDal.relatorio(id);

            List<object> list = new List<object>();

            foreach (Parametro parametro in ListParametro)
            {
                if (parametro.flg_acesso_desenvolvimento == "S") parametro.flg_acesso_desenvolvimento = "Sim";
                else if (parametro.flg_acesso_desenvolvimento == "N") parametro.flg_acesso_desenvolvimento = "Não";

                var newObj = new
                {
                    id = parametro.id,
                    desc_parametro = parametro.desc_parametro,
                    flg_acesso_desenvolvimento = parametro.flg_acesso_desenvolvimento
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;
        }

    }
}