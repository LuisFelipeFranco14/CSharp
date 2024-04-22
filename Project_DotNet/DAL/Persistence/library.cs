using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Mail;
using DAL.Model;
using MySql.Data.MySqlClient;

namespace DAL.Persistence
{
    public class library : Conexao
    {
        public static Boolean EnviaEmail(string assunto, string conteudo, List<string> emails)
        {
            MailMessage message = new MailMessage();
            string remetenteEmail = ConfigurationManager.AppSettings["emailRemetente"].ToString();
            string senhaEmail = ConfigurationManager.AppSettings["passwordRemetente"].ToString();

            foreach (string em in emails)
            {
                message.To.Add(em);
            }

            message.From = new MailAddress(remetenteEmail, "ABCB Senepol", System.Text.Encoding.UTF8);
            message.Subject = assunto;
            message.IsBodyHtml = true;
            message.Priority = System.Net.Mail.MailPriority.High;
            message.Body = conteudo;
            message.SubjectEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1");
            message.BodyEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1");

            SmtpClient smtpClient = new SmtpClient();
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new System.Net.NetworkCredential(remetenteEmail, senhaEmail);
            smtpClient.Port = Convert.ToInt32(ConfigurationManager.AppSettings["portRemetente"]);

            if (smtpClient.Host == null)
            {
                smtpClient.Host = ConfigurationManager.AppSettings["smtpRemetente"].ToString();
            }

            smtpClient.EnableSsl = Convert.ToBoolean(ConfigurationManager.AppSettings["SSL"].ToString());
            bool sucesso = false;
            int cont = 0;

            while (sucesso == false && cont < 10)
            {
                cont = cont + 1;
                try
                {
                    smtpClient.Send(message);
                    sucesso = true;
                }
                catch (Exception ex)
                {
                    sucesso = false;
                    Console.WriteLine("Inner Exception:  - Message: " + ex.Message.ToString());
                }
            }
            return sucesso;
        }
    }
}
