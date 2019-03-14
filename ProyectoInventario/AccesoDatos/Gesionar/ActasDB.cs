using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public static class ActasDB
    {
        public static bool recuperarDetalleActaProductosPorIDProducto(int idProducto)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoDetalleActaProductos = contextoConexionBusqueda.DetalleActaProductos.Where(x => x.idProducto == idProducto).FirstOrDefault();

            if (objetoDetalleActaProductos != null)
            {
                return true;
            }

            return false;
        }//recuperarDetalleActaProductosPorID 

        public static bool eliminarDetalleActaProductosPorIDProducto(int idProducto)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEliminar = new inventarioEntidadesDB();
                DetalleActaProductos objetoDetalleProducto = contextoConexionEliminar.DetalleActaProductos.Where(x => x.idProducto==idProducto).FirstOrDefault();
                contextoConexionEliminar.DetalleActaProductos.Remove(objetoDetalleProducto);
                contextoConexionEliminar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarDetalleActaProductosPorIDProducto

        public static ActasProductosUsuarios recuperarActasProductosUsuariosPorID(int idActasProductosUsuarios)
        {
#pragma warning disable CS0219 // La variable 'banderaEliminar' está asignada pero su valor nunca se usa
            bool banderaEliminar = true;
#pragma warning restore CS0219 // La variable 'banderaEliminar' está asignada pero su valor nunca se usa

            try
            {
                inventarioEntidadesDB contextoConexionDB = new inventarioEntidadesDB();
                ActasProductosUsuarios objetoActasProductosUsuarios = contextoConexionDB.ActasProductosUsuarios.Where(x => x.IdActasProductosUsuarios == idActasProductosUsuarios).FirstOrDefault();
                return objetoActasProductosUsuarios;
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return null;
        }//recuperarActasProductosUsuariosPorID

        public static List<Productos> recuperarActasProductosPorIdentificacionUsuario(string identificacionUsuario)
        {
            try
            {
                inventarioEntidadesDB contextoConexionDB = new inventarioEntidadesDB();
                var listaActasProductos = contextoConexionDB.ActasProductosUsuarios.Where(x => x.Usuarios.Cedula == identificacionUsuario);
                List<Productos> listaProductos = new List<Productos>();

                foreach (ActasProductosUsuarios actasProductosUsuarios in listaActasProductos)
                {
                    List<DetalleActaProductos> listaDetalleProductosActas = contextoConexionDB.DetalleActaProductos.Where(x => x.IdActasProductosUsuarios == actasProductosUsuarios.IdActasProductosUsuarios).ToList();
                    if (listaDetalleProductosActas.Count>0)
                    {
                        foreach (DetalleActaProductos productoDetalleActa in listaDetalleProductosActas)
                        {
                            Productos objetoProductos = contextoConexionDB.Productos.Where(x => x.idProducto == productoDetalleActa.idProducto).FirstOrDefault();

                            listaProductos.Add(objetoProductos);
                        }
                    }
                }

                listaProductos = listaProductos.Distinct().ToList();

                return listaProductos;
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {

            }

            return null;
        }//recuperarActasProductosPorIdentificacionUsuario


    }//class
}
