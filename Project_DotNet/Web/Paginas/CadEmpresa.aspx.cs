using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Web.Paginas
{
    public partial class CadEmpresa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EmpresaDAL eDAL = new EmpresaDAL();
            PessoaDAL pDAL = new PessoaDAL();

            List<Empresa> ListEmpresa = eDAL.GetALL();
            List<object> list = new List<object>();

            foreach (Empresa empresa in ListEmpresa)
            {
                Pessoa p = pDAL.GetId(empresa.id_pessoa_fk);
                p.CNPJ_CPF = p.CNPJ_CPF.Insert(2, ".").Insert(6, ".").Insert(10, "/").Insert(15, "-");

                var newObj = new
                {
                    id = empresa.id,
                    Nome_razao_social = p.Nome_razao_social,
                    CNPJ_CPF = p.CNPJ_CPF
                };

                list.Add(newObj);

            }

            rptTabela.DataSource = list;
            rptTabela.DataBind();

            imgLupaPessoa.Attributes.Add("onclick", "return jsAbrirFiltroPessoas();");
            ctrFiltroPessoa.Configura(ResolveUrl("~/Servicos/FiltroPessoa.asmx/FiltroPessoaJuridica"));

        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            EmpresaDAL eDAL = new EmpresaDAL();
            hfempresas.Value = hfempresas.Value.Replace("-", ",");
            eDAL.Delete(hfempresas.Value);
            Response.Redirect(ResolveUrl("CadEmpresa.aspx"));
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

            EmpresaDAL eDAL = new EmpresaDAL();
            PessoaDAL pDAL = new PessoaDAL();

            List<Empresa> ListEmpresa = eDAL.relatorio(id);

            List<object> list = new List<object>();

            foreach (Empresa empresa in ListEmpresa)
            {

                Pessoa p = new Pessoa();
                p = pDAL.GetId(empresa.id_pessoa_fk);
                p.CNPJ_CPF = p.CNPJ_CPF.Insert(2, ".").Insert(6, ".").Insert(10, "/").Insert(15, "-");
                p.telefone = p.telefone.Insert(0, "(").Insert(3, ")").Insert(8, "-");
                p.celular = p.celular.Insert(0, "(").Insert(3, ")").Insert(9, "-");

                var newObj = new
                {
                    id = empresa.id,
                    Nome_razao_social = p.Nome_razao_social,
                    CNPJ_CPF = p.CNPJ_CPF,
                    Endereco = p.Logradouro +", "+ p.numero + p.complemento,
                    Telefone = p.telefone + " / " + p.celular
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static bool GravarRegistro(string id_pessoa_juridica, string acao, string id_alt)
        {
            Empresa empresa = new Empresa();
            empresa.id_pessoa_fk = Convert.ToInt32(id_pessoa_juridica);

            EmpresaDAL eDAL = new EmpresaDAL();

            if (acao == "Inserir")
            {
                eDAL.Insert(empresa);
            }
            else if (acao == "Alterar")
            {
                empresa.id = Convert.ToInt32(id_alt);
                eDAL.Update(empresa);
            }

            return true;
        }


        protected void btnAlterar_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<object> montarEmpresa(string id)
        {
            List<object> objempresa = new List<object>();
            Empresa empresa = new Empresa();
            EmpresaDAL eDAL = new EmpresaDAL();
            empresa = eDAL.GetId(Convert.ToInt32(id));
            Pessoa pessoa = new Pessoa();
            PessoaDAL pDAL = new PessoaDAL();
            pessoa = pDAL.GetId(empresa.id_pessoa_fk);

            var Listpessoa = new
            {
                Nome_razao_social = pessoa.Nome_razao_social,
                Nome_fantasia = pessoa.Nome_fantasia,
                CNPJ_CPF = pessoa.CNPJ_CPF.Insert(9, "-").Insert(6, ".").Insert(3, "."),
                inscricao_estadual = pessoa.inscricao_estadual,
                dt_nascimento = pessoa.dt_nascimento.ToString("yyyy-MM-dd"),
                CEP = pessoa.CEP.Insert(5, "-"),
                Logradouro = pessoa.Logradouro,
                Bairro = pessoa.Bairro,
                Cidade = pessoa.Cidade,
                UF = pessoa.UF,
                numero = pessoa.numero,
                complemento = pessoa.complemento,
                telefone = pessoa.telefone.Insert(0, "(").Insert(3, ")").Insert(8, "-"),
                celular = pessoa.celular.Insert(0, "(").Insert(3, ")").Insert(9, "-"),
                email = pessoa.email,
                flag_pessoa = pessoa.flag_pessoa,
                endereco = pessoa.Logradouro + ", " + pessoa.numero + pessoa.complemento,
                id = empresa.id_pessoa_fk
            };
            objempresa.Add(Listpessoa);

            return objempresa;
        }
    }
}