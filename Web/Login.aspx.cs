using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Windows;
using System.Web.UI;

namespace Web
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Esquece_senha"] != null)
            {
                Session["Esquece_senha"] = null;
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "E-mail enviado", "alert('" + "Um E-mail foi enviado, por favor validar sua caixa de mensagem." + "');", true);
            }

            if (Session["USUARIO"] != null)
            {
                Response.Redirect(ResolveUrl("~/Principal.aspx"));
            }
            else txtUsuario.Focus();

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Usuario u_logado = new Usuario();
            u_logado.login = txtUsuario.Value;
            u_logado.senha = txtSenha.Value;

            UsuarioDAL usu_dal = new UsuarioDAL();
            Usuario u = new Usuario();
            u = usu_dal.GetId(txtUsuario.Value, txtSenha.Value);
            u_logado.id_grupo_usuario_fk = u.id_grupo_usuario_fk;

            Session["USUARIO"] = u_logado;
            Response.Redirect(ResolveUrl("~/Principal.aspx"));
        }

        [WebMethod]
        public static Boolean BuscarUsuario(string login, string senha)
        {
            UsuarioDAL usu_dal = new UsuarioDAL();
            Usuario u = new Usuario();
            u = usu_dal.GetId(login, senha);
            return u != null;
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            Session["Esquece_senha"] = "Enviado";
            Response.Redirect(ResolveUrl("Login.aspx"));
        }
    }
}