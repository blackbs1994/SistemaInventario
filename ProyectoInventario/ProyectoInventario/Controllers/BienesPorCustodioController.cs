using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class BienesPorCustodioController : Controller
    {
        // GET: BienesPorCustodio
        public ActionResult IndexBienesPorCustodio()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            return View();
        }

       
    }
}