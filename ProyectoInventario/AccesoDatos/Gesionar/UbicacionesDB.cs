using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class UbicacionesDB
    {
        public static bool guardarUbicaciones(Ubicaciones objetoUbicaciones)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.Ubicaciones.Add(objetoUbicaciones);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarUbicaciones

        public static List<Ubicaciones> recuperarListaUbicaciones()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaUbicaciones = contextoConexionBusqueda.Ubicaciones.Select(p => p).ToList();

            return listaUbicaciones;
        }//recuperarListaUbicaciones

        public static Ubicaciones recuperarUbicacionPorID(int idUbicaciones)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoUbicacion = contextoConexionBusqueda.Ubicaciones.Where(x => x.idUbicacion == idUbicaciones).FirstOrDefault();

            return objetoUbicacion;
        }//recuperarUbicacionPorID



        public static bool actualizarUbicacion(Ubicaciones objetoUbicacion)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Ubicaciones objetoUbicacionDB = contextoConexionEditar.Ubicaciones.Find(objetoUbicacion.idUbicacion);

                contextoConexionEditar.Entry(objetoUbicacionDB).CurrentValues.SetValues(objetoUbicacion);
                contextoConexionEditar.Entry(objetoUbicacionDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarUbicacion

        public static bool eliminarUbicacion(int idUbicaciones)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Ubicaciones objetoUbicacion = contextoConexionEditar.Ubicaciones.Find(idUbicaciones);
                contextoConexionEditar.Ubicaciones.Remove(objetoUbicacion);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarUbicacion

    }//class
}
