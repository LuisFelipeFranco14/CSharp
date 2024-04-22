using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Persistence
{
    public class Conexao
    {
        protected MySqlConnection Con;
        protected MySqlCommand  Cmd;
        protected MySqlDataReader Dr;

        protected void AbrirConexao()
        {
            try
            {
                Con = new MySqlConnection();
                Con.ConnectionString = "Server=localhost;Database=adaptus;uid=Adaptus;password=@macaco29;";
                Con.Open();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        protected void FecharConexao()
        {
            try
            {
                Con.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


    }
}
