using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class ModeloController : Controller
    {
        // GET: Modelo
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            Modelos objetoModelos = new Modelos();
            List<Modelos> listaModelos = ModelosDB.recuperarListaModelos();
            return View(listaModelos);
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
        public ActionResult Create(Modelos objetoModelos, string accion)
        {
            ModelosDB objModeloDB = new ModelosDB();
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();

            if (accion == "guardar_modelo")
            {
                if(objModeloDB.ExisteModelo(objetoModelos.Modelo))
                {
                    ModelState.AddModelError("modelo_agregar", "El modelo ingresado ya existe");
                    return View("Create");
                }
                else
                {
                    bool banderaGuardar = ModelosDB.guardarModelos(objetoModelos);

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
        public ActionResult EditarModelo(int idModelo)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            Modelos objetoModelo = ModelosDB.recuperarModeloPorID(idModelo);


            return View(objetoModelo);
        }

        [HttpPost]
        public ActionResult EditarModelo(Modelos objetoModelo)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            bool bandera = ModelosDB.actualizarModelo(objetoModelo);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }

        public ActionResult DetalleModelo(int idModelo)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            Modelos objetoModelo = ModelosDB.recuperarModeloPorID(idModelo);


            return View(objetoModelo);
        }
        [HttpGet]
        public ActionResult EliminarModelo(int idModelo)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            Modelos objetoModelo = ModelosDB.recuperarModeloPorID(idModelo);


            return View(objetoModelo);
        }

        [HttpPost]
        public ActionResult EliminarModelo(Modelos objetoModelo)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = ModelosDB.eliminarModelo(objetoModelo.idModelo);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }
        public JsonResult buscarModelosPorMarca(int idMarca)
        {
            List<Modelos> listaModelos = ModelosDB.recuperarListaModelos();

            var listaModelosFinal = listaModelos.Where(x => x.idMarca == idMarca).ToList();

            SelectList listaModelosSelect = new SelectList(listaModelosFinal, "idModelo", "Modelo");


            return Json(listaModelosSelect, JsonRequestBehavior.AllowGet);
        }


        public void cargarDatosIniciales()
        {
            List<Marcas> dataMarcas = MarcasDB.recuperarListaMarcas();
            SelectList listaMarcas = new SelectList(dataMarcas, "idMarca", "Marca");
            ViewBag.ListaMarcas = listaMarcas;
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
    }//class
}