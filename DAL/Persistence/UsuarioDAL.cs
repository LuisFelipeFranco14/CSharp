using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class UsuarioDAL : Conexao
    {
        public void Insert(Usuario u)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbusuario (login, senha, id_grupo_usuario_fk, flg_ativo) values (@login, MD5(@senha), @id_grupo_usuario_fk, @flg_ativo)", Con);
                Cmd.Parameters.AddWithValue("@login", u.login);
                Cmd.Parameters.AddWithValue("@senha", u.senha);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", u.id_grupo_usuario_fk);
                Cmd.Parameters.AddWithValue("@flg_ativo", u.flg_ativo);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir o Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public void Update(Usuario u)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbusuario set login=@login, senha=MD5(@senha), id_grupo_usuario_fk=@id_grupo_usuario_fk, flg_ativo=@flg_ativo where id=@id", Con);
                Cmd.Parameters.AddWithValue("@login", u.login);
                Cmd.Parameters.AddWithValue("@senha", u.senha);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", u.id_grupo_usuario_fk);
                Cmd.Parameters.AddWithValue("@flg_ativo", u.flg_ativo);
                Cmd.Parameters.AddWithValue("@id", u.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar o Usuário: " + ex.Message);
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
                Cmd = new MySqlCommand("delete from tbusuario where in (" + id + ")", Con);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir o Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public Usuario GetUsuarioSenha(string login, string senha)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbusuario where login=@login and senha = MD5(@senha)", Con);
                Cmd.Parameters.AddWithValue("@login", login);
                Cmd.Parameters.AddWithValue("@senha", senha);
                Dr = Cmd.ExecuteReader();

                Usuario u = null;

                if (Dr.Read())
                {
                    u = new Usuario();
                    u.id = Convert.ToInt32(Dr["id"]);
                    u.login = Convert.ToString(Dr["login"]);
                    u.senha = Convert.ToString(Dr["senha"]);
                    u.flg_ativo = Convert.ToString(Dr["flg_ativo"]);
                    u.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                }

                return u;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar o Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }
        public List<Usuario> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbusuario ", Con);
                Dr = Cmd.ExecuteReader();

                List<Usuario> ListaUsuario = new List<Usuario>();

                while (Dr.Read())
                {
                    Usuario u = new Usuario();
                    u.id = Convert.ToInt32(Dr["id"]);
                    u.login = Convert.ToString(Dr["login"]);
                    u.senha = Convert.ToString(Dr["senha"]);
                    u.flg_ativo = Convert.ToString(Dr["flg_ativo"]);
                    u.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                    ListaUsuario.Add(u);
                }

                return ListaUsuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Usuários: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public Usuario getId(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbusuario where id =" + id + "", Con);
                Dr = Cmd.ExecuteReader();

                Usuario u = new Usuario();
                if (Dr.Read())
                {
                    
                    u.id = Convert.ToInt32(Dr["id"]);
                    u.login = Convert.ToString(Dr["login"]);
                    u.senha = Convert.ToString(Dr["senha"]);
                    u.flg_ativo = Convert.ToString(Dr["flg_ativo"]);
                    u.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                }

                return u;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Usuários: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Usuario> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbusuario where id in (" + id + ")", Con);
                Dr = Cmd.ExecuteReader();

                List<Usuario> ListaUsuario = new List<Usuario>();

                while (Dr.Read())
                {
                    Usuario u = new Usuario();
                    u.id = Convert.ToInt32(Dr["id"]);
                    u.login = Convert.ToString(Dr["login"]);
                    u.senha = Convert.ToString(Dr["senha"]);
                    u.flg_ativo = Convert.ToString(Dr["flg_ativo"]);
                    u.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                    ListaUsuario.Add(u);
                }

                return ListaUsuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Usuários: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public Usuario GetLogin(string login)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbusuario where login=@login", Con);
                Cmd.Parameters.AddWithValue("@login", login);
                Dr = Cmd.ExecuteReader();

                Usuario u = null;

                if (Dr.Read())
                {
                    u = new Usuario();
                    u.id = Convert.ToInt32(Dr["id"]);
                    u.login = Convert.ToString(Dr["login"]);
                    u.senha = Convert.ToString(Dr["senha"]);
                    u.flg_ativo = Convert.ToString(Dr["flg_ativo"]);
                    u.id_grupo_usuario_fk = Convert.ToInt32(Dr["id_grupo_usuario_fk"]);
                }

                return u;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar o Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

    }
}
