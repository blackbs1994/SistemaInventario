using AccesoDatos;
using AccesoDatos.Commons;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AccesoDatos.Gesionar;
using Helper;
using AccesoDatos.Modelo;

namespace AccesoDatos.Commons
{
    public class FrontUser
    {
        public static bool TienePermiso(RolesPermisos valor)
        {
            var usuario = FrontUser.Get();
            return !usuario.Perfiles.Permiso.Where(x => x.idPermiso == Convert.ToInt32(valor))
                                    .Any();

        }

        public static Usuarios Get()
        {
            return new UsuariosDB().Obtener(SessionHelper.GetUser());
        }
    }
}