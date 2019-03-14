using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace ProyectoInventario.Controllers
{
    public class DepartamentoController : Controller
    {       

        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            Departamentos objetoDepartamentos = new Departamentos();
            List<Departamentos> listaDepartamentos = DepartamentosDB.recuperarListaDepartamentos();
            
            return View(listaDepartamentos);
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
        public ActionResult Create(Departamentos objetoDepartamento, string accion)
        {
            DepartamentosDB objDepartamentosDB = new DepartamentosDB();
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            if (accion == "guardar_departamento")
            {
                if(objDepartamentosDB.ExisteDepartamento(objetoDepartamento.Departamento))
                {
                    ModelState.AddModelError("departamento_agregar", "La caracteristica ingresada ya existe");
                    return View("Create");
                }
                else
                {
                    bool banderaGuardar = DepartamentosDB.guardarDepartamentos(objetoDepartamento);

                    MostrarMensajes(banderaGuardar);
                }
            }
            else
            {
                throw new Exception("Accion no definida..");
            }
            return RedirectToAction("Index");

        }


        public ActionResult EditarDepartamento(int idDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            Departamentos objetoDepartamento = DepartamentosDB.recuperarDepartamentoPorID(idDepartamento);


            return View(objetoDepartamento);
        }

        [HttpPost]
        public ActionResult EditarDepartamento(Departamentos objetoDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            bool bandera = DepartamentosDB.actualizarDepartamento(objetoDepartamento);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }

        public ActionResult DetalleDepartamento(int idDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            Departamentos objetoDepartamento = DepartamentosDB.recuperarDepartamentoPorID(idDepartamento);


            return View(objetoDepartamento);
        }

        public ActionResult EliminarDepartamento(int idDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }
            cargarDatosIniciales();
            Departamentos objetoDepartamento = DepartamentosDB.recuperarDepartamentoPorID(idDepartamento);


            return View(objetoDepartamento);
        }

        [HttpPost]
        public ActionResult EliminarDepartamento(Departamentos objetoDepartamento)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = DepartamentosDB.eliminarDepartamento(objetoDepartamento.idDepartamento);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");

        }


        public void cargarDatosIniciales()
        {
            List<TipoDepartamentos> dataTipoDepartamentos = TipoDepartamentosDB.recuperarListaTipoDepartamentos();
            SelectList listaTipoDepartamentos = new SelectList(dataTipoDepartamentos, "idTipo_Departamento", "TipoDepartamento");
            ViewData["ListaTipoDepartamentos"]= listaTipoDepartamentos;
            
            //Fin Lista Departamentos
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