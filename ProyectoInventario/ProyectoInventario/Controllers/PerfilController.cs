
using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class PerfilController : Controller
    {

        // GET: Perfil
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            List<Perfiles> listaPerfiles = PerfilesDB.recuperarListaPerfiles();
            
            return View(listaPerfiles);
        }
        [HttpGet]
        public ActionResult Create()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            return View();
        }
        [HttpPost]
        public ActionResult Create(Perfiles objetoPerfil)
        {
            
            bool banderaGuardar = PerfilesDB.guardarPerfiles(objetoPerfil);
            MostrarMensajes(banderaGuardar);
            return View();
        }
        public ActionResult Update(int id)
        {
            Perfiles objetoPerfil = PerfilesDB.recuperarPerfilesPorID(id);          


            return View(objetoPerfil);
        }

        [HttpPost]
        public ActionResult Update(Perfiles objetoPerfiles)
        {
            
            bool banderaActualizarPerfil = PerfilesDB.actualizarPerfiles(objetoPerfiles);
            MostrarMensajes(banderaActualizarPerfil);
            return View();
        }
        [HttpGet]
        public ActionResult Delete(int id)
        {
          
            Perfiles objetoPerfil = PerfilesDB.recuperarPerfilesPorID(id);
            
            return View(objetoPerfil);
        }

        [HttpPost]
        public ActionResult Delete(Perfiles objetoPerfiles)
        {
            
            bool banderaEliminar = PerfilesDB.eliminarPerfil(objetoPerfiles.idPerfil);
            MostrarMensajes(banderaEliminar);
            return View();
            //return RedirectToAction("Index");
        }

        public void MostrarMensajes(bool bandera)
        {

            if (bandera)
            {
                TempData["mensajeExitoso"] = "Operación realizada exitosamente.";

            }
            else
            {
                TempData["mensajeError"] = "Ocurrió un error al intentar realizar la acción requerida, por favor verifique la información y la conexión a la base de datos.";
            }

        }//MostrarMensajes

    }
}