using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Model
{
    public class Modulo
    {
        public int id { get; set; }
        public string descr_modulo { get; set; }
        public string caminho { get; set; }
        public int id_grupo_usuario_fk { get; set; }
        public int id_secao_fk { get; set; }
    }
}
