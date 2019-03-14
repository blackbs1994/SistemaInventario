using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class TipoProductosDB
    {
        public static bool guardarTipoProductos(TipoProductos objetoTipoProductos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.TipoProductos.Add(objetoTipoProductos);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//     

        public static bool actualizarTipoProducto(TipoProductos objetoTipoProductos)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                TipoProductos objetoTipoProductosDB = contextoConexionEditar.TipoProductos.Find(objetoTipoProductos.idTipoProducto);

                contextoConexionEditar.Entry(objetoTipoProductosDB).CurrentValues.SetValues(objetoTipoProductos);
                contextoConexionEditar.Entry(objetoTipoProductosDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarCaracteristicas


        public static bool eliminarTipoProducto(int idTipoProducto)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                TipoProductos objetoTipoProducto = contextoConexionEditar.TipoProductos.Find(idTipoProducto);
                contextoConexionEditar.TipoProductos.Remove(objetoTipoProducto);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarTipoProducto

        public static TipoProductos recuperarTipoProductosPorID(int idTipoProducto)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoTipoProductos = contextoConexionBusqueda.TipoProductos.Where(x => x.idTipoProducto == idTipoProducto).FirstOrDefault();

            return objetoTipoProductos;
        }//recuperarListaTipoProductosPorID

        public static List<TipoProductos> recuperarListaTipoProductos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaTipoProductos = contextoConexionBusqueda.TipoProductos.Select(p => p).ToList();

            return listaTipoProductos;
        }//recuperarListaTipoProductos
    }//class
}
