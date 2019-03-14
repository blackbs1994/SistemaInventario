using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class MarcasDB
    {
        public static bool guardarMarcas(Marcas objetoMarcas)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.Marcas.Add(objetoMarcas);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarMarcas

        public static List<Marcas> recuperarListaMarcas()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaMarcas = contextoConexionBusqueda.Marcas.Select(p => p).ToList();

            return listaMarcas;
        }//recuperarListalistaMarcas

        public static Marcas recuperarMarcasPorID(int idMarcas)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoMarcas = contextoConexionBusqueda.Marcas.Where(x => x.idMarca == idMarcas).FirstOrDefault();

            return objetoMarcas;
        }//recuperarMarcasPorID
               
        public static bool actualizarMarcas(Marcas objetoMarcas)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Marcas objetoMarcasDB = contextoConexionEditar.Marcas.Find(objetoMarcas.idMarca);

                contextoConexionEditar.Entry(objetoMarcasDB).CurrentValues.SetValues(objetoMarcas);
                contextoConexionEditar.Entry(objetoMarcasDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarMarcas

        public static bool eliminarMarcas(int idMarcas)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Marcas objetoMarcas = contextoConexionEditar.Marcas.Find(idMarcas);
                contextoConexionEditar.Marcas.Remove(objetoMarcas);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarMarcas

        public bool ExisteMarca (string Marca)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Marcas.Any(x => x.Marca == Marca);
        }
    }//class
}
