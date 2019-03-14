using AccesoDatos.Gesionar;
using AccesoDatos.Modelo;
using ProyectoInventario.Views.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoInventario.Controllers
{
    public class ActaController : Controller
    {
        // GET: Acta
        public ActionResult GenerarActa()
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            return View();
        }//GenerarActa

        [HttpPost]
        public ActionResult GenerarActa(int[] productosAniadirFinal, int idUsuarioResponsable)
        {
            Usuarios usuarioSesionActual = (Usuarios)Session["usuarioSesion"];
            if (usuarioSesionActual == null)
            {
                return RedirectToAction("IniciarSesion", "Usuario");
            }

            ActasProductosUsuarios objetoActa = new ActasProductosUsuarios();

            objetoActa.idUsuario = idUsuarioResponsable;
            objetoActa.fechaCreacion = DateTime.Now;
            bool banderaGuardarActa = false;
            bool banderaGuardar =AniadirObjetoDB.guardarObjetoDB(objetoActa);

            if (banderaGuardar)
            {
                foreach (int idProducto in productosAniadirFinal)
                {
                    if (ActasDB.recuperarDetalleActaProductosPorIDProducto(idProducto))
                    {
                        bool banderaEliminar = ActasDB.eliminarDetalleActaProductosPorIDProducto(idProducto);
                    }
                    DetalleActaProductos objetoDetalleActas = new DetalleActaProductos();
                    objetoDetalleActas.idProducto = idProducto;
                    objetoDetalleActas.IdActasProductosUsuarios = objetoActa.IdActasProductosUsuarios;

                    //listaDetallesActas.Add(objetoDetalleActas);
                    banderaGuardarActa = AniadirObjetoDB.guardarObjetoDB(objetoDetalleActas);
                }//foreach
            }//if            

            return RedirectToAction("generarActaExcel","Acta", new { idobjetoActa = objetoActa.IdActasProductosUsuarios });

        }//GenerarActa

        public void generarActaArchivoExcel(int idobjetoActa)
        {
            ActasProductosUsuarios objetoActaProductoUsuario = ActasDB.recuperarActasProductosUsuariosPorID(idobjetoActa);

            ActaExcel objetoActaExcel = new ActaExcel();

            Response.ClearContent();
            Response.BinaryWrite(objetoActaExcel.GenerarExcelActas(objetoActaProductoUsuario));
            Response.AddHeader("content-disposition", "attachment; filename=NuevaActa" + objetoActaProductoUsuario.IdActasProductosUsuarios + ".xlsx");
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.Flush();
            Response.End();

        }



        [HttpPost]
        public ActionResult generarActaDescargo(int[] listaProductosSeleccionados, string numeroIdentificacionCustodio, bool actaDescargoExcel)
        {
            List<Productos> listaProductos = new List<Productos>();

            TempData["objetoUsuario"] = UsuariosDB.recuperarUsuarioPorCedula(numeroIdentificacionCustodio);

            foreach (int idProducto in listaProductosSeleccionados)
            {
                Productos objetoProducto = ProductosDB.recuperarProductosPorID(idProducto);
                listaProductos.Add(objetoProducto);
                bool banderaEliminar = ActasDB.eliminarDetalleActaProductosPorIDProducto(Convert.ToInt32(idProducto));
            }

            if (actaDescargoExcel)
            {
                generarArchivoActaEliminarExcelPorCustodio(listaProductos, numeroIdentificacionCustodio);

                return View(listaProductos);
            }
            else
            {
                TempData["listaProductosTemporal"] = listaProductos;
                return View("generarActaDescargo", listaProductos);
            }
        }

        public ActionResult generarActaDescargo()
        {
            List<Productos> listaProductos = (List<Productos>)TempData["listaProductosTemporal"];

            TempData["listaProductosTemporal"] = listaProductos;

            return View(listaProductos);
        }

        public void generarArchivoActaEliminarExcelPorCustodio(List<Productos> listaProductos, string numeroIdentificacion)
        {

            Usuarios objetoUsuario = UsuariosDB.recuperarUsuarioPorCedula(numeroIdentificacion);

            ActaExcel objetoActaExcel = new ActaExcel();

            Response.ClearContent();
            Response.BinaryWrite(objetoActaExcel.GenerarExcelBienesPorCustodio(listaProductos,objetoUsuario));
            Response.AddHeader("content-disposition", "attachment; filename=Bienes_" +numeroIdentificacion + ".xlsx");
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.Flush();
            Response.End();
        }

        public void generarArchivoExcelPorCustodio(string numeroIdentificacion)
        {
            List<Productos> listaProductos = new List<Productos>();

            listaProductos = ActasDB.recuperarActasProductosPorIdentificacionUsuario(numeroIdentificacion);
            Usuarios objetoUsuario = UsuariosDB.recuperarUsuarioPorCedula(numeroIdentificacion);

            ActaExcel objetoActaExcel = new ActaExcel();

            Response.ClearContent();
            Response.BinaryWrite(objetoActaExcel.GenerarExcelBienesPorCustodio(listaProductos, objetoUsuario));
            Response.AddHeader("content-disposition", "attachment; filename=Bienes_" + numeroIdentificacion + ".xlsx");
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.Flush();
            Response.End();
        }




        public ActionResult generarActaExcel(int idobjetoActa)
        {
            ActasProductosUsuarios objetoActaProductoUsuario = ActasDB.recuperarActasProductosUsuariosPorID(idobjetoActa);

            ActaExcel objetoActaExcel = new ActaExcel();

            

            return View(objetoActaProductoUsuario);
        }

        public static List<DetalleActaProductos> recuperarListaDetalleActasProductos()
        {
            inventarioEntidadesDB contextoConexionBusqueda = new inventarioEntidadesDB();
            var listaDetalleActaProductos = contextoConexionBusqueda.DetalleActaProductos.Select(p => p).ToList();

            return listaDetalleActaProductos;
        }
    }//class
}