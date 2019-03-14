using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class TipoCaracteristicasDB
    {
        public static bool guardarTipoCaracteristicas(TipoCaracteristicas objetoTipoCaracteristicas)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.TipoCaracteristicas.Add(objetoTipoCaracteristicas);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarTipoCaracteristicas

        public static bool actualizarTipoCaracteristicas(TipoCaracteristicas objetoTipoCaracteristicas)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                TipoCaracteristicas objetoTipoCaracteristicasDB = contextoConexionEditar.TipoCaracteristicas.Find(objetoTipoCaracteristicas.idTipoCaracteristica);

                contextoConexionEditar.Entry(objetoTipoCaracteristicasDB).CurrentValues.SetValues(objetoTipoCaracteristicas);
                contextoConexionEditar.Entry(objetoTipoCaracteristicasDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarTipoCaracteristicas

        public static bool eliminarTipoCaracteristica(int idTipoCaracteristica)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                TipoCaracteristicas objetoTipoCaracteristicas = contextoConexionEditar.TipoCaracteristicas.Find(idTipoCaracteristica);
                contextoConexionEditar.TipoCaracteristicas.Remove(objetoTipoCaracteristicas);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarTipoCaracteristica

        #region Busquedas
        public static List<TipoCaracteristicas> recuperarListaTipoCaracteristicas()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaTipoCaracteristicas = contextoConexionBusqueda.TipoCaracteristicas.Select(p => p).ToList();

            return listaTipoCaracteristicas;
        }//recuperarListaTipoCaracteristicas

        public static TipoCaracteristicas recuperarTipoCaracteristicasPorID(int idTipoCaracteristicas)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoTipoCaracteristicas = contextoConexionBusqueda.TipoCaracteristicas.Where(x => x.idTipoCaracteristica == idTipoCaracteristicas).FirstOrDefault();

            return objetoTipoCaracteristicas;
        }

        #endregion #region Busquedas
    }//class
}
