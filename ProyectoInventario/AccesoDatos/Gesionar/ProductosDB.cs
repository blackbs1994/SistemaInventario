using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class ProductosDB
    {
        public static bool guardarProductos(Productos objetoProductos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();
            
            bool banderaGuardado = true;

            try
            {
                contextoConexion.Productos.Add(objetoProductos);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarProductos

        public bool ExisteNumeroSerie (string NumeroSerie)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Productos.Any(x => x.NumeroSerie == NumeroSerie);
            
        }
        public static bool actualizarProductos(Productos objetoProductos)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Productos objetoProductosDB = contextoConexionEditar.Productos.Find(objetoProductos.idProducto);

                contextoConexionEditar.Entry(objetoProductosDB).CurrentValues.SetValues(objetoProductos);
                contextoConexionEditar.Entry(objetoProductosDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();

                actualizarCaracteristicasDetalleProducto(objetoProductos.DetalleProductos, objetoProductos.idProducto);
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarCaracteristicas

        public static void actualizarCaracteristicasDetalleProducto(ICollection<DetalleProductos> listaDetalleProductos, int idProducto)
        {
            inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
            var listaDetalleProductosActual = DetalleProductosDB.recuperarListaDetalleProductosPorIDProducto(idProducto);

            foreach (DetalleProductos objetoDetalleProductoTemporal in listaDetalleProductosActual)
            {
                DetalleProductosDB.eliminarDetalleProducto(objetoDetalleProductoTemporal.idDetalleProducto);
            }


            foreach (DetalleProductos objetoDetalleProductoTemporal in listaDetalleProductos)
            {
                try
                {
                    contextoConexionEditar.DetalleProductos.Add(objetoDetalleProductoTemporal);
                    contextoConexionEditar.SaveChanges();
                }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
                catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
                {
                }
            }

        }//actualizarCaracteristicasDetalleProducto


        public static bool eliminarProducto(int idProducto)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();
                
                var listaDetalleProducto = contextoConexion.DetalleProductos.Where(x => x.idProducto == idProducto);
                foreach (DetalleProductos objetoDetalleProductoTemporal in listaDetalleProducto)
                {
                    DetalleProductosDB.eliminarDetalleProducto(objetoDetalleProductoTemporal.idDetalleProducto);
                }

                inventarioEntidadesDB contextoConexionEliminar = new inventarioEntidadesDB();
                Productos objetoProductos = contextoConexionEliminar.Productos.Find(idProducto);
                contextoConexionEliminar.Productos.Remove(objetoProductos);
                contextoConexionEliminar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarProducto

        #region Busquedas
        public static List<Productos> recuperarListaProductos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaProductos = contextoConexionBusqueda.Productos.Select(p => p).ToList();

            return listaProductos;
        }//recuperarListaProductos

        public static Productos recuperarProductosPorID(int idProductos)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoProductos = contextoConexionBusqueda.Productos.Where(x => x.idProducto == idProductos).FirstOrDefault();

            return objetoProductos;
        }//recuperarListaProductosPorID

        public static List<Productos> recuperarListaProductoPorNumeroSerie(string numeroSerie)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaProductos = contextoConexionBusqueda.Productos.Where(x => x.NumeroSerie.Contains(numeroSerie)).ToList();

            return listaProductos;
        }//recuperarListaProductoPorNumeroSerie

        //public static Productos recuperarProductoPorNumeroSerie(string numeroSerie)
        //{
        //    inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
        //    var objetoProductos = contextoConexionBusqueda.Productos.Where(x => x.NumeroSerie == numeroSerie).ToList();

        //    return objetoProductos;
        //}//recuperarProductoPorNumeroSerie

        public static List<Productos> recuperarProductoPorCodigoSecob(string numeroCodigoSecob)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaProductos = contextoConexionBusqueda.Productos.Where(x => x.codigoSecob == numeroCodigoSecob).ToList();

            return listaProductos;
        }//recuperarProductoPorCodigoSecob

        public static List<Productos> recuperarProductoPorCodigoFinanzas(string numeroCodigoFinanzas)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaProductos = contextoConexionBusqueda.Productos.Where(x => x.codigoFinazas == numeroCodigoFinanzas).ToList();

            return listaProductos;
        }//recuperarProductoPorCodigoFinanzas

        #endregion Busquedas
    }//class
}
