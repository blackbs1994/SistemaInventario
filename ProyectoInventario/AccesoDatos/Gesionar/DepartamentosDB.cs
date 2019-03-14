using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AccesoDatos.Gesionar
{
    public class DepartamentosDB
    {
        public static bool guardarDepartamentos(Departamentos objetoDepartamentos)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.Departamentos.Add(objetoDepartamentos);
                contextoConexion.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarCatalogoProductosa

        public static List<Departamentos> recuperarListaDepartamentos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaDepartamentos = contextoConexionBusqueda.Departamentos.Select(p => p).ToList();

            return listaDepartamentos;
        }//recuperarListalistaDepartamentos


        public static Departamentos recuperarDepartamentoPorID(int idDepartamento)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoDepartamento = contextoConexionBusqueda.Departamentos.Where(x => x.idDepartamento == idDepartamento).FirstOrDefault();

            return objetoDepartamento;
        }//recuperarDepartamentoPorID



        public static bool actualizarDepartamento(Departamentos objetoDepartamento)
        {
            bool banderaEditar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Departamentos objetoDepartamentoDB = contextoConexionEditar.Departamentos.Find(objetoDepartamento.idDepartamento);

                contextoConexionEditar.Entry(objetoDepartamentoDB).CurrentValues.SetValues(objetoDepartamento);
                contextoConexionEditar.Entry(objetoDepartamentoDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEditar = false;
            }

            return banderaEditar;
        }//actualizarDepartamento

        public static bool eliminarDepartamento(int idDepartamento)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Departamentos objetoDepartamento = contextoConexionEditar.Departamentos.Find(idDepartamento);
                contextoConexionEditar.Departamentos.Remove(objetoDepartamento);
                contextoConexionEditar.SaveChanges();
            }
#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            catch (Exception ex)
#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
            {
                banderaEliminar = false;
            }

            return banderaEliminar;
        }//eliminarDepartamento


        public bool ExisteDepartamento (string Departamento)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Departamentos.Any(x => x.Departamento == Departamento);

        }

    }//class
}


