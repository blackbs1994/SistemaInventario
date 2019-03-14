using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class CaracteristicasDB
    {
        public static bool guardarCaracteristica(Caracteristicas objetoCaracteristicas)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.Caracteristicas.Add(objetoCaracteristicas);
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

        public static bool actualizarCaracteristicas(Caracteristicas objetoCaracteristicas)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Caracteristicas objetoCaracteristicasDB = contextoConexionEditar.Caracteristicas.Find(objetoCaracteristicas.idCaracteristica);

                contextoConexionEditar.Entry(objetoCaracteristicasDB).CurrentValues.SetValues(objetoCaracteristicas);
                contextoConexionEditar.Entry(objetoCaracteristicasDB).State = EntityState.Modified;
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

        public static bool eliminarCaracteristica(int idCaracteristica)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Caracteristicas objetoCaracteristicas = contextoConexionEditar.Caracteristicas.Find(idCaracteristica);
                contextoConexionEditar.Caracteristicas.Remove(objetoCaracteristicas);
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

        public bool ExisteCaracteristica (string Caracteristica)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Caracteristicas.Any(x => x.Caracteristica == Caracteristica);
        }
        #region Busquedas
        public static List<Caracteristicas> recuperarListaCaracteristicas()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaCaracteristicas = contextoConexionBusqueda.Caracteristicas.Select(p => p).OrderBy(p => p.Caracteristica).ToList();

            return listaCaracteristicas;
        }//recuperarListaCaracteristicas

        public static Caracteristicas recuperarCaracteristicasPorID(int idCaracteristica)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoCaracteristica = contextoConexionBusqueda.Caracteristicas.Where(x => x.idCaracteristica == idCaracteristica).FirstOrDefault();

            return objetoCaracteristica;
        }//recuperarListaCaracteristicas 

        public static List<Item> recuperarItemsCaracteristicasPorDescripcion(string descripcionCaractaristicas)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            List<Caracteristicas> listaCaracteristicas = contextoConexionBusqueda.Caracteristicas.Where(x => x.Descripcion.Contains(descripcionCaractaristicas) || x.TipoCaracteristicas.TipoCaracteristica.Contains(descripcionCaractaristicas)).ToList();

            var listaCaracteristicasItem = from c in listaCaracteristicas
                                           select new Item
                                           {
                                               id = c.idCaracteristica.ToString(),
                                               value = c.Caracteristica + " " + c.Descripcion
                                           };

            if (listaCaracteristicasItem.Count() == 0)
            {
                List<Item> listaItems = new List<Item>();
                Item objetoItem = new Item("0", "No hay resultados");
                listaItems.Add(objetoItem);

                var consultaVacia = from c in listaItems
                                    select c;

                return consultaVacia.ToList();
            }

            return listaCaracteristicasItem.ToList();
        }//recuperarListaCaracteristicas
        #endregion Busquedas
    }//class
}
