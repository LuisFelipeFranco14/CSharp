using System;
using System.Collections.Generic;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class Grupo_UsuarioDAL : Conexao
    {
        public void Insert(Grupo_Usuario gu)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("insert into tbgrupo_usuario (desc_grupo) values (@desc_grupo)", Con);
                Cmd.Parameters.AddWithValue("@desc_grupo", gu.desc_grupo);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Inserir o Grupo de Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void Update(Grupo_Usuario gu)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("update tbgrupo_usuario set desc_grupo=@desc_grupo where id=@id", Con);
                Cmd.Parameters.AddWithValue("@desc_grupo", gu.desc_grupo);
                Cmd.Parameters.AddWithValue("@id", gu.id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Alterar o Grupo de Usuário: " + ex.Message);
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
                Cmd = new MySqlCommand("delete from tbgrupo_usuario where in (" + id + ")", Con);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir o Grupo de Usuário: " + ex.Message);
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
                Cmd = new MySqlCommand("delete from tbmodulo where id_grupo_usuario_fk=@id_grupo_usuario_fk", Con);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir o Grupo de Usuário do módulo: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public void DeleteUsuarios(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("delete from tbusuario where id_grupo_usuario_fk=@id_grupo_usuario_fk", Con);
                Cmd.Parameters.AddWithValue("@id_grupo_usuario_fk", id);
                Cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Excluir o Grupo de Usuário do Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public Grupo_Usuario GetId(int id)
        { 
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbgrupo_usuario where id=@id ", Con);
                Cmd.Parameters.AddWithValue("@id", id);
                Dr = Cmd.ExecuteReader();

                Grupo_Usuario gu = null;

                if (Dr.Read())
                {
                    gu = new Grupo_Usuario();
                    gu.id = Convert.ToInt32(Dr["id"]);
                    gu.desc_grupo = Convert.ToString(Dr["desc_grupo"]);
                }

                return gu;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar o Grupo de Usuário: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Grupo_Usuario> GetALL()
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbgrupo_usuario", Con);
                Dr = Cmd.ExecuteReader();

                List<Grupo_Usuario> ListaGrupo_Usuario = new List<Grupo_Usuario>();

                while (Dr.Read())
                {
                    Grupo_Usuario gu = new Grupo_Usuario();
                    gu.id = Convert.ToInt32(Dr["id"]);
                    gu.desc_grupo = Convert.ToString(Dr["desc_grupo"]);
                    ListaGrupo_Usuario.Add(gu);
                }

                return ListaGrupo_Usuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Grupos de Usuários: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

        public List<Grupo_Usuario> relatorio(string id)
        {
            try
            {
                AbrirConexao();
                Cmd = new MySqlCommand("select * from tbgrupo_usuario where id in (" + id + ")", Con);
                Dr = Cmd.ExecuteReader();

                List<Grupo_Usuario> ListaGrupo_Usuario = new List<Grupo_Usuario>();

                while (Dr.Read())
                {
                    Grupo_Usuario gu = new Grupo_Usuario();
                    gu.id = Convert.ToInt32(Dr["id"]);
                    gu.desc_grupo = Convert.ToString(Dr["desc_grupo"]);
                    ListaGrupo_Usuario.Add(gu);
                }

                return ListaGrupo_Usuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao Buscar os Grupos de Usuários: " + ex.Message);
            }
            finally
            {
                FecharConexao();
            }
        }

    }
}
