using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class TipoOrigenesDB
    {
        public static bool guardarTipoOrigenes(TipoOrigenes objetoTipoOrigenes)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.TipoOrigenes.Add(objetoTipoOrigenes);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarTipoOrigenes

        public static List<TipoOrigenes> recuperarListaTipoOrigenes()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaTipoOrigenes = contextoConexionBusqueda.TipoOrigenes.Select(p => p).ToList();

            return listaTipoOrigenes;
        }//recuperarListaTipoOrigenes
    }//class
}
