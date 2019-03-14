using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class ModelosDB
    {
        public static bool guardarModelos(Modelos objetoModelos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                if(!contextoConexion.Modelos.Any(x=>x.Modelo == objetoModelos.Modelo))
                {
                    contextoConexion.Modelos.Add(objetoModelos);
                    contextoConexion.SaveChanges();
                }
                
                
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarModelos

        public static bool actualizarModelo(Modelos objetoModelo)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Modelos objetoModeloDB = contextoConexionEditar.Modelos.Find(objetoModelo.idModelo);

                contextoConexionEditar.Entry(objetoModeloDB).CurrentValues.SetValues(objetoModelo.idModelo);
                contextoConexionEditar.Entry(objetoModeloDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }
        public static bool eliminarModelo (int idModelo)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Modelos objetoModelo = contextoConexionEditar.Modelos.Find(idModelo);
                contextoConexionEditar.Modelos.Remove(objetoModelo);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }
        public static List<Modelos> recuperarListaModelos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaModelos = contextoConexionBusqueda.Modelos.Select(p=> p).ToList();

            return listaModelos;
        }//recuperarListaModelos
        public static Modelos recuperarModeloPorID(int idModelo)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoModelo = contextoConexionBusqueda.Modelos.Where(x => x.idModelo == idModelo).FirstOrDefault();

            return objetoModelo;
        }

        public bool ExisteModelo(string Modelo)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Modelos.Any(x => x.Modelo == Modelo);
        }
    }//class
}
