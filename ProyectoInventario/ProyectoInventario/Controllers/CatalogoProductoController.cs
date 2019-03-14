using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace ProyectoInventario.Controllers
{
    public class CatalogoProductoController : Controller
    {
        // GET: CatalogoProducto
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }           

            CatalogoProductos objetoCatalogoProductos = new CatalogoProductos();
            List<CatalogoProductos> lista = CatalogoProductosDB.recuperarListaCatalogoProductos();
            
            return View(lista);
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
        public ActionResult Create(CatalogoProductos objetoCatalogoProductos, string accion)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            CatalogoProductosDB objCatalogoProductosDB = new CatalogoProductosDB();
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            if (accion == "guardar_catalogoprdoucto")
            {
                if(objCatalogoProductosDB.ExisteCatalogoProducto(objetoCatalogoProductos.CatalogoProducto))
                {
                    ModelState.AddModelError("catalogoproducto_agregar", "El catalogo ingresado ya existe");
                    return View("Create");
                }
                else
                {
                    bool banderaGuardarCatalogosProdcutos = CatalogoProductosDB.guardarCatalogoProductosa(objetoCatalogoProductos);
                    MostrarMensajes(banderaGuardarCatalogosProdcutos);
                }

            }
            else
            {
                throw new Exception("Accion no definida..");
            }
            return RedirectToAction("Index");
        }

        

        [HttpGet]
        public ActionResult FindCatalogoProducto(int id)
        {
            CatalogoProductos objetoCatalogoProductos = CatalogoProductosDB.recuperarCatalogoProductosPorID(id);


            return View(objetoCatalogoProductos);
        }

        [HttpGet]
        public ActionResult UpdateCatalogoProducto(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            CatalogoProductos objetoCatalogoProductos = CatalogoProductosDB.recuperarCatalogoProductosPorID(id);
            return View(objetoCatalogoProductos);
        }

        [HttpPost]
        public ActionResult UpdateCatalogoProducto(CatalogoProductos objetoCatalogoProductos)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            bool banderaActualizar = CatalogoProductosDB.actualizarCaracteristicas(objetoCatalogoProductos);

            MostrarMensajes(banderaActualizar);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult DeleteCatalogoProducto(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            CatalogoProductos objetoCatalogoProductos = CatalogoProductosDB.recuperarCatalogoProductosPorID(id);

            return View(objetoCatalogoProductos);
        }

        [HttpPost]
        public ActionResult DeleteCatalogoProducto(CatalogoProductos objetoCatalogoProductos)
        {

            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            bool banderaEliminar = CatalogoProductosDB.eliminarCaracteristica(objetoCatalogoProductos.idCatalogoProducto);

            MostrarMensajes(banderaEliminar);
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