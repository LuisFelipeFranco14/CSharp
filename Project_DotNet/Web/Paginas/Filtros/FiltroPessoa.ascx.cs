using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Web.Paginas.Filtros
{
    public partial class FiltroPessoa : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Configura(string url)
        {
            hfService.Value = url;
        }
    }
}