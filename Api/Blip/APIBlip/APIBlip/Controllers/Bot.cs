using Git;
using Lime.Protocol;
using Lime.Protocol.Serialization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RestSharp;
using System.Net;
using System.Text.Json.Nodes;

namespace Bot_HTTP.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Bot : ControllerBase
    {
        private readonly IEnvelopeSerializer _env;
        private readonly IConfiguration _config;
        public List<Repos> _repos;
        public string _BlipJson;

        public Bot(IConfiguration config, IEnvelopeSerializer envelopeSerializer)
        {
            _config = config;
            _env = envelopeSerializer;
            _repos = GetRepos();
            _BlipJson = GetJsonBlip();
        }

        [HttpPost("ChatBlip")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> SendMessage([FromBody] object value)

        {
            if (_BlipJson == "")
                return NotFound("Por favor Insira o Json da Blip..");

            if (_repos.Count == 0)
                return NotFound("Por favor Insira os repósitorios do GitHub em relação a Blip..");

            var msgbody = value.ToString();

            var msg = _env.Deserialize(msgbody) as Message;

            if (msg.Type == "text/plain")
            {
                var id = Guid.NewGuid();
                _BlipJson = _BlipJson.Replace("%id%", id.ToString());
                _BlipJson = _BlipJson.Replace("%message%", msg.From.ToIdentity());

                var client = new RestClient(_config.GetValue<string>("UrlBase"));
                var request = new RestRequest("/messages", Method.Post);

                request.AddHeader("Content-Type", "application/json");
                request.AddHeader("Authorization", _config.GetValue<string>("AutoriaztionKey"));
                request.AddParameter("application/json", _BlipJson, ParameterType.RequestBody);
                var response = client.ExecutePost(request);
                Console.WriteLine(response.Content);
                return Accepted();
            }
            return Accepted();

        }

        private string? GetJsonBlip()
        {
            Console.WriteLine("Carregar Json....");

            string Diretorio = AppDomain.CurrentDomain.BaseDirectory;
            Diretorio = Diretorio.Replace(@"\APIBlip\APIBlip\bin\Debug\net7.0\", @"\") + @"Flow\" + @"apibliplf.json";
            StreamReader r = new StreamReader(Diretorio);
            var jsonObject = JsonConvert.DeserializeObject(r.ReadToEnd());
            string _BlipJson = jsonObject.ToString() + "*";
            _BlipJson = _BlipJson.Replace("\"flow\"", "\"id\": " + "%id%" + ", \"type\": \"text/plain\",  \"flow\"");
            _BlipJson = _BlipJson.Replace("}*", ", \"to\": " + "%message%" + ", }");
            Console.WriteLine("Json Inserido....");

            return _BlipJson;
        }

        private List<Repos>? GetRepos()
        {
            Console.WriteLine("Entrar na Api GitHub");
            var requisicaoWeb = WebRequest.CreateHttp("https://api.github.com/users/takenet/repos");
            requisicaoWeb.Method = "GET";
            requisicaoWeb.UserAgent = "RequisicaoWebDemo";
            List<Repos> _repos = new List<Repos>();

            using (var resposta = requisicaoWeb.GetResponse())
            {
                var streamDados = resposta.GetResponseStream();
                StreamReader reader = new StreamReader(streamDados);
                string objResponse = "{ \"items\": " + reader.ReadToEnd() + " }";
                JsonNode jsonObject = JsonNode.Parse(objResponse.ToString());
                JsonNode root = jsonObject.Root;
                JsonArray reposArray = root["items"]!.AsArray();

                //List<Repos> repos = JsonConvert.DeserializeObject<List<Repos>>((string)reposArray);
                //List<Repos> repos = JsonSerializer.Deserialize<List<Repos>>(jsonObject.ToJsonString());
                //Console.WriteLine(reposArray.Count);

                foreach (JsonNode? repo in reposArray)
                {
                    Repos reposLinha = new Repos();
                    if (repo?["id"] is JsonNode idNode) reposLinha.Id = (long)idNode;
                    if (repo?["node_id"] is JsonNode node_idNode) reposLinha.NodeId = (string)node_idNode;
                    if (repo?["name"] is JsonNode nameNode) reposLinha.Name = (string)nameNode;
                    if (repo?["full_name"] is JsonNode full_nameNode) reposLinha.FullName = (string)full_nameNode;
                    if (repo?["private"] is JsonNode privateNode) reposLinha.Private = (bool)privateNode;
                    if (repo?["html_url"] is JsonNode html_urlNode) reposLinha.HtmlUrl = (string)html_urlNode;
                    if (repo?["description"] is JsonNode descriptionNode) reposLinha.Description = (string)descriptionNode;

                    _repos.Add(reposLinha);
                }

                streamDados.Close();
                resposta.Close();
                Console.WriteLine("Cadastro de repósitorios feito com sucesso!");
                Console.WriteLine(_repos.Count);
            }
            return _repos;
        }

    }
}