using System;

namespace DAL.Model
{
    public class Pessoa
    {
        public int id { get; set; }
        public string Nome_razao_social { get; set; }
        public string Nome_fantasia { get; set; }
        public string CNPJ_CPF { get; set; }
        public string inscricao_estadual { get; set; }
        public DateTime dt_nascimento { get; set; }
        public string CEP { get; set; }
        public string Logradouro { get; set; }
        public string Bairro { get; set; }
        public string Cidade { get; set; }
        public string UF { get; set; }
        public int numero { get; set; }
        public string complemento { get; set; }
        public string telefone { get; set; }
        public string celular { get; set; }
        public string email { get; set; }
        public string flag_pessoa { get; set; }
    }
}
