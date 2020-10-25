using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class ModuloDAL : Conexao
    {
        public void Insert(Modulo m)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbmodulo (descr_modulo, caminho, id_grupo_usuario_fk, id_secao_fk) values (@descr_modulo, @caminho, @id_grupo_usuario_fk, @id_secao_fk)", Con);
                Cmd.Parameters.AddWithValue("@descr_modulo", m.descr_modulo);
                Cmd.Parameters.AddWithValue("@caminho", m.caminho);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", m.id_grupo_usuario_fk);
                Cmd.Parameters.AddWithValue("@id_secao_fk", m.id_secao_fk);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir o Modulo: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void Update(Modulo m)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbmodulo set descr_modulo=@descr_modulo, caminho=@caminho, id_grupo_usuario_fk=@id_grupo_usuario_fk, id_secao_fk=@id_secao_fk where id=@id", Con);
                Cmd.Parameters.AddWithValue("@descr_modulo", m.descr_modulo);
                Cmd.Parameters.AddWithValue("@caminho", m.caminho);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", m.id_grupo_usuario_fk);
                Cmd.Parameters.AddWithValue("@id_secao_fk", m.id_secao_fk);
                Cmd.Parameters.AddWithValue("@id", m.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar o Modulo: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void Delete(int id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("delete from tbmodulo where id=@id", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir o Modulo: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public Modulo GetId(int id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbmodulo where id=@id ", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Dr = Cmd.ExecuteReader();

                Modulo m = null;

                if (Dr.Read())
                {
                    m = new Modulo();
                    m.id = Convert.ToInt32(Dr["id"]);
                    m.descr_modulo = Convert.ToString(Dr["descr_modulo"]);
                    m.caminho = Convert.ToString(Dr["caminho"]);
                    m.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                    m.id_secao_fk = Convert.ToInt32(Dr["id_secao_fk"]);
                }

                return m;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar o Modulo: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Modulo> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbmodulo", Con);
                Dr = Cmd.ExecuteReader();

                List<Modulo> ListaModulo = new List<Modulo>();

                while (Dr.Read())
                {
                    Modulo m = new Modulo();
                    m.id = Convert.ToInt32(Dr["id"]);
                    m.descr_modulo = Convert.ToString(Dr["descr_modulo"]);
                    m.caminho = Convert.ToString(Dr["caminho"]);
                    m.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                    m.id_secao_fk = Convert.ToInt32(Dr["id_secao_fk"]);
                    ListaModulo.Add(m);
                }

                return ListaModulo;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Modulos: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Modulo> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbmodulo where id in (" + id + ")", Con);
                Dr = Cmd.ExecuteReader();

                List<Modulo> ListaModulo = new List<Modulo>();

                while (Dr.Read())
                {
                    Modulo m = new Modulo();
                    m.id = Convert.ToInt32(Dr["id"]);
                    m.descr_modulo = Convert.ToString(Dr["descr_modulo"]);
                    m.caminho = Convert.ToString(Dr["caminho"]);
                    m.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                    m.id_secao_fk = Convert.ToInt32(Dr["id_secao_fk"]);
                    ListaModulo.Add(m);
                }

                return ListaModulo;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Modulos: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Secao> SecaoGrupo(int id_usuario_grupo)
        {
            

            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select distinct s.descricao_com_caracter, s.descricao_sem_caracter, s.icon, s.id " +
                                       "from tbmodulo m " +
                                       "inner join tbsecao s on s.id = m.id_secao_fk " +
                                       "inner join tbgrupo_usuario u on u.id = m.id_grupo_usuario_fk " +
                                       "where m.id_grupo_usuario_fk=@id_grupo_usuario_fk order by s.descricao_sem_caracter ", Con);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", id_usuario_grupo);
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
                throw new Exception("Erro ao Buscar os Modulos: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            } 
        }

        public List<Modulo> SecaoModulo(int id_usuario_grupo, int id_secao_fk)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select m.descr_modulo, m.caminho, m.id_grupo_usuario_fk, m.id_secao_fk " +
                                       "from tbmodulo m " +
                                       "inner join tbsecao s on s.id = m.id_secao_fk " +
                                       "inner join tbgrupo_usuario u on u.id = m.id_grupo_usuario_fk " +
                                       "where m.id_grupo_usuario_fk=@id_grupo_usuario_fk and m.id_secao_fk=@id_secao_fk order by m.descr_modulo ", Con);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", id_usuario_grupo);
                Cmd.Parameters.AddWithValue("@id_secao_fk", id_secao_fk);
                Dr = Cmd.ExecuteReader();

                List<Modulo> ListaModulo = new List<Modulo>();

                while (Dr.Read())
                {
                    Modulo m = new Modulo();
                    m.descr_modulo = Convert.ToString(Dr["descr_modulo"]);
                    m.caminho = Convert.ToString(Dr["caminho"]);
                    m.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                    m.id_secao_fk = Convert.ToInt32(Dr["id_secao_fk"]);
                    ListaModulo.Add(m);
                }

                return ListaModulo;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Modulos: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
    }
}
