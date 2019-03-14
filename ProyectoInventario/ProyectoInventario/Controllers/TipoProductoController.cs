using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;

namespace ProyectoInventario.Controllers
{
    public class TipoProductoController : Controller
    {

        // GET: TipoProductos
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();

            List<TipoProductos> lista = TipoProductosDB.recuperarListaTipoProductos();

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

            cargarDatosIniciales();

            return View();
        }
        [HttpPost]
        public ActionResult Create(TipoProductos objetoCararcteristicas)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();            
            bool banderaGuardar = TipoProductosDB.guardarTipoProductos(objetoCararcteristicas);

            MostrarMensajes(banderaGuardar);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult FindTipoProducto(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();

            var objetoTipoProductos = TipoProductosDB.recuperarTipoProductosPorID(id);

            return View(objetoTipoProductos);
        }

        [HttpGet]
        public ActionResult UpdateTipoProducto(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();

            var objetoTipoProductos = TipoProductosDB.recuperarTipoProductosPorID(id);

            return View(objetoTipoProductos);
        }
        [HttpPost]
        public ActionResult UpdateTipoProducto(TipoProductos objetoTipoProductos)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();

            bool banderaActualizar = TipoProductosDB.actualizarTipoProducto(objetoTipoProductos);

            MostrarMensajes(banderaActualizar);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult DeleteTipoProducto(int id)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();

            var objetoTipoProductos = TipoProductosDB.recuperarTipoProductosPorID(id);

            return View(objetoTipoProductos);
        }
        [HttpPost]
        public ActionResult DeleteTipoProducto(TipoProductos objetoTipoProductos)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();

            bool banderaEliminar = TipoProductosDB.eliminarTipoProducto(objetoTipoProductos.idTipoProducto);

            MostrarMensajes(banderaEliminar);

            return RedirectToAction("Index");
        }


        public void cargarDatosIniciales()
        {
            //Inicio Lista CatalogoProductos
            List<CatalogoProductos> listaCatalogoProductos = CatalogoProductosDB.recuperarListaCatalogoProductos();
            SelectList listaSelectCatalogoProductos = new SelectList(listaCatalogoProductos, "idCatalogoProducto", "CatalogoProducto");
            ViewBag.ListaCatalogoProductos = listaSelectCatalogoProductos;
            //Fin Lista Lista CatalogoProductos
        }//cargarDatosIniciales

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