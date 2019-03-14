using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class PerfilesDB
    {
        #region CRUD DB
        public static bool guardarPerfiles(Perfiles objetoPerfiles)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.Perfiles.Add(objetoPerfiles);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarPerfiles

        public static bool actualizarPerfiles(Perfiles objetoPerfiles)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Perfiles objetoPerfilDB = contextoConexionEditar.Perfiles.Find(objetoPerfiles.idPerfil);

                contextoConexionEditar.Entry(objetoPerfilDB).CurrentValues.SetValues(objetoPerfiles);
                contextoConexionEditar.Entry(objetoPerfilDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarPerfiles

        public static bool eliminarPerfil(int idPerfil)
        {
            bool banderaEliminar = true;
            inventarioEntidadesDB contextoConexionEliminar = new inventarioEntidadesDB();
            try
            {
                Perfiles objetoLocal = contextoConexionEliminar.Perfiles.Find(idPerfil);
                contextoConexionEliminar.Perfiles.Remove(objetoLocal);
                contextoConexionEliminar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarPerfil
        #endregion

        #region Consultas
        public static List<Perfiles> recuperarListaPerfiles()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaPerfiles = contextoConexionBusqueda.Perfiles.Select(p => p).ToList();

            return listaPerfiles;
        }//recuperarListaPerfiles

        public static Perfiles recuperarPerfilesPorID(int idPerfil)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoPerfiles = contextoConexionBusqueda.Perfiles.Where(x => x.idPerfil == idPerfil).FirstOrDefault();

            return objetoPerfiles;
        }//recuperarPerfilesPorID
        #endregion
    }//class
}
