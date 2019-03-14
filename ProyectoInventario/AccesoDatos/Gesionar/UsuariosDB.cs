using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using Helper;

namespace AccesoDatos.Gesionar
{
    public class UsuariosDB
    {
        
        
        public static bool guardarUsuarios(Usuarios objetoUsuarios)
        {
            inventarioEntidadesDB contextoConexion = new inventarioEntidadesDB();

            bool banderaGuardado = true;

            try
            {
                contextoConexion.Usuarios.Add(objetoUsuarios);
                contextoConexion.SaveChanges();
            }

            catch (Exception ex)
        
            {
                banderaGuardado = false;
            }

            return banderaGuardado;
        }//guardarUsuarios

        //Actualizar Usuario

        // Eliminar Usuario
        public static bool eliminarUsuarios(int idUsuarios)
        {
            bool banderaEliminar = true;

            try
            {
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Usuarios objetoUsuarios = contextoConexionEditar.Usuarios.Find(idUsuarios);
                contextoConexionEditar.Usuarios.Remove(objetoUsuarios);
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

        // Fin Eliminar Usuario

        public bool ExisteUsuario(string Usuario)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Usuarios.Any(x => x.Usuario == Usuario);
        }
        public bool ExisteCedula (string Cedula)
        {
            inventarioEntidadesDB contextoBusqueda = new inventarioEntidadesDB();
            return contextoBusqueda.Usuarios.Any(x => x.Cedula == Cedula);
        }
        public static bool actualizarUsuarios(Usuarios objetoUsuarios)
        {
            bool banderaEditar = true;
            //try
            //{
                inventarioEntidadesDB contextoConexionEditar = new inventarioEntidadesDB();
                Usuarios objetoUsuariosDB = contextoConexionEditar.Usuarios.Find(objetoUsuarios.idUsuario);
                contextoConexionEditar.Entry(objetoUsuariosDB).CurrentValues.SetValues(objetoUsuarios);
                contextoConexionEditar.Entry(objetoUsuariosDB).State = EntityState.Modified;
                contextoConexionEditar.SaveChanges();
                
            //}
//#pragma warning disable CS0168 // La variable 'ex' se ha declarado pero nunca se usa
//            catch (Exception ex)
//#pragma warning restore CS0168 // La variable 'ex' se ha declarado pero nunca se usa
//            {
//                banderaEditar = false;
//            }
            return banderaEditar;
        }
        //Fin Actualizar Usuario
        //Mostrar Usuario
        public static Usuarios recuperarUsuariosPordID (int idUsuarios)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoUsuarios = contextoConexionBusqueda.Usuarios.Where(x => x.idUsuario == idUsuarios).FirstOrDefault();
            return objetoUsuarios;
        }
        //Fin Mostrar usuario
        #region Busquedas
        public static List<Usuarios> recuperarListaUsuarios()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaUsuarios = contextoConexionBusqueda.Usuarios.Select(p => p).ToList();

            return listaUsuarios;
        }//recuperarListaUsuarios

        public static Usuarios recuperarUsuarioPorCedula(string numeroCedula)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoUsuarios = contextoConexionBusqueda.Usuarios.Where(x => x.Cedula.Contains(numeroCedula)).FirstOrDefault();

            return objetoUsuarios;
        }//recuperarUsuarioPorCedula

        #endregion Busquedas

        #region Iniciar Sesion
        public static Usuarios validarInicioSesion(string nombreUsuario, string contrasena)
        {
            
            contrasena = HashHelper.MD5(contrasena);
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            Usuarios objetoUsuarios = contextoConexionBusqueda.Usuarios.Where(x => x.Usuario == nombreUsuario)
                                                                       .Where(x => x.Contrasenia == contrasena)
                                                                       .Where(x => x.Activar == 1).FirstOrDefault();
            if(objetoUsuarios !=null)
            {
                SessionHelper.AddUserToSession(objetoUsuarios.idUsuario.ToString());

            }            


            return objetoUsuarios;
        }//recuperarListaUsuarios

        public Usuarios Obtener (int id)
        {
            var usuario = new Usuarios();
            try
            {
                using (var ctx = new inventarioEntidadesDB())
                {
                    usuario = ctx.Usuarios.Include("Perfiles")
                        .Include("Perfiles.Permiso")
                        .Where(x => x.idUsuario == id).SingleOrDefault();
                }
            }
            catch (Exception)
            {
                throw;
            }
            return usuario;
        }
        public static Usuarios recuperarUsuario(string numeroCedula)
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var objetoUsuarios = contextoConexionBusqueda.Usuarios.Where(x => x.Cedula.Contains(numeroCedula)).FirstOrDefault();

            return objetoUsuarios;
            
        }//recuperarUsuarioPorCedula

        #endregion Iniciar Sesion


    }//class
}
