using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;

namespace Web
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string ValidarAcesso()
        {
            string validarPagina = "N";

            ParametroDAL pDal = new ParametroDAL();
            Parametro p = new Parametro();

            p = pDal.GetId(1);

            validarPagina = p.flg_acesso_desenvolvimento;

            return validarPagina;
        }
    }
}