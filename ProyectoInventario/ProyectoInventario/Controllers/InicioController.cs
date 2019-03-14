using AccesoDatos.Modelo;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class InicioController : Controller
    {
        // GET: Inicio
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");                
            }
            BuscarDetalleActaProductos();
            return View();
        }//Index
        [HttpGet]
        public ActionResult BuscarDetalleActaProductos()
        {
            List<DetalleActaProductos> listaDetalleActaProductos = ActaController.recuperarListaDetalleActasProductos();
            return View(listaDetalleActaProductos);
        }
        [HttpGet]
        public ActionResult GenerarPDF ()
        {
            List<DetalleActaProductos> listaDetalleActaProductos = ActaController.recuperarListaDetalleActasProductos();
            return View(listaDetalleActaProductos);
        }

    




    }
}