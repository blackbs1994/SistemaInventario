using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AccesoDatos.Commons
{
    public enum RolesPermisos
    {
        #region Modulo Activos
        Activo_Puede_Crear_Nuevo_Registro = 1,
        Activo_Puede_Eliminar_Registro = 2,
        Activo_Puede_Editar_Registro = 3,
        Activo_Puede_Acceder_Item_Marca = 4,
        Activo_Puede_Acceder_Item_Modelo = 5,
        Activo_Puede_Acceder_Item_Tipo_Caracteristica = 7,
        Activo_Puede_Acceder_Item_Caracteristica = 8,
        Activo_Puede_Acceder_Item_Catalogo_Activos = 9,
        Activo_Puede_Acceder_Item_Tipo_Activos = 10,
        Activo_Puede_Acceder_Item_Activos = 11,    

        #endregion
        #region Administracion
        Administracion_Puede_Crear_Nuevo_Registro = 12,
        Administracion_Puede_Eliminar_Registro = 13,
        Administracion_Puede_Editar_Registro = 14,
        Administracion_Puede_Acceder_Item_Usuarios = 16,
        Administracion_Puede_Acceder_Item_Tipo_Departamento = 17,
        Administracion_Puede_Acceder_Item_Departamento = 18,
        Administracion_Puede_Acceder_Item_Ubicaciones = 19,
        Administracion_Puede_Acceder_Item_Custodios = 26,
 

        #endregion
        #region Actas
        Actas_Puede_Crear_Nuevo_Registro = 20,
        Actas_Puede_Eliminar_Registro = 21,
        Actas_Puede_Imprimir_Registro = 22,
        Actas_Puede_Acceder_Item_Acta_Entrega = 23,
        Actas_Puede_Acceder_Item_Acta_Descargo =24,
        Actas_Puede_Acceder_Item_Consulta = 25,
        #endregion

    }
}
