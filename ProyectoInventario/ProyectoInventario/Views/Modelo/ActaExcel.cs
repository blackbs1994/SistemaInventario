using AccesoDatos.Modelo;
using OfficeOpenXml;
using OfficeOpenXml.Drawing;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

namespace ProyectoInventario.Views.Modelo
{
    public class ActaExcel
    {
        int rowIndex = 1;
        ExcelRange cell;
#pragma warning disable CS0169 // The field 'ActaExcel.fill' is never used
        ExcelFill fill;
#pragma warning restore CS0169 // The field 'ActaExcel.fill' is never used
        Border border;

        public byte[] GenerarExcelActas(ActasProductosUsuarios objetoActas)
        {
            using(var excelPackage = new ExcelPackage())
            {
                var sheet = excelPackage.Workbook.Worksheets.Add("Acta " + objetoActas.IdActasProductosUsuarios);
                sheet.Name = "Acta " + objetoActas.IdActasProductosUsuarios;

                try
                {
                    Image imagen = Image.FromFile(@"D:\andres\Source\Workspaces\SistemaInventario\ProyectoInventario\ProyectoInventario\Images\Logo_secob.jpg");
                    //Image imagen = Image.FromFile("../../Images/Logo_secob.jpg");
                    ExcelPicture excelPicture = sheet.Drawings.AddPicture("Logo_secob", imagen);
                    excelPicture.SetPosition(0, 0, 0, 0);
                }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
                catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
                {
                }


                sheet.Column(1).Width = 15;//A
                sheet.Column(2).Width = 10;//B
                sheet.Column(3).Width = 29;//C
                sheet.Column(4).Width = 35;//D
                sheet.Column(4).Width = 17;//E
                sheet.Column(4).Width = 16;//F
                sheet.Column(4).Width = 12;//G
                sheet.Column(4).Width = 11;//H

                #region Cabecera
                //Número de Acta
                sheet.Cells[rowIndex , 7, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 7];
                cell.Value = "ACTA Nº "+objetoActas.IdActasProductosUsuarios;
                cell.Style.Font.Bold = true;                
                cell.Style.Font.Size = 12;

                //Fecha
                rowIndex = 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Quito a "+DateTime.Now.ToString("dd")+" DE "+ DateTime.Now.ToString("MMM").ToUpper()+" DE "+ DateTime.Now.ToString("yyyy");
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                cell.Style.Font.Bold = true;
                cell.Style.Font.Size = 12;

                //Titulo Principal
                rowIndex = 4;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "ACTA DE ENTREGA RECEPCIÓN  DE BIENES DE LARGA DURACIÓN Y BIENES SUJETOS DE CONTROL";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                //Titulo Gerencia
                rowIndex = 5;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "GERENCIA ADMINISTRATIVA FINANCIERA";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                //Titulo Gerencia
                rowIndex = 6;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "BIENES VIGENTES POR CUSTODIO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;
                #endregion

                #region Datos Funcionario
                rowIndex = 8;
                
                cell = sheet.Cells[rowIndex, 1,9,8];
                //fill = cell.Style.Fill;
                //fill.PatternType = ExcelFillStyle.Solid;
                //fill.BackgroundColor.SetColor(Color.LightGray);
                border = cell.Style.Border;
                border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                sheet.Cells[rowIndex, 1, rowIndex, 2].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "CÉDULA:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 3, rowIndex, 4].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = objetoActas.Usuarios.Cedula;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                //sheet.Cells[rowIndex, 6, rowIndex, 7].Merge = true;
                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "DEPENDENCIA:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 6, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 6];
                cell.Value = objetoActas.Usuarios.Departamentos.Departamento;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex = 9;
                sheet.Cells[rowIndex, 1, rowIndex, 2].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "RESPONSABLE:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 3, rowIndex, 4].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = objetoActas.Usuarios.Nombres + " " + objetoActas.Usuarios.Apellidos;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "UBICACIÓN:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 6, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 6];
                cell.Value = objetoActas.Usuarios.Ubicaciones.Ubicacion;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;
                #endregion

                #region Cabecera Tabla
                rowIndex = 11;

                //cell = sheet.Cells[rowIndex, 1, 9, 8];

                //border = cell.Style.Border;
                //border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                sheet.Row(11).Height = 30;

                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "CÓDIGO PROVISIONAL";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 2];
                cell.Value = "ORIGEN";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 3];
                cell.Value = "DESCRIPCIÓN";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 4];
                cell.Value = "OBSERVACIONES";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "SERIE";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 6];
                cell.Value = "MODELO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 7];
                cell.Value = "MARCA";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 8];
                cell.Value = "COSTO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;
                #endregion

                #region Descripcion Productos
                cell = sheet.Cells[rowIndex+1, 1, rowIndex+objetoActas.DetalleActaProductos.Count, 8];
                border = cell.Style.Border;
                border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                foreach (var objetoPoducto in objetoActas.DetalleActaProductos)
                {
                    rowIndex += 1;
                    cell = sheet.Cells[rowIndex, 1];
                    cell.Value = objetoPoducto.Productos.codigoSecob;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 2];
                    cell.Value = objetoPoducto.Productos.TipoOrigenes.Origen;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 3];
                    cell.Value = objetoPoducto.Productos.Nombre;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 4];
                    cell.Value = objetoPoducto.Productos.Observacion;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 5];
                    cell.Value = objetoPoducto.Productos.NumeroSerie;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 6];
                    cell.Value = objetoPoducto.Productos.Modelos.Modelo;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 7];
                    cell.Value = objetoPoducto.Productos.Modelos.Marcas.Marca;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 8];
                    cell.Value = objetoPoducto.Productos.CostoAdquisicion;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;
                }

                #endregion

                #region Totales Tabla
                rowIndex += 1;

                sheet.Row(rowIndex).Height = 30;

                sheet.Cells[rowIndex, 1, rowIndex, 3].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "TOTAL BIENES VIGENTES";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 4];
                cell.Value = objetoActas.DetalleActaProductos.Count();
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 5, rowIndex, 7].Merge = true;
                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "TOTAL ACTIVO FIJO Y SUJETO A CONTROL ADMINISTRATIVO:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 8];
                cell.Value = objetoActas.DetalleActaProductos.Sum(x =>x.Productos.CostoAdquisicion);
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;
                #endregion

                #region Pie del Documento
                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Para constancia en fé y de conformidad de lo actuado, suscriben la presente acta de Entrega - Recepción en unidad de acto, las personas anteriormente mencionadas, en original y una copia del mismo tenor.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 2;
                sheet.Cells[rowIndex, 3, rowIndex, 6].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = "RECIBÍ CONFORME ";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                sheet.Row(rowIndex + 1).Height = 40;

                rowIndex += 2;
                sheet.Cells[rowIndex, 3, rowIndex, 6].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = objetoActas.Usuarios.Nombres+" "+objetoActas.Usuarios.Apellidos;
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 3, rowIndex, 6].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = "CUSTODIO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Esta Acta Entrega - Recepción está sujeta a las siguientes cláusulas:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.Font.Size = 12;

                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "1. Los Activos Fijos y Sujetos a Control, descritos en la presente Acta será de exclusiva responsabilidad, buen uso, cuidado y custodia de quien reciba los bienes.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "2. En caso de cambio, retiro, o incremento de bienes, estos deberan ser notificados al Área de Control de Bienes e Inventarios para su actualización.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "3. En caso de pérdida conforme lo establece el Art. 86 del reglamento General Sustitutivo para el manejo y administración de Bienes del Sector Público, deberán notificar al jefe inmediato, quien comunicará a Asesoría Jurídica y a la Dirección Administrativa ";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "4. Conforme establece el Art. 92, del citado reglamento en caso de establecer responsabilidad en su contra, la reposición de los bienes se hará al precio de mercado o en especies de iguales características del bien desaparecido, destruido o inutilizado.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Revisado por: ";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                #endregion

                
                return excelPackage.GetAsByteArray();
            }

            

        }


        public byte[] GenerarExcelBienesPorCustodio(List<Productos> listaProductos, Usuarios objetoUSuario)
        {
            using (var excelPackage = new ExcelPackage())
            {
                var sheet = excelPackage.Workbook.Worksheets.Add("Acta " + objetoUSuario.Cedula);
                sheet.Name = "Acta " + objetoUSuario.Cedula;

                Image imagen = Image.FromFile(@"C:\Logo_secob.jpg");
                //Image imagen = Image.FromFile("../../Images/Logo_secob.jpg");
                ExcelPicture excelPicture = sheet.Drawings.AddPicture("Logo_secob", imagen);
                excelPicture.SetPosition(0, 0, 0, 0);


                sheet.Column(1).Width = 15;//A
                sheet.Column(2).Width = 10;//B
                sheet.Column(3).Width = 29;//C
                sheet.Column(4).Width = 35;//D
                sheet.Column(4).Width = 17;//E
                sheet.Column(4).Width = 16;//F
                sheet.Column(4).Width = 12;//G
                sheet.Column(4).Width = 11;//H

                #region Cabecera
                //Fecha
                rowIndex = 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Quito a " + DateTime.Now.ToString("dd") + " DE " + DateTime.Now.ToString("MMM").ToUpper() + " DE " + DateTime.Now.ToString("yyyy");
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Right;
                cell.Style.Font.Bold = true;
                cell.Style.Font.Size = 12;

                //Titulo Principal
                rowIndex = 4;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "LISTA DE BIENES POR CUSTODIO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                //Titulo Gerencia
                rowIndex = 5;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "GERENCIA ADMINISTRATIVA FINANCIERA";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                //Titulo Gerencia
                rowIndex = 6;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "ACTA DE DESCARGO DE BIENES";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;
                #endregion

                #region Datos Funcionario
                rowIndex = 8;

                cell = sheet.Cells[rowIndex, 1, 9, 8];
                //fill = cell.Style.Fill;
                //fill.PatternType = ExcelFillStyle.Solid;
                //fill.BackgroundColor.SetColor(Color.LightGray);
                border = cell.Style.Border;
                border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                sheet.Cells[rowIndex, 1, rowIndex, 2].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "CÉDULA:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 3, rowIndex, 4].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = objetoUSuario.Cedula;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                //sheet.Cells[rowIndex, 6, rowIndex, 7].Merge = true;
                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "DEPENDENCIA:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 6, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 6];
                cell.Value = objetoUSuario.Departamentos.Departamento;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex = 9;
                sheet.Cells[rowIndex, 1, rowIndex, 2].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "RESPONSABLE:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 3, rowIndex, 4].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = objetoUSuario.Nombres + " " + objetoUSuario.Apellidos;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "UBICACIÓN:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 6, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 6];
                cell.Value = objetoUSuario.Ubicaciones.Ubicacion;
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;
                #endregion

                #region Cabecera Tabla
                rowIndex = 11;

                //cell = sheet.Cells[rowIndex, 1, 9, 8];

                //border = cell.Style.Border;
                //border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                sheet.Row(11).Height = 30;

                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "CÓDIGO PROVISIONAL";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 2];
                cell.Value = "ORIGEN";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 3];
                cell.Value = "DESCRIPCIÓN";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 4];
                cell.Value = "OBSERVACIONES";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "SERIE";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 6];
                cell.Value = "MODELO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 7];
                cell.Value = "MARCA";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 8];
                cell.Value = "COSTO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;
                #endregion

                #region Descripcion Productos
                cell = sheet.Cells[rowIndex + 1, 1, rowIndex + listaProductos.Count, 8];
                border = cell.Style.Border;
                border.Bottom.Style = border.Top.Style = border.Left.Style = border.Right.Style = ExcelBorderStyle.Thin;

                foreach (var objetoPoducto in listaProductos)
                {
                    rowIndex += 1;
                    cell = sheet.Cells[rowIndex, 1];
                    cell.Value = objetoPoducto.codigoSecob;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 2];
                    cell.Value = objetoPoducto.TipoOrigenes.Origen;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 3];
                    cell.Value = objetoPoducto.Nombre;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 4];
                    cell.Value = objetoPoducto.Observacion;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 5];
                    cell.Value = objetoPoducto.NumeroSerie;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 6];
                    cell.Value = objetoPoducto.Modelos.Modelo;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 7];
                    cell.Value = objetoPoducto.Modelos.Marcas.Marca;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;

                    cell = sheet.Cells[rowIndex, 8];
                    cell.Value = objetoPoducto.CostoAdquisicion;
                    cell.Style.Font.Bold = false;
                    cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                    cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                    cell.Style.Font.Size = 12;
                }

                #endregion

                #region Totales Tabla
                rowIndex += 1;

                sheet.Row(rowIndex).Height = 30;

                sheet.Cells[rowIndex, 1, rowIndex, 3].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "TOTAL BIENES VIGENTES";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 4];
                cell.Value = listaProductos.Count();
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                sheet.Cells[rowIndex, 5, rowIndex, 7].Merge = true;
                cell = sheet.Cells[rowIndex, 5];
                cell.Value = "TOTAL ACTIVO FIJO Y SUJETO A CONTROL ADMINISTRATIVO:";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                cell = sheet.Cells[rowIndex, 8];
                cell.Value = listaProductos.Sum(x => x.CostoAdquisicion);
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;
                #endregion

                #region Pie del Documento
                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Para constancia en fé y de conformidad de lo actuado, suscriben la presente acta de Entrega - Recepción en unidad de acto, las personas anteriormente mencionadas, en original y una copia del mismo tenor.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                sheet.Row(rowIndex + 1).Height = 40;

                rowIndex += 2;
                sheet.Cells[rowIndex, 3, rowIndex, 6].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = objetoUSuario.Nombres + " " + objetoUSuario.Apellidos;
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 3, rowIndex, 6].Merge = true;
                cell = sheet.Cells[rowIndex, 3];
                cell.Value = "CUSTODIO";
                cell.Style.Font.Bold = true;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;
                cell.Style.Font.Size = 12;

              
                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "1. Los Activos Fijos y Sujetos a Control, descritos en la presente Acta será de exclusiva responsabilidad, buen uso, cuidado y custodia de quien reciba los bienes.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "2. En caso de cambio, retiro, o incremento de bienes, estos deberan ser notificados al Área de Control de Bienes e Inventarios para su actualización.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "3. En caso de pérdida conforme lo establece el Art. 86 del reglamento General Sustitutivo para el manejo y administración de Bienes del Sector Público, deberán notificar al jefe inmediato, quien comunicará a Asesoría Jurídica y a la Dirección Administrativa ";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 1;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "4. Conforme establece el Art. 92, del citado reglamento en caso de establecer responsabilidad en su contra, la reposición de los bienes se hará al precio de mercado o en especies de iguales características del bien desaparecido, destruido o inutilizado.";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                rowIndex += 2;
                sheet.Cells[rowIndex, 1, rowIndex, 8].Merge = true;
                cell = sheet.Cells[rowIndex, 1];
                cell.Value = "Revisado por: ";
                cell.Style.Font.Bold = false;
                cell.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                cell.Style.VerticalAlignment = ExcelVerticalAlignment.Distributed;
                cell.Style.Font.Size = 12;

                #endregion


                return excelPackage.GetAsByteArray();
            }



        }
    }
}