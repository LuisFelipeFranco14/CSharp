using System;
using System.Collections.Generic;
using DAL.Model;
using DAL.Persistence;
using System.Web.Services;
using System.Linq;
using System.Web;
using System.Net;
using System.Web.Script.Serialization;
using System.Web.Script.Services;

namespace Web.Servicos
{
    /// <summary>
    /// Descrição resumida de FiltroPessoa
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que esse serviço da web seja chamado a partir do script, usando ASP.NET AJAX, remova os comentários da linha a seguir. 
    [System.Web.Script.Services.ScriptService]
    public class FiltroPessoa : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Olá, Mundo";
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string FiltroPessoaJuridica(string Razoasocial = "", string NomeFantasia = "", string CNPJ = "")
        {
            List<object> objpessoa = new List<object>();
            PessoaDAL pDal = new PessoaDAL();
            List<Pessoa> ListPessoa = pDal.GetALLPessoaJuridica(Razoasocial, NomeFantasia, CNPJ);

            foreach (Pessoa p in ListPessoa)
            {
                p.CNPJ_CPF = p.CNPJ_CPF.Insert(9, "-").Insert(6, ".").Insert(3, ".");
                p.telefone = p.telefone.Insert(0, "(").Insert(3, ")").Insert(8, "-");
                p.celular = p.celular.Insert(0, "(").Insert(3, ")").Insert(9, "-");

                if (p.complemento != "")
                {
                    p.complemento = ", " + p.complemento;
                }

                var Listpessoa = new
                {
                    Nome_razao_social = p.Nome_razao_social,
                    Nome_fantasia = p.Nome_fantasia,
                    CNPJ_CPF = p.CNPJ_CPF,
                    inscricao_estadual = p.inscricao_estadual,
                    dt_nascimento = p.dt_nascimento.ToString("yyyy-MM-dd"),
                    CEP = p.CEP.Insert(5, "-"),
                    Logradouro = p.Logradouro,
                    Bairro = p.Bairro,
                    Cidade = p.Cidade,
                    UF = p.UF,
                    numero = p.numero,
                    complemento = p.complemento,
                    telefone = p.telefone,
                    celular = p.celular,
                    email = p.email,
                    flag_pessoa = p.flag_pessoa,
                    endereco = p.Logradouro +", "+p.numero+p.complemento,
                    id = p.id
                };
                objpessoa.Add(Listpessoa);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();

            return js.Serialize(objpessoa);
        }

    }
}
