using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
namespace ProyectoInventario.Controllers
{
    public class TipoCaracteristicasController : Controller
    {

        // GET: TipoCaracteristica
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            List<TipoCaracteristicas> listaCaracteristicas = TipoCaracteristicasDB.recuperarListaTipoCaracteristicas();
            
            return View(listaCaracteristicas);
        }
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(TipoCaracteristicas objetoTipoCaracteristicas)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool banderaGuardar = TipoCaracteristicasDB.guardarTipoCaracteristicas(objetoTipoCaracteristicas);

            MostrarMensajes(banderaGuardar);
            return View();
        }

        [HttpGet]
        public ActionResult Find(int id)
        {
            TipoCaracteristicas objetoTipoCaracteristicas = TipoCaracteristicasDB.recuperarTipoCaracteristicasPorID(id);

            return View(objetoTipoCaracteristicas);
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            TipoCaracteristicas objetoTipoCaracteristicas = TipoCaracteristicasDB.recuperarTipoCaracteristicasPorID(id);
            
            return View(objetoTipoCaracteristicas);
        }
        [HttpPost]
        public ActionResult Delete(TipoCaracteristicas objetoTipoCaracteristicas)
        {
            bool banderaEliminar = TipoCaracteristicasDB.eliminarTipoCaracteristica(objetoTipoCaracteristicas.idTipoCaracteristica);

            return RedirectToAction("Index");
        }



        [HttpGet]
        public ActionResult Update(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            TipoCaracteristicas objetoTipoCaracteristicas = TipoCaracteristicasDB.recuperarTipoCaracteristicasPorID(id);

            return View(objetoTipoCaracteristicas);
        }
        [HttpPost]
        public ActionResult Update(TipoCaracteristicas objetoTipoCaracteristicas)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            bool banderaActualizar = TipoCaracteristicasDB.actualizarTipoCaracteristicas(objetoTipoCaracteristicas);

            MostrarMensajes(banderaActualizar);
            return View();
        }


     
        public void MostrarMensajes(bool bandera)
        {

            if(bandera)
            {
                TempData["mensajeExitoso"] = "Operación realizada exitosamente.";
                
            }
            else
            {
                TempData["mensajeError"] = "Ocurrió un error al intentar realizar la acción requerida, por favor verifique la información y la conexión a la base de datos.";
            }

        }//MostrarMensajes

    }//Class
}