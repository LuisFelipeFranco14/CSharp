using ApiCatalogoMinimal.ApiEndpoints;
using ApiCatalogoMinimal.ApiServicesExtensions;
using ApiCatalogoMinimal.Context;
using ApiCatalogoMinimal.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.//ConfigureServices
builder.AddApiSwagger();
builder.AddPersistnce();
builder.Services.AddCors();
builder.AddAutenticationJwt();

var app = builder.Build();

//endpoint para login
app.MapAutenticacaoEndpoints();

//definir os endpoints
//app.MapGet("/", () => "Catálogo de Produtos - 2023").ExcludeFromDescription();

//------------------------endpoints para Categoria ---------------------------------
app.MapCategoriasEndpoints();
//------------------------endpoints para Produto ---------------------------------
app.MapProdutosEndpoints();

// Configure the HTTP request pipeline.//Configure
var environment = app.Environment;
app.UseExceptionHandling(environment).UseSwaggerMiddleware().UseAppCors();

app.UseAuthentication();
app.UseAuthorization();

app.Run();

