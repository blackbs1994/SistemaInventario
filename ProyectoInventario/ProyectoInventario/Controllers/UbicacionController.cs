using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class UbicacionController : Controller
    {
        // GET: Ubicaciones
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            List<Ubicaciones> listaUbicaciones = UbicacionesDB.recuperarListaUbicaciones();

            return View(listaUbicaciones);
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
        public ActionResult Create(Ubicaciones objetoUbicaciones)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            bool banderaGuardar = UbicacionesDB.guardarUbicaciones(objetoUbicaciones);

            MostrarMensajes(banderaGuardar);
            return View();
        }

        public ActionResult EditarUbicacion(int idUbicacion)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Ubicaciones objetoUbicacion = UbicacionesDB.recuperarUbicacionPorID(idUbicacion);


            return View(objetoUbicacion);
        }

        [HttpPost]
        public ActionResult EditarUbicacion(Ubicaciones objetoUbicacion)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = UbicacionesDB.actualizarUbicacion(objetoUbicacion);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }

        public ActionResult DetalleUbicacion(int idUbicacion)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Ubicaciones objetoUbicacion = UbicacionesDB.recuperarUbicacionPorID(idUbicacion);


            return View(objetoUbicacion);
        }

        public ActionResult EliminarUbicacion(int idUbicacion)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Ubicaciones objetoUbicacion = UbicacionesDB.recuperarUbicacionPorID(idUbicacion);


            return View(objetoUbicacion);
        }

        [HttpPost]
        public ActionResult EliminarUbicacion(Ubicaciones objetoUbicacion)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = UbicacionesDB.eliminarUbicacion(objetoUbicacion.idUbicacion);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }


        //mensaje de error al eliminar
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