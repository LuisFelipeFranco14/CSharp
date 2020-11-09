using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class EmpresaDAL : Conexao
    {
        public void Insert(Empresa e)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbempresa (id_pessoa_fk) values (@id_pessoa_fk)", Con);
                Cmd.Parameters.AddWithValue("@id_pessoa_fk", e.id_pessoa_fk);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir a Empresa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void Update(Empresa e)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbempresa set id_pessoa_fk=@id_pessoa_fk where id=@id", Con);
                Cmd.Parameters.AddWithValue("@id_pessoa_fk", e.id_pessoa_fk);
                Cmd.Parameters.AddWithValue("@id", e.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar a Empresa: " + ex.Message);
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
                Cmd = new MySqlCommand("delete from tbempresa where in (" + id + ")", Con);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir a Empresa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public Empresa GetId(int id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbempresa where id=@id ", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Dr = Cmd.ExecuteReader();

                Empresa e = null;

                if (Dr.Read())
                {
                    e = new Empresa();
                    e.id = Convert.ToInt32(Dr["id"]);
                    e.id_pessoa_fk = Convert.ToInt32(Dr["id_pessoa_fk"]);
                }

                return e;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar a Empresa: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Empresa> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbempresa", Con);
                Dr = Cmd.ExecuteReader();

                List<Empresa> ListaEmpresa = new List<Empresa>();

                while (Dr.Read())
                {
                    Empresa e = new Empresa();
                    e.id = Convert.ToInt32(Dr["id"]);
                    e.id_pessoa_fk = Convert.ToInt32(Dr["id_pessoa_fk"]);
                    ListaEmpresa.Add(e);
                }

                return ListaEmpresa;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Empresas: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Empresa> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbempresa id in (" + id + ")", Con);
                Dr = Cmd.ExecuteReader();

                List<Empresa> ListaEmpresa = new List<Empresa>();

                while (Dr.Read())
                {
                    Empresa e = new Empresa();
                    e.id = Convert.ToInt32(Dr["id"]);
                    e.id_pessoa_fk = Convert.ToInt32(Dr["id_pessoa_fk"]);
                    ListaEmpresa.Add(e);
                }

                return ListaEmpresa;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar as Empresas: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }


    }
}
