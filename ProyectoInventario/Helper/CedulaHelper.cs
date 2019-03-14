using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Helper
{
    public class CedulaHelper
    {
        public static bool validarNumeroCedula(string cedula)
        {
            bool bandera = false;
            double isNumeric;
            var total = 0;
            const int tamanoLongitudCedula = 10;
            int[] coeficientesCedula = { 2, 1, 2, 1, 2, 1, 2, 1, 2 };
            const int numeroProvincias = 24;
            const int tercerDigito = 6;

            try
            {


                if (double.TryParse(cedula, out isNumeric) && cedula.Length == tamanoLongitudCedula)
                {
                    var provincia = Convert.ToInt32(string.Concat(cedula[0], cedula[1], string.Empty));
                    var digitoTres = Convert.ToInt32(cedula[2] + string.Empty);

                    if ((provincia > 0 && provincia <= numeroProvincias) && digitoTres < tercerDigito)
                    {
                        var digitoVerificadorRecibido = Convert.ToInt32(cedula[9] + string.Empty);

                        for (var i = 0; i < coeficientesCedula.Length; i++)
                        {
                            var valor = Convert.ToInt32(coeficientesCedula[i] + string.Empty) * Convert.ToInt32(cedula[i] + string.Empty);
                            total = valor >= 10 ? total + (valor - 9) : total + valor;
                        }//for

                        //Luego a la suma de todos los resultdos le restamos de la decena superior
                        //var digitoVerificadorObtenido = (((total / 10) + 1) * 10) - total;
                        var digitoVerificadoObtenido = total >= 10 ? (total % 10) != 0 ?
                        10 - (total % 10) : (total % 10) : total;

                        //if (digitoVerificadorObtenido == digitoVerificadorRecibido)
                        //  bandera = true;
                        if (digitoVerificadoObtenido == digitoVerificadorRecibido)
                            bandera = true;
                        return bandera;
                    }//if
                }//if
                //cedula
                else
                {
                    bandera = false;
                }

            }
            catch (Exception ex)
            {
                return false;
            }

            return bandera;
        }//validarNumeroCedula
    }
}
