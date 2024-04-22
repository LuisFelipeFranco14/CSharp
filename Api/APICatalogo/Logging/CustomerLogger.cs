using System.IO;
using static NuGet.Packaging.PackagingConstants;

namespace APICatalogo.Logging
{
    public class CustomerLogger : ILogger
    {
        readonly string loggerName;
        readonly CustomLoggerProviderConfiguration loggerConfig;

        public CustomerLogger(string loggerName, CustomLoggerProviderConfiguration loggerConfig)
        {
            this.loggerName = loggerName;
            this.loggerConfig = loggerConfig;
        }

        public IDisposable BeginScope<TState>(TState state) 
        {
            return null;
        }

        public bool IsEnabled(LogLevel logLevel)
        {
            return logLevel == loggerConfig.LogLevel;
        }

        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state,
            Exception exception, Func<TState, Exception, string> formatter)
        {
            string mensagem = $"{logLevel.ToString()}: {eventId.Id} - {formatter(state, exception)}";

            EscreverTextoNoArquivo(mensagem);
        }

        //têm que criar o local para o arquivo.
        private void EscreverTextoNoArquivo(string mensagem)
        {
            string path = @"c:\dados\log\";
            string name = "Log.txt";
            bool fileExist = File.Exists(path + name);
            if (!fileExist) 
            {
                Directory.CreateDirectory(path);
                File.Create(name).Close();  
            } 

            using (StreamWriter streamWriter = new StreamWriter(path+ name, true))
            {
                try
                {
                    streamWriter.WriteLine(mensagem);
                    streamWriter.Close();
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }

    }
}
