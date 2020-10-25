using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class SecaoDAL : Conexao
    {
        public void Insert(Secao s)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbsecao (descricao_sem_caracter, descricao_com_caracter, icon) values (@descricao_sem_caracter, @descricao_com_caracter, @icon)", Con);
                Cmd.Parameters.AddWithValue("@descricao_sem_caracter", s.descricao_sem_caracter);
                Cmd.Parameters.AddWithValue("@descricao_com_caracter", s.descricao_com_caracter);
                Cmd.Parameters.AddWithValue("@icon", s.icon);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir a Seção: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void Update(Secao s)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbsecao set descricao_sem_caracter=@descricao_sem_caracter, descricao_com_caracter=@descricao_com_caracter, icon=@icon where id=@id", Con);
                Cmd.Parameters.AddWithValue("@descricao_sem_caracter", s.descricao_sem_caracter);
                Cmd.Parameters.AddWithValue("@descricao_com_caracter", s.descricao_com_caracter);
                Cmd.Parameters.AddWithValue("@icon", s.icon);
                Cmd.Parameters.AddWithValue("@id", s.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar a Seção: " + ex.Message);
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
                Cmd = new MySqlCommand("delete from tbsecao where id=@id", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir a Seção: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void DeleteModulos(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("delete from tbmodulo where id_secao_fk=@id_secao_fk", Con);
                Cmd.Parameters.AddWithValue("@id_secao_fk", id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir a Seção: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public Secao GetId(int id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbsecao where id=@id ", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Dr = Cmd.ExecuteReader();

                Secao s = null;

                if (Dr.Read())
                {
                    s = new Secao();
                    s.id = Convert.ToInt32(Dr["id"]);
                    s.descricao_sem_caracter = Convert.ToString(Dr["descricao_sem_caracter"]);
                    s.descricao_com_caracter = Convert.ToString(Dr["descricao_com_caracter"]);
                    s.icon = Convert.ToString(Dr["icon"]);
                }

                return s;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar a Seção: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Secao> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbsecao", Con);
                Dr = Cmd.ExecuteReader();

                List<Secao> ListaSecao = new List<Secao>();

                while (Dr.Read())
                {
                    Secao s = new Secao();
                    s.id = Convert.ToInt32(Dr["id"]);
                    s.descricao_sem_caracter = Convert.ToString(Dr["descricao_sem_caracter"]);
                    s.descricao_com_caracter = Convert.ToString(Dr["descricao_com_caracter"]);
                    s.icon = Convert.ToString(Dr["icon"]);
                    ListaSecao.Add(s);
                }

                return ListaSecao;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Seções: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Secao> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbsecao where id in (" + id + ")", Con);
                Dr = Cmd.ExecuteReader();

                List<Secao> ListaSecao = new List<Secao>();

                while (Dr.Read())
                {
                    Secao s = new Secao();
                    s.id = Convert.ToInt32(Dr["id"]);
                    s.descricao_sem_caracter = Convert.ToString(Dr["descricao_sem_caracter"]);
                    s.descricao_com_caracter = Convert.ToString(Dr["descricao_com_caracter"]);
                    s.icon = Convert.ToString(Dr["icon"]);
                    ListaSecao.Add(s);
                }

                return ListaSecao;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Seções: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

    }
}
