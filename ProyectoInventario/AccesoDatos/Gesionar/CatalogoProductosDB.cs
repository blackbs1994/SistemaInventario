using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class CatalogoProductosDB
    {
        public static bool guardarCatalogoProductosa(CatalogoProductos objetoCatalogoProductos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.CatalogoProductos.Add(objetoCatalogoProductos);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarCaracteristica
        public static bool actualizarCaracteristicas(CatalogoProductos objetoCatalogoProductos)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                CatalogoProductos objetoCatalogoProductosDB = contextoConexionEditar.CatalogoProductos.Find(objetoCatalogoProductos.idCatalogoProducto);

                contextoConexionEditar.Entry(objetoCatalogoProductosDB).CurrentValues.SetValues(objetoCatalogoProductos);
                contextoConexionEditar.Entry(objetoCatalogoProductosDB).State = EntityState.Modified;
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

        public static bool eliminarCaracteristica(int idCatalogoProducto)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                CatalogoProductos objetoCatalogoProductos = contextoConexionEditar.CatalogoProductos.Find(idCatalogoProducto);
                contextoConexionEditar.CatalogoProductos.Remove(objetoCatalogoProductos);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarCaracteristica

        public bool ExisteCatalogoProducto (string CatalogoProducto)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.CatalogoProductos.Any(x => x.CatalogoProducto == CatalogoProducto);
        }
        #region Busquedas
        public static List<CatalogoProductos> recuperarListaCatalogoProductos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaCataloProductos = contextoConexionBusqueda.CatalogoProductos.Select(p => p).ToList();

            return listaCataloProductos;
        }//recuperarListaCatalogoProductos

        public static CatalogoProductos recuperarCatalogoProductosPorID(int idCatalogoProductos)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoCataloProductos = contextoConexionBusqueda.CatalogoProductos.Where(x => x.idCatalogoProducto == idCatalogoProductos).FirstOrDefault();

            return objetoCataloProductos;
        }//recuperarListaCatalogoProductos

        #endregion
    }//class
}
