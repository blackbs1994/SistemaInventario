using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using Helper;

namespace ProyectoInventario.Controllers
{
    public class UsuarioController : Controller
    {
        private Usuarios usuario = new Usuarios();
        public ActionResult CerrarSesion()
        {
            Session.RemoveAll();

            return RedirectToAction("Index", "Inicio");
        }//CerrarSesion

        public ActionResult IniciarSesion()
        {
            return View();
        }

        [HttpPost]
        public ActionResult IniciarSesion(string nombreUsuario, string contrasena)
        {

            usuario = UsuariosDB.validarInicioSesion(nombreUsuario, contrasena);

            if (usuario!=null)
            {
                Session["usuarioSesion"] = usuario;
                return RedirectToAction("Index", "Inicio");
            }

            TempData["MensajeErrorIngreso"] = "Usuario y/o contraseña incorrectos.";

            return View();
        }

        // GET: Usuario
        public ActionResult Index()
        {
            cargarDatosIniciales();
            List<Usuarios> listaUsuarios = UsuariosDB.recuperarListaUsuarios();
            return View(listaUsuarios);
        }
        public ActionResult IndexCustodio()
        {
            cargarDatosIniciales();
            List<Usuarios> listausuarios = UsuariosDB.recuperarListaUsuarios();
            return View(listausuarios);
        }
        [HttpGet]
        public ActionResult Create()
        {
            cargarDatosIniciales();
            
            return View();
        }
        [HttpPost]

