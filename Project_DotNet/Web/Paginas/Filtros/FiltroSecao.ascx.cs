using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using System.Web.Script.Services;

namespace Web.Paginas.Filtros
{
    public partial class FiltroSecao : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SecaoDAL sDal = new SecaoDAL();
            List<Secao> ListSecao = sDal.GetALL();

            rptTabela.DataSource = ListSecao;
            rptTabela.DataBind();
        }
    }
}