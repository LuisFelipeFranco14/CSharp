using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class ParametroDAL : Conexao
    {
        public void Insert(Parametro p)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbparametro (flg_acesso_desenvolvimento, desc_parametro) values (@flg_acesso_desenvolvimento, @desc_parametro)", Con);
                Cmd.Parameters.AddWithValue("@flg_acesso_desenvolvimento", p.flg_acesso_desenvolvimento);
                Cmd.Parameters.AddWithValue("@desc_parametro", p.desc_parametro);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir o Parametro: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public void Update(Parametro p)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbparametro set flg_acesso_desenvolvimento=@flg_acesso_desenvolvimento, desc_parametro=@desc_parametro where id=@id", Con);
                Cmd.Parameters.AddWithValue("@flg_acesso_desenvolvimento", p.flg_acesso_desenvolvimento);
                Cmd.Parameters.AddWithValue("@desc_parametro", p.desc_parametro);
                Cmd.Parameters.AddWithValue("@id", p.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar o Parametro: " + ex.Message);
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
                Cmd = new MySqlCommand("delete from tbparametro where id=@id", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir o Parametro: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public Parametro GetId(int id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbparametro where id=@id", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Dr = Cmd.ExecuteReader();

                Parametro p_temp = null;

                if (Dr.Read())
                {
                    p_temp = new Parametro();
                    p_temp.id = Convert.ToInt32(Dr["id"]);
                    p_temp.flg_acesso_desenvolvimento = Convert.ToString(Dr["flg_acesso_desenvolvimento"]);
                    p_temp.desc_parametro = Convert.ToString(Dr["desc_parametro"]);
                }

                return p_temp;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar o Parametro: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public List<Parametro> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbparametro", Con);
                Dr = Cmd.ExecuteReader();

                List<Parametro> ListaParametro = new List<Parametro>();

                while (Dr.Read())
                {
                    Parametro p_temp = new Parametro();
                    p_temp = new Parametro();
                    p_temp.id = Convert.ToInt32(Dr["id"]);
                    p_temp.flg_acesso_desenvolvimento = Convert.ToString(Dr["flg_acesso_desenvolvimento"]);
                    p_temp.desc_parametro = Convert.ToString(Dr["desc_parametro"]);
                    ListaParametro.Add(p_temp);
                }

                return ListaParametro;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Parametros: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Parametro> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbparametro where id in (" + id + ")", Con);
                Dr = Cmd.ExecuteReader();

                List<Parametro> ListaParametro = new List<Parametro>();

                while (Dr.Read())
                {
                    Parametro p_temp = new Parametro();
                    p_temp = new Parametro();
                    p_temp.id = Convert.ToInt32(Dr["id"]);
                    p_temp.flg_acesso_desenvolvimento = Convert.ToString(Dr["flg_acesso_desenvolvimento"]);
                    p_temp.desc_parametro = Convert.ToString(Dr["desc_parametro"]);
                    ListaParametro.Add(p_temp);
                }

                return ListaParametro;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Parametros: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
    }
}