        public ActionResult Create(Usuarios objetoUsuarios, string accion)
        {
            UsuariosDB objUsuariosDB = new UsuariosDB();
            int cedula = Convert.ToInt32(objetoUsuarios.Cedula);
            
            cargarDatosIniciales();
            bool baderaValidar = CedulaHelper.validarNumeroCedula(objetoUsuarios.Cedula);

            if ( accion == "guardar_usuario")
            {
                if (objUsuariosDB.ExisteUsuario(objetoUsuarios.Usuario))
                {
                    ModelState.AddModelError("usuario_agregar", "El usuario ingresado ya existe");
                    return View("Create");
                }
                
                if (objUsuariosDB.ExisteCedula(objetoUsuarios.Cedula))
                {
                    ModelState.AddModelError("cedula_agregar", "La cédula ingresada ya existe");
                    return View("Create");
                }

                if (cedula < 10)
                {
                    ModelState.AddModelError("cedula_agregar", "La cédula ingresada debe tener 10 digitos");
                    return View("Create");
                }
                if (baderaValidar == false)
                {
                    ModelState.AddModelError("cedula_agregar", "La cédula ingresada es incorrecta");
                    return View("Create");
                }
                else
                {
                    objetoUsuarios.Contrasenia = HashHelper.MD5(objetoUsuarios.Contrasenia);
                    bool banderaGuardar = UsuariosDB.guardarUsuarios(objetoUsuarios);
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
        public ActionResult CreateCustodio()
        {
            cargarDatosIniciales();

            return View();
        }

        [HttpPost]
        public ActionResult CreateCustodio (Usuarios objetoUsuarios, string accion)
        {
            UsuariosDB objUsuariosDB = new UsuariosDB();

            cargarDatosIniciales();
            bool baderaValidar = CedulaHelper.validarNumeroCedula(objetoUsuarios.Cedula);
            if (accion == "guardar_usuario_custodio")
            {
               
                 if (objUsuariosDB.ExisteCedula(objetoUsuarios.Cedula))
                {
                    ModelState.AddModelError("cedula_agregar", "La cédula ingresada ya existe");
                    return View("CreateCustodio");
                }
                if (objetoUsuarios.Perfiles == null)
                {
                    objetoUsuarios.idPerfil = 4;

                }
                if (objetoUsuarios.Activar == null)
                {
                    objetoUsuarios.Activar = 0;
                }
                if (objetoUsuarios.Contrasenia == null)
                {
                    string contrasenadefecto = "123456789";
                    objetoUsuarios.Contrasenia = contrasenadefecto;
                }                
                if (baderaValidar == false)
                {
                    ModelState.AddModelError("cedula_agregar", "La cédula ingresada es incorrecta");
                    return View("CreateCustodio");
                }
                else
                {
                    
                    
                        objetoUsuarios.Contrasenia = HashHelper.MD5(objetoUsuarios.Contrasenia);
                        bool banderaGuardar = UsuariosDB.guardarUsuarios(objetoUsuarios);
                        MostrarMensajes(banderaGuardar);                    
                    
                }
            }
            else
            {
                throw new Exception("Accion no definida..");
            }

            return RedirectToAction("IndexCustodio");

        }

        [HttpGet]
        public ActionResult Update(int id)
        {
            var objetoUsuarios = UsuariosDB.recuperarUsuariosPordID(id);

            cargarDatosIniciales();

            return View(objetoUsuarios);

        }
        [HttpPost]
        public ActionResult Update(Usuarios objetoUsuarios, int[] caracteristicaAnadirProducto)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();            
            bool banderaActualizar = UsuariosDB.actualizarUsuarios(objetoUsuarios);

            MostrarMensajes(banderaActualizar);

            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult UpdateCustodio(int id)
        {
            var objetoUsuarios = UsuariosDB.recuperarUsuariosPordID(id);

            cargarDatosIniciales();

            return View(objetoUsuarios);

        }
        [HttpPost]
        public ActionResult UpdateCustodio(Usuarios objetoUsuarios, int[] caracteristicaAnadirProducto)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargarDatosIniciales();
            bool banderaActualizar = UsuariosDB.actualizarUsuarios(objetoUsuarios);

            MostrarMensajes(banderaActualizar);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Delete (int id)
        {
            cargarDatosIniciales();
            Usuarios objetoTipoUsuarios = UsuariosDB.recuperarUsuariosPordID(id);

            return View(objetoTipoUsuarios);
        }

        [HttpPost]
        public ActionResult Delete (Usuarios objetoUsuarios)
        {

            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            bool bandera = UsuariosDB.eliminarUsuarios(objetoUsuarios.idUsuario);

            MostrarMensajes(bandera);

            return RedirectToAction("Index");
        }
        [HttpGet]
        public ActionResult FindUsuario(int id)
        {
            var objetousuario = UsuariosDB.recuperarUsuariosPordID(id);
            cargarDatosIniciales();
            return View(objetousuario);
        }

        public void cargarDatosIniciales()
        {
            List<Perfiles> dataPerfiles = PerfilesDB.recuperarListaPerfiles();
            SelectList listaPerfiles = new SelectList(dataPerfiles, "idPerfil", "Perfil");
            ViewBag.ListaPerfiles = listaPerfiles;

            List<Departamentos> listaDepartamentos = DepartamentosDB.recuperarListaDepartamentos();
            SelectList listaSelectDepartamentos = new SelectList(listaDepartamentos, "idDepartamento", "Departamento");
            ViewBag.ListaDepartamentos = listaSelectDepartamentos;
            //Fin Lista Departamentos
            //Inicio Lista Ubicacion

            List<Ubicaciones> listaUbicaciones = UbicacionesDB.recuperarListaUbicaciones();
            SelectList listaSelectUbicaciones = new SelectList(listaUbicaciones, "idUbicacion", "Ubicacion");
            ViewBag.ListaUbicaciones = listaSelectUbicaciones;
            //Fin Lista Ubicacion
            //fin Listas
        }//cargarDatosIniciales

        [HttpPost]
        public ActionResult busarUsuario(string numeroCedula)
        {
            cargarDatosIniciales();
            Usuarios objetoUusario = UsuariosDB.recuperarUsuarioPorCedula(numeroCedula);

            return View("DetalleUsuario", objetoUusario);
        }
       

        public ActionResult DetalleUsuario(Usuarios objetoUsuario)
        {
            cargarDatosIniciales();
            return View(objetoUsuario);
        }
        public ActionResult DetalleUsuariotabla(Usuarios objetoUsuario)
        {
            cargarDatosIniciales();
            return View(objetoUsuario);
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

    }
}