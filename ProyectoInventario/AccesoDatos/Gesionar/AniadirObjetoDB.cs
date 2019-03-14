using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class AniadirObjetoDB
    {
        public static bool guardarObjetoDB(Object objetoGuardar)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                Type tipoObjeto = objetoGuardar.GetType();

                switch (tipoObjeto.Name)
                {
                    case "ActasProductosUsuarios":
                        ActasProductosUsuarios objetoActasProductosUsuarios = (ActasProductosUsuarios)objetoGuardar;
                        contextoConexion.ActasProductosUsuarios.Add(objetoActasProductosUsuarios);
                        break;
                    case "DetalleActaProductos":
                        DetalleActaProductos objetoDetalleProductos = (DetalleActaProductos)objetoGuardar;
                        contextoConexion.DetalleActaProductos.Add(objetoDetalleProductos);
                        break;
                }
                
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
              
            }

            return banderaGuardado;
        }
    }//class
}
