using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class PessoaDAL : Conexao
    {
        public void Insert(Pessoa p)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbpessoa (Nome_razao_social, Nome_fantasia, CNPJ_CPF, inscricao_estadual, " +
                                       "dt_nascimento, CEP, Logradouro, Bairro, Cidade, UF, numero, complemento, telefone, celular, email, flag_pessoa)" +
                                       "values (@Nome_razao_social,@Nome_fantasia,@CNPJ_CPF,@inscricao_estadual," +
                                       "@dt_nascimento,@CEP,@Logradouro,@Bairro,@Cidade,@UF,@numero,@complemento,@telefone,@celular," +
                                       "@email,@flag_pessoa)", Con);

                Cmd.Parameters.AddWithValue("@Nome_razao_social", p.Nome_razao_social);
                Cmd.Parameters.AddWithValue("@Nome_fantasia", p.Nome_fantasia);
                Cmd.Parameters.AddWithValue("@CNPJ_CPF", p.CNPJ_CPF);
                Cmd.Parameters.AddWithValue("@inscricao_estadual", p.inscricao_estadual);
                Cmd.Parameters.AddWithValue("@dt_nascimento", p.dt_nascimento);
                Cmd.Parameters.AddWithValue("@CEP", p.CEP);
                Cmd.Parameters.AddWithValue("@Logradouro", p.Logradouro);
                Cmd.Parameters.AddWithValue("@Bairro", p.Bairro);
                Cmd.Parameters.AddWithValue("@Cidade", p.Cidade);
                Cmd.Parameters.AddWithValue("@UF", p.UF);
                Cmd.Parameters.AddWithValue("@numero", p.numero);
                Cmd.Parameters.AddWithValue("@complemento", p.complemento);
                Cmd.Parameters.AddWithValue("@telefone", p.telefone);
                Cmd.Parameters.AddWithValue("@celular", p.celular);
                Cmd.Parameters.AddWithValue("@email", p.email);
                Cmd.Parameters.AddWithValue("@flag_pessoa", p.flag_pessoa);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir a Pessoa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public void Update(Pessoa p)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbpessoa set Nome_razao_social=@Nome_razao_social, " +
                                       "Nome_fantasia=@Nome_fantasia, " +
                                       "CNPJ_CPF=@CNPJ_CPF, " +
                                       "inscricao_estadual=@inscricao_estadual, " +
                                       "dt_nascimento=@dt_nascimento, " +
                                       "CEP=@CEP, " +
                                       "Logradouro=@Logradouro, " +
                                       "Bairro=@Bairro, " +
                                       "Cidade=@Cidade, " +
                                       "UF=@UF, " +
                                       "numero=@numero, " +
                                       "complemento=@complemento, " +
                                       "telefone=@telefone, " +
                                       "celular=@celular, " +
                                       "email=@email, " +
                                       "flag_pessoa=@flag_pessoa " +
                                       "where id=@id", Con);
                Cmd.Parameters.AddWithValue("@Nome_razao_social", p.Nome_razao_social);
                Cmd.Parameters.AddWithValue("@Nome_fantasia", p.Nome_fantasia);
                Cmd.Parameters.AddWithValue("@CNPJ_CPF", p.CNPJ_CPF);
                Cmd.Parameters.AddWithValue("@inscricao_estadual", p.inscricao_estadual);
                Cmd.Parameters.AddWithValue("@dt_nascimento", p.dt_nascimento);
                Cmd.Parameters.AddWithValue("@CEP", p.CEP);
                Cmd.Parameters.AddWithValue("@Logradouro", p.Logradouro);
                Cmd.Parameters.AddWithValue("@Bairro", p.Bairro);
                Cmd.Parameters.AddWithValue("@Cidade", p.Cidade);
                Cmd.Parameters.AddWithValue("@UF", p.UF);
                Cmd.Parameters.AddWithValue("@numero", p.numero);
                Cmd.Parameters.AddWithValue("@complemento", p.complemento);
                Cmd.Parameters.AddWithValue("@telefone", p.telefone);
                Cmd.Parameters.AddWithValue("@celular", p.celular);
                Cmd.Parameters.AddWithValue("@email", p.email);
                Cmd.Parameters.AddWithValue("@flag_pessoa", p.flag_pessoa);
                Cmd.Parameters.AddWithValue("@id", p.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar a Pessoa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public void Delete(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("delete from tbpessoa where id in ("+id+")", Con);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir a Pessoa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public Pessoa GetId(int id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbpessoa where id=@id", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Dr = Cmd.ExecuteReader();

                Pessoa p_temp = null;

                if (Dr.Read())
                {
                    p_temp = new Pessoa();
                    p_temp.id = Convert.ToInt32(Dr["id"]);
                    p_temp.Nome_razao_social = Convert.ToString(Dr["Nome_razao_social"]);
                    p_temp.Nome_fantasia = Convert.ToString(Dr["Nome_fantasia"]);
                    p_temp.CNPJ_CPF = Convert.ToString(Dr["CNPJ_CPF"]);
                    p_temp.inscricao_estadual = Convert.ToString(Dr["inscricao_estadual"]);
                    p_temp.dt_nascimento = Convert.ToDateTime(Dr["dt_nascimento"]);
                    p_temp.CEP = Convert.ToString(Dr["CEP"]);
                    p_temp.Logradouro = Convert.ToString(Dr["Logradouro"]);
                    p_temp.Bairro = Convert.ToString(Dr["Bairro"]);
                    p_temp.Cidade = Convert.ToString(Dr["Cidade"]);
                    p_temp.UF = Convert.ToString(Dr["UF"]);
                    p_temp.numero = Convert.ToInt32(Dr["numero"]);
                    p_temp.complemento = Convert.ToString(Dr["complemento"]);
                    p_temp.telefone = Convert.ToString(Dr["telefone"]);
                    p_temp.celular = Convert.ToString(Dr["celular"]);
                    p_temp.email = Convert.ToString(Dr["email"]);
                    p_temp.flag_pessoa = Convert.ToString(Dr["flag_pessoa"]);
                }

                return p_temp;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar a Pessoa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public List<Pessoa> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbpessoa", Con);
                Dr = Cmd.ExecuteReader();

                List<Pessoa> ListaPessoa = new List<Pessoa>();

                while (Dr.Read())
                {
                    Pessoa p_temp = new Pessoa();
                    p_temp.id = Convert.ToInt32(Dr["id"]);
                    p_temp.Nome_razao_social = Convert.ToString(Dr["Nome_razao_social"]);
                    p_temp.Nome_fantasia = Convert.ToString(Dr["Nome_fantasia"]);
                    p_temp.CNPJ_CPF = Convert.ToString(Dr["CNPJ_CPF"]);
                    p_temp.inscricao_estadual = Convert.ToString(Dr["inscricao_estadual"]);
                    p_temp.dt_nascimento = Convert.ToDateTime(Dr["dt_nascimento"]);
                    p_temp.CEP = Convert.ToString(Dr["CEP"]);
                    p_temp.Logradouro = Convert.ToString(Dr["Logradouro"]);
                    p_temp.Bairro = Convert.ToString(Dr["Bairro"]);
                    p_temp.Cidade = Convert.ToString(Dr["Cidade"]);
                    p_temp.UF = Convert.ToString(Dr["UF"]);
                    p_temp.numero = Convert.ToInt32(Dr["numero"]);
                    p_temp.complemento = Convert.ToString(Dr["complemento"]);
                    p_temp.telefone = Convert.ToString(Dr["telefone"]);
                    p_temp.celular = Convert.ToString(Dr["celular"]);
                    p_temp.email = Convert.ToString(Dr["email"]);
                    p_temp.flag_pessoa = Convert.ToString(Dr["flag_pessoa"]);
                    ListaPessoa.Add(p_temp);
                }

                return ListaPessoa;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Pessoas: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Pessoa> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbpessoa where id in ("+ id +")", Con);
                Dr = Cmd.ExecuteReader();

                List<Pessoa> ListaPessoa = new List<Pessoa>();

                while (Dr.Read())
                {
                    Pessoa p_temp = new Pessoa();
                    p_temp.id = Convert.ToInt32(Dr["id"]);
                    p_temp.Nome_razao_social = Convert.ToString(Dr["Nome_razao_social"]);
                    p_temp.Nome_fantasia = Convert.ToString(Dr["Nome_fantasia"]);
                    p_temp.CNPJ_CPF = Convert.ToString(Dr["CNPJ_CPF"]);
                    p_temp.inscricao_estadual = Convert.ToString(Dr["inscricao_estadual"]);
                    p_temp.dt_nascimento = Convert.ToDateTime(Dr["dt_nascimento"]);
                    p_temp.CEP = Convert.ToString(Dr["CEP"]);
                    p_temp.Logradouro = Convert.ToString(Dr["Logradouro"]);
                    p_temp.Bairro = Convert.ToString(Dr["Bairro"]);
                    p_temp.Cidade = Convert.ToString(Dr["Cidade"]);
                    p_temp.UF = Convert.ToString(Dr["UF"]);
                    p_temp.numero = Convert.ToInt32(Dr["numero"]);
                    p_temp.complemento = Convert.ToString(Dr["complemento"]);
                    p_temp.telefone = Convert.ToString(Dr["telefone"]);
                    p_temp.celular = Convert.ToString(Dr["celular"]);
                    p_temp.email = Convert.ToString(Dr["email"]);
                    p_temp.flag_pessoa = Convert.ToString(Dr["flag_pessoa"]);
                    ListaPessoa.Add(p_temp);
                }

                return ListaPessoa;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Pessoas: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }


        public Boolean validarCPFCNPJ(string CNPJ_CPF)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbpessoa where CNPJ_CPF=" + CNPJ_CPF +"", Con);
                Dr = Cmd.ExecuteReader();

                Boolean validar = false;
                if (Dr.Read())
                {
                    validar = true;
                }

                return validar;

            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Pessoas: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

    }
}

