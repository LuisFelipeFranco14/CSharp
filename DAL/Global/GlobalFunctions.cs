using System;
using System.Collections.Generic;

namespace DAL.Global
{
    public class GlobalFunctions
    {
        public string fexpression;
        public void InicialUpperRestLowerString(string Aexpression)
        {
            fexpression = Aexpression;
            if (Aexpression.Length > 1) {
                string xInicial = Aexpression.Substring(0, 1).ToUpper();
                string xrest = Aexpression.Substring(1, Aexpression.Length - 1).ToLower();
                fexpression = xInicial + xrest;
            }
        }
    }
}
