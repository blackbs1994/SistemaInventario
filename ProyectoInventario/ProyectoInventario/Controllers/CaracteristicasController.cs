using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;


namespace ProyectoInventario.Controllers
{
    public class CaracteristicasController : Controller
    {
        
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            List<Caracteristicas> listaCaracteristicas = CaracteristicasDB.recuperarListaCaracteristicas();

            return View(listaCaracteristicas);
        }
        [HttpGet]
        public ActionResult Create()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();
            return View();
        }
        [HttpPost]
        public ActionResult Create(Caracteristicas objetoCararcteristicas, string accion)
        {
            CaracteristicasDB objCaracteristicaDB = new CaracteristicasDB();
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            if (accion == "guardar_caracteristica")
            {
                if (objCaracteristicaDB.ExisteCaracteristica(objetoCararcteristicas.Caracteristica))
                {
                    ModelState.AddModelError("caracteristica_agregar", "La caracteristica ingresada ya existe");

                    return View("Create");
                }
                else
                {
                    bool banderaGuardar = CaracteristicasDB.guardarCaracteristica(objetoCararcteristicas);
                    MostrarMensajes(banderaGuardar);
                }
            }
            
            else
            {
                throw new Exception("Accion no definida..");
            }
                       
            return RedirectToAction("Index");

           


        }

        [HttpGet]
        public ActionResult Find(int id)
        {
            cargarDatosIniciales();
            Caracteristicas objetoTipoCaracteristicas = CaracteristicasDB.recuperarCaracteristicasPorID(id);

            return View(objetoTipoCaracteristicas);
        }

        [HttpGet]
        public ActionResult Update(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();
            Caracteristicas objetoTipoCaracteristicas = CaracteristicasDB.recuperarCaracteristicasPorID(id);

            
            return View(objetoTipoCaracteristicas);
        }
        [HttpPost]
        public ActionResult Update(Caracteristicas objetoCararcteristicas)
        {
            bool banderaActualizar = CaracteristicasDB.actualizarCaracteristicas(objetoCararcteristicas);

            MostrarMensajes(banderaActualizar);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            cargarDatosIniciales();
            Caracteristicas objetoTipoCaracteristicas = CaracteristicasDB.recuperarCaracteristicasPorID(id);

            return View(objetoTipoCaracteristicas);
        }

        [HttpPost]
        public ActionResult Delete(Caracteristicas objetoCararcteristicas)
        {
           
            bool banderaActualizar = CaracteristicasDB.eliminarCaracteristica(objetoCararcteristicas.idCaracteristica);

            MostrarMensajes(banderaActualizar);
            return RedirectToAction("Index");
        }

        public void cargarDatosIniciales()
        {
            List<TipoCaracteristicas> listaTipoCaracteristicas = TipoCaracteristicasDB.recuperarListaTipoCaracteristicas();
            SelectList listaSelectTipoCaracteristicas = new SelectList(listaTipoCaracteristicas, "idTipoCaracteristica", "TipoCaracteristica");
            ViewBag.ListaTipoCaracteristicas = listaSelectTipoCaracteristicas;
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

        #region Nuevo Codigo
        [HttpPost]
        public ActionResult AnadirC(int idCaracteristaSeleccionada)
        {
            List<Caracteristicas> listaCaracteristicas = new List<Caracteristicas>();
            
                Caracteristicas objetoetoCaracteristicas = CaracteristicasDB.recuperarCaracteristicasPorID(idCaracteristaSeleccionada);

                    listaCaracteristicas.Add(objetoetoCaracteristicas);
        
            return View("_ListaCaracteristicas", listaCaracteristicas);
        }//AnadirC [HttpPost]

        
        public ActionResult BuscarCaracteristicasPorDescripcion(string term)
        {
            List<Item> listaCaracteristicas = new List<Item>();
            
            listaCaracteristicas = CaracteristicasDB.recuperarItemsCaracteristicasPorDescripcion(term);

            return Json(listaCaracteristicas, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}