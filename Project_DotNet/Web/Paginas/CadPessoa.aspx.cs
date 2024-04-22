using System;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Collections.Generic;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

namespace Web.Paginas
{
    public partial class CadPessoa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PessoaDAL pDal = new PessoaDAL();
            List<Pessoa> ListPessoa = pDal.GetALL();

            foreach (Pessoa p in ListPessoa)
            {
                if (p.flag_pessoa == "F")
                {
                    p.CNPJ_CPF = p.CNPJ_CPF.Insert(9, "-").Insert(6, ".").Insert(3, ".");
                } else if (p.flag_pessoa == "J")
                {
                    p.CNPJ_CPF = p.CNPJ_CPF.Insert(2, ".").Insert(6, ".").Insert(10, "/").Insert(15, "-");
                }

                p.telefone = p.telefone.Insert(0, "(").Insert(3, ")").Insert(8, "-");
                p.celular = p.celular.Insert(0, "(").Insert(3, ")").Insert(9, "-");

                if (p.complemento != "")
                {
                    p.complemento = ", " + p.complemento;
                }
            }

            rptTabela.DataSource = ListPessoa;
            rptTabela.DataBind();
        }

        [WebMethod]
        public static List<object> RetornarDadosCEP(string CEP)
        {
            List<object> objCEP = new List<object>();
           
            if (CEP != null && CEP.Length > 0)
            {
                WebClient wCliente = new WebClient();
                wCliente.Encoding = Encoding.UTF8;
                string resultadoDownload = wCliente.DownloadString("https://viacep.com.br/ws/" + CEP.Replace("-", "") + "/json/");

                if (resultadoDownload != null && resultadoDownload.Length > 0)
                {
                    var viacep = new JavaScriptSerializer().Deserialize<ViaCep>(resultadoDownload);

                    var ListCEP = new
                    {
                        district = viacep.bairro,
                        city = viacep.localidade,
                        code = viacep.cep,
                        address = viacep.logradouro,
                        state = viacep.uf,
                        complemento = viacep.complemento,
                        unidade = viacep.unidade
                    };
                    objCEP.Add(ListCEP);
                }   
            }


            return objCEP;
        }

        [WebMethod]
        public static List<object> montarPessoa(string id)
        {
            List<object> objpessoa = new List<object>();
            Pessoa pessoa = new Pessoa();
            PessoaDAL pDal = new PessoaDAL();
            pessoa = pDal.GetId(Convert.ToInt32(id));

            if (pessoa.flag_pessoa == "F")
            {
                pessoa.CNPJ_CPF = pessoa.CNPJ_CPF.Insert(9, "-").Insert(6, ".").Insert(3, ".");
            }
            else if (pessoa.flag_pessoa == "J")
            {
                pessoa.CNPJ_CPF = pessoa.CNPJ_CPF.Insert(2, ".").Insert(6, ".").Insert(10, "/").Insert(15, "-");
            }

            var Listpessoa = new
            {
                Nome_razao_social = pessoa.Nome_razao_social,
                Nome_fantasia = pessoa.Nome_fantasia,
                CNPJ_CPF = pessoa.CNPJ_CPF,
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
                endereco = pessoa.Logradouro + ", " + pessoa.numero + pessoa.complemento
            };
            objpessoa.Add(Listpessoa);
            return objpessoa;
        }


        [WebMethod]
        public static bool GravarRegistro(string nome_RazaoSocial, string nomeFantasia, string cpf_cnpj, string dataNasc, string telefone, string celular, 
                                           string email, string cep, string Estado, string Cidade, string Bairro, string Endereco, string Numero, 
                                           string Complemento, string acao, string validar_pessoa, string id_alt)
        {
            Pessoa pessoa = new Pessoa();
            pessoa.Nome_razao_social = nome_RazaoSocial;

            if (nomeFantasia.Trim() == "")
            {
                pessoa.Nome_fantasia = null;
            } else
            {
                pessoa.Nome_fantasia = nomeFantasia;
            }
            
            pessoa.CNPJ_CPF = cpf_cnpj;
            pessoa.dt_nascimento = Convert.ToDateTime(dataNasc);
            pessoa.telefone = telefone;
            pessoa.celular = celular;
            pessoa.email = email;
            pessoa.CEP = cep;
            pessoa.UF = Estado;
            pessoa.Bairro = Bairro;
            pessoa.Cidade = Cidade;
            pessoa.Logradouro = Endereco;
            pessoa.numero = Convert.ToInt32(Numero);

            if (Complemento.Trim() == "")
            {
                pessoa.complemento = null;
            }
            else
            {
                pessoa.complemento = Complemento;
            }

            if (validar_pessoa == "Fisica")
            {
                pessoa.flag_pessoa = "F";
            } else if (validar_pessoa == "Juridica")
            {
                pessoa.flag_pessoa = "J";
            }
            pessoa.inscricao_estadual = null;
            PessoaDAL pessoaDal = new PessoaDAL();

            if (acao == "Inserir")
            {
                pessoaDal.Insert(pessoa);
            } else if (acao == "Alterar")
            {
                pessoa.id = Convert.ToInt32(id_alt);
                pessoaDal.Update(pessoa);
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

            PessoaDAL pDal = new PessoaDAL();
            List<Pessoa> ListPessoa = pDal.relatorio(id);

            List<object> list = new List<object>();

            foreach (Pessoa pessoa in ListPessoa)
            {
                if (pessoa.flag_pessoa == "F")
                {
                    pessoa.flag_pessoa = "Física";
                    pessoa.CNPJ_CPF = pessoa.CNPJ_CPF.Insert(9, "-").Insert(6, ".").Insert(3, ".");
                }
                else if (pessoa.flag_pessoa == "J")
                {
                    pessoa.flag_pessoa = "júridica";
                    pessoa.CNPJ_CPF = pessoa.CNPJ_CPF.Insert(2, ".").Insert(6, ".").Insert(10, "/").Insert(15, "-");
                }

                if (pessoa.complemento != "")
                {
                    pessoa.complemento = ", " + pessoa.complemento;
                }

                pessoa.Logradouro = pessoa.Logradouro + ", " + pessoa.numero + pessoa.complemento;

                string localizacao = pessoa.Bairro + ", " + pessoa.Cidade + ", " + pessoa.UF;
                string contatos = pessoa.telefone.Insert(0, "(").Insert(3, ")").Insert(8, "-") + " / " + pessoa.celular.Insert(0, "(").Insert(3, ")").Insert(9, "-");

                var newObj = new
                {
                    id = pessoa.id,
                    Nome_razao_social = pessoa.Nome_razao_social,
                    CNPJ_CPF = pessoa.CNPJ_CPF,
                    dt_nascimento = pessoa.dt_nascimento.ToString("dd/MM/yyyy"),
                    CEP = pessoa.CEP.Insert(5, "-"),
                    Logradouro = pessoa.Logradouro,
                    localizacao = localizacao,
                    contatos = contatos,
                    email = pessoa.email,
                    flag_pessoa = pessoa.flag_pessoa
                };

                list.Add(newObj);
            }

            var result = JsonConvert.SerializeObject(list);
            return result;
        }

        protected void btnInserir_Click(object sender, EventArgs e)
        {

        }

        protected void btnAlterar_Click(object sender, EventArgs e)
        {

        }

        protected void btnDeletar_Click(object sender, EventArgs e)
        {
            PessoaDAL pDal = new PessoaDAL();
            hfpessoas.Value = hfpessoas.Value.Replace("-", ",");
            pDal.Delete(hfpessoas.Value);
            Response.Redirect(ResolveUrl("CadPessoa.aspx"));
        }

        [WebMethod]
        public static Boolean validarCPFCNPJ(string CNPJ_CPF)
        {
            PessoaDAL pDAL = new PessoaDAL();
            Boolean validar = pDAL.validarCPFCNPJ(CNPJ_CPF);
            return validar;
        }

    }
}