﻿using System.Text.Json.Serialization;

namespace ApiCatalogoMinimal.Models
{
    public class Categoria
    {
        [JsonIgnore]
        public int CategoriaId { get; set; }
        public string? Nome { get; set; }
        public string? Descricao { get; set; }
        [JsonIgnore]
        public ICollection<Produto>? Produtos { get; set; }
    }
}