namespace DAL.Model
{
    public class Usuario
    {
        public int id { get; set; }
        public string login { get; set; }
        public string senha { get; set; }
        public int id_grupo_usuario_fk { get; set; }

        public string flg_ativo { get; set; }

    }
}
