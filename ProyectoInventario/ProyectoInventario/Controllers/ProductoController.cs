using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class ProductoController : Controller
    {

        public ActionResult Index()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            List<Productos> listaProductos = ProductosDB.recuperarListaProductos();
            return View(listaProductos);
        }

        [HttpGet]
        public ActionResult ObtenerCaracteristicas()
        {
            List<Caracteristicas> listaCaracteristicas = CaracteristicasDB.recuperarListaCaracteristicas();
            return View(listaCaracteristicas);
        }
        [HttpGet]
        public ActionResult Create()
        {
            cargaInicial();
            return View();

        }
        [HttpPost]
        public ActionResult Create(Productos objetoProductos, int[] caracteristicaAnadirProducto)
        {
            ProductosDB objProductoDB = new ProductosDB();
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }


            cargaInicial();
            List<DetalleProductos> listaDetalleProductos = new List<DetalleProductos>();
            foreach (var idDetalleProductoCaracteristica in caracteristicaAnadirProducto)
            {
                DetalleProductos objetoDetalleProductos = new DetalleProductos();
                objetoDetalleProductos.idCaracteristica = idDetalleProductoCaracteristica;
                listaDetalleProductos.Add(objetoDetalleProductos);
            }
            try
            {
                objetoProductos.DetalleProductos = listaDetalleProductos;
                bool banderaCrear = ProductosDB.guardarProductos(objetoProductos);

                MostrarMensajes(banderaCrear);
            }
            catch(Exception)
            {
                throw new Exception("Accion no definida..");
            }

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult Update(int id)
        {
            var objetoProductos = ProductosDB.recuperarProductosPorID(id);

            cargaInicial(objetoProductos.Modelos.idMarca);

            return View(objetoProductos);

        }
        [HttpPost]
        public ActionResult Update(Productos objetoProductos, int[] caracteristicaAnadirProducto)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargaInicial();
            List<DetalleProductos> listaDetalleProductos = new List<DetalleProductos>();
            foreach (var idDetalleProductoCaracteristica in caracteristicaAnadirProducto)
            {
                DetalleProductos objetoDetalleProductos = new DetalleProductos();
                objetoDetalleProductos.idCaracteristica = idDetalleProductoCaracteristica;
                objetoDetalleProductos.idProducto = objetoProductos.idProducto;
                listaDetalleProductos.Add(objetoDetalleProductos);
            }

            objetoProductos.DetalleProductos = listaDetalleProductos;
            bool banderaActualizar = ProductosDB.actualizarProductos(objetoProductos);

            MostrarMensajes(banderaActualizar);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult DeleteProducto(int id)
        {
            var objetoProductos = ProductosDB.recuperarProductosPorID(id);

            cargaInicial(objetoProductos.Modelos.idMarca);

            return View(objetoProductos);
        }
        [HttpPost]
        public ActionResult DeleteProducto(Productos objetoProductos)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            cargaInicial();
            bool banderaEliminar = ProductosDB.eliminarProducto(objetoProductos.idProducto);

            MostrarMensajes(banderaEliminar);

            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult FindProducto(int id)
        {


            var objetoProductos = ProductosDB.recuperarProductosPorID(id);

            cargaInicial(objetoProductos.Modelos.idMarca);

            return View(objetoProductos);
        }

        [HttpPost]
        public ActionResult FindProductoPorTipoBusqueda(string tipoBusqueda, string datoBusqueda)
        {

            List<Productos> listaProductos = new List<Productos>();
            datoBusqueda = datoBusqueda.Trim();
            switch (tipoBusqueda)
            {
                case "Serie":
                    listaProductos = ProductosDB.recuperarListaProductoPorNumeroSerie(datoBusqueda);
                    break;
                case "CodigFinanzas":
                    listaProductos = ProductosDB.recuperarProductoPorCodigoFinanzas(datoBusqueda);
                    break;
                case "CodigoSecob":
                    listaProductos = ProductosDB.recuperarProductoPorCodigoSecob(datoBusqueda);
                    break;
            }

            if (listaProductos.Count() <= 0)
            {
                TempData["mensajeProductoActaNoEncontrado"] = "No se encontró el producto " + datoBusqueda;
            }
            else
            {
                foreach (var objetoProductoTemporal in listaProductos)
                {
                    DetalleActaProductos objetoDetalleProducto = DetalleProductosDB.recuperarDetalleActaProducto(objetoProductoTemporal.idProducto);

                    if (objetoDetalleProducto != null)
                    {
                        var objetoUsuarioTemporal = objetoDetalleProducto.ActasProductosUsuarios.Usuarios;
                        string mensajeTemporal = "El producto que esta añadiendo ya se encuentra asignado a otro funcionario: " + objetoUsuarioTemporal.Nombres + " " + objetoUsuarioTemporal.Apellidos + ", con identificación: " + objetoUsuarioTemporal.Cedula + ". Si generá el acta con este producto, este prodcuto se eliminará de su cedula censal.";
                        TempData["productoYaExsiste"] = mensajeTemporal;
                        break;
                    }
                    else
                    {
                        TempData["productoYaExsiste"] = "";
                    }
                }


            }

            return View("DetalleProductoActa", listaProductos);
        }


        [HttpPost]
        public ActionResult EncontrarActivosPorIdentificacion(string numeroIdentificacion)
        {
            List<Productos> listaProductos = new List<Productos>();

            listaProductos = ActasDB.recuperarActasProductosPorIdentificacionUsuario(numeroIdentificacion);

            if (listaProductos.Count() <= 0)
            {
                TempData["mensajeProductoActaNoEncontrado"] = "No se encontró el productos para el número de identificación ingresado.";
            }

            TempData["numeroIdentificacion"] = numeroIdentificacion;
            return View("DetalleProductoActaCustodio", listaProductos);
        }



        public void cargaInicial(int? idMarca = 0)
        {
            List<TipoOrigenes> dataTipoOrigenes = TipoOrigenesDB.recuperarListaTipoOrigenes();
            SelectList listaTipoOrigenes = new SelectList(dataTipoOrigenes, "idTipoOrigen", "Origen");
            ViewBag.ListaTipoOrigenes = listaTipoOrigenes;


            List<Marcas> dataMarcas = MarcasDB.recuperarListaMarcas();
            SelectList listaMarcas = new SelectList(dataMarcas, "idMarca", "Marca", idMarca);
            ViewBag.ListaMarcas = listaMarcas;


            List<Modelos> dataModelos = ModelosDB.recuperarListaModelos();
            SelectList listaModelos = new SelectList(dataModelos, "idModelo", "Modelo");
            ViewBag.ListaModelos = listaModelos;

            List<TipoProductos> dataTipoProductos = TipoProductosDB.recuperarListaTipoProductos();
            SelectList listaTipoProductos = new SelectList(dataTipoProductos, "idTipoProducto", "TipoProducto");
            ViewBag.ListaTipoProductos = listaTipoProductos;

            List<Caracteristicas> listaCaracteristicas = CaracteristicasDB.recuperarListaCaracteristicas();
            ViewBag.listaCaracteristicas = listaCaracteristicas;
            ViewBag.ListaTipoProductos = listaTipoProductos;
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

    }
}