using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class TipoDepartamentosDB
    {
        public static bool guardarTipoDepartamentos(TipoDepartamentos objetoTipoDepartamentos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.TipoDepartamentos.Add(objetoTipoDepartamentos);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarTipoDepartamentos

        public static List<TipoDepartamentos> recuperarListaTipoDepartamentos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaTipoDepartamentos = contextoConexionBusqueda.TipoDepartamentos.Select(p => p).ToList();

            return listaTipoDepartamentos;
        }//recuperarListaTipoDepartamentos

        public static TipoDepartamentos recuperarTipoDepartamentoPorID(int idTipoDepartamento)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoTipoDepartamento = contextoConexionBusqueda.TipoDepartamentos.Where(x => x.idTipo_Departamento == idTipoDepartamento).FirstOrDefault();

            return objetoTipoDepartamento;
        }//recuperarTipoDepartamentoPorID



        public static bool actualizarTipoDepartamento(TipoDepartamentos objetoTipoDepartamento)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                TipoDepartamentos objetoTipoDepartamentoDB = contextoConexionEditar.TipoDepartamentos.Find(objetoTipoDepartamento.idTipo_Departamento);

                contextoConexionEditar.Entry(objetoTipoDepartamentoDB).CurrentValues.SetValues(objetoTipoDepartamento);
                contextoConexionEditar.Entry(objetoTipoDepartamentoDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarTipoDepartamento

        public static bool eliminarTipoDepartamento(int idTipoDepartamento)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                TipoDepartamentos objetoTipoDepartamento = contextoConexionEditar.TipoDepartamentos.Find(idTipoDepartamento);
                contextoConexionEditar.TipoDepartamentos.Remove(objetoTipoDepartamento);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarTipoDepartamento

    }//class
}
