using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class MarcaController : Controller
    {
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            List<Marcas> listaMarcas = MarcasDB.recuperarListaMarcas();

            return View(listaMarcas);
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
        public ActionResult Create(Marcas objetoMarcas,string accion)
        {
            MarcasDB objMarcasDB = new MarcasDB();
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }


            if(accion == "guardar_marca")
            {
                if(objMarcasDB.ExisteMarca(objetoMarcas.Marca))
                {
                    ModelState.AddModelError("marca_agregar", "La caracteristica ingresada ya existe");
                    return View("Create");
                }
                else
                {
                    bool banderaGuardar = MarcasDB.guardarMarcas(objetoMarcas);
                    MostrarMensajes(banderaGuardar);
                }

            }
            else
            {
                throw new Exception("Accion no definida..");
            }
            return RedirectToAction("Index");

        }

        public ActionResult EditarMarca(int idMarca)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Marcas objetoMarca = MarcasDB.recuperarMarcasPorID(idMarca);


            return View(objetoMarca);
        }

        [HttpPost]
        public ActionResult EditarMarca(Marcas objetoMarca)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = MarcasDB.actualizarMarcas(objetoMarca);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }

        public ActionResult DetalleMarca(int idMarca)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Marcas objetoMarca = MarcasDB.recuperarMarcasPorID(idMarca);


            return View(objetoMarca);
        }

        public ActionResult EliminarMarca(int idMarca)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Marcas objetoMarca = MarcasDB.recuperarMarcasPorID(idMarca);


            return View(objetoMarca);
        }

        [HttpPost]
        public ActionResult EliminarMarca(Marcas objetoMarca)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = MarcasDB.eliminarMarcas(objetoMarca.idMarca);

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