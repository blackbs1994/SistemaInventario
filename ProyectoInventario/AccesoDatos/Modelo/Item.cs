using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AccesoDatos.Modelo
{
    public class Item
    {
        public Item()
        {

        }

        public Item(string id, string value)
        {
            this.id = id;
            this.value = value;
        }

        public string id { get; set; }

        public string value { get; set; }
    }
}