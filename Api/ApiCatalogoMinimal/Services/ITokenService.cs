using ApiCatalogoMinimal.Models;

namespace ApiCatalogoMinimal.Services;

public interface ITokenService
{
    string GetToken(string key, string issuer, string audience, UserModel user);
}
