using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class DetalleProductosDB
    {
        public static bool guardarDetalleMovimientos(DetalleProductos objetoDetalleProductos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.DetalleProductos.Add(objetoDetalleProductos);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarCatalogoProductosa

        public static bool eliminarDetalleProducto(int idDetalleProducto)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                DetalleProductos objetoDetalleProducto = contextoConexionEditar.DetalleProductos.Find(idDetalleProducto);
                contextoConexionEditar.DetalleProductos.Remove(objetoDetalleProducto);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarDetalleProducto



        public static List<DetalleProductos> recuperarListaDetalleProductos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaDetalleProductos = contextoConexionBusqueda.DetalleProductos.Select(p => p).ToList();

            return listaDetalleProductos;
        }//recuperarListaDetalleProductos

        public static List<DetalleProductos> recuperarListaDetalleProductosPorIDProducto(int idProducto)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaDetalleProductos = contextoConexionBusqueda.DetalleProductos.Where(x => x.idProducto == idProducto).ToList();

            return listaDetalleProductos;
        }//recuperarListaDetalleProductosPorIDProducto
        public static DetalleActaProductos recuperarDetalleActaProducto(int idProducto)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            DetalleActaProductos objetoDetalleProducto = contextoConexionBusqueda.DetalleActaProductos.Where(x => x.idProducto == idProducto).FirstOrDefault();

            return objetoDetalleProducto;
        }


    }//class
}
