using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;

namespace ProyectoInventario.Controllers
{
    public class TipoDepartamentoController : Controller
    {
        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            List<TipoDepartamentos> listaTipoDepartamentos = TipoDepartamentosDB.recuperarListaTipoDepartamentos();
            
            return View(listaTipoDepartamentos);
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
        public ActionResult Create(TipoDepartamentos objetoCararcteristicas)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            bool banderaGuardar = TipoDepartamentosDB.guardarTipoDepartamentos(objetoCararcteristicas);

            MostrarMensajes(banderaGuardar);
            return View();
        }

        public ActionResult EditarTipoDepartamento(int idTipo_Departamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            TipoDepartamentos objetoTipoDepartamento = TipoDepartamentosDB.recuperarTipoDepartamentoPorID(idTipo_Departamento);


            return View(objetoTipoDepartamento);
        }

        [HttpPost]
        public ActionResult EditarTipoDepartamento(TipoDepartamentos objetoTipoDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera= TipoDepartamentosDB.actualizarTipoDepartamento(objetoTipoDepartamento);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }

        public ActionResult DetalleTipoDepartamento(int idTipo_Departamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            TipoDepartamentos objetoTipoDepartamento = TipoDepartamentosDB.recuperarTipoDepartamentoPorID(idTipo_Departamento);


            return View(objetoTipoDepartamento);
        }

        public ActionResult EliminarTipoDepartamento(int idTipo_Departamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            TipoDepartamentos objetoTipoDepartamento = TipoDepartamentosDB.recuperarTipoDepartamentoPorID(idTipo_Departamento);


            return View(objetoTipoDepartamento);
        }

        [HttpPost]
        public ActionResult EliminarTipoDepartamento(TipoDepartamentos objetoTipoDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = TipoDepartamentosDB.eliminarTipoDepartamento(objetoTipoDepartamento.idTipo_Departamento);

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