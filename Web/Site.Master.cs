using System;
using DAL.Model;
using DAL.Persistence;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Web
{
    public partial class Site : System.Web.UI.MasterPage
    {
        
        private List<Secao> listsecao = new List<Secao>();
        private Usuario usuario = new Usuario();
        private int teste = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USUARIO"] == null)
            {

                ParametroDAL pDal = new ParametroDAL();
                Parametro p = new Parametro();

                p = pDal.GetId(1);

                if (p.flg_acesso_desenvolvimento == "S")
                {
                    usuario.login = "Admin";
                    usuario.senha = "123456";
                    usuario.id_grupo_usuario_fk = 1;

                    Session["USUARIO"] = usuario;

                } else if (p.flg_acesso_desenvolvimento == "N")
                {
                    Response.Redirect(ResolveUrl("~/Login.aspx"));
                }

            } else
            {
                usuario = (Usuario)Session["USUARIO"];
            }

            ModuloDAL mdal = new ModuloDAL();
            listsecao = mdal.SecaoGrupo(usuario.id_grupo_usuario_fk);

            rptMenu.DataSource = listsecao;
            rptMenu.DataBind();
        }

        protected void btnSair_Click(object sender, EventArgs e)
        {
            Session["USUARIO"] = null;
            Response.Redirect(ResolveUrl("~/Login.aspx"));
        }

        protected void rptMenu_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) 
                return;

            if (e.Item.Controls.Contains((Repeater)e.Item.FindControl("rptModulo")))
            {
                HtmlInputHidden hidden_secao = (HtmlInputHidden)e.Item.FindControl("hidden_secao");
                int secao = Convert.ToInt32(hidden_secao.Value);


                Repeater rptModulo = (Repeater)e.Item.FindControl("rptModulo");

                ModuloDAL mdal = new ModuloDAL();
                List<Modulo> listModulo = new List<Modulo>();
                listModulo = mdal.SecaoModulo(usuario.id_grupo_usuario_fk, secao);
                rptModulo.DataSource = listModulo;
                rptModulo.DataBind();
            }
        }
    }
}