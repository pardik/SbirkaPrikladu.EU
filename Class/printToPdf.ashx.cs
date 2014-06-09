using System.Collections.Generic;
using System.Linq;
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

namespace SbirkaPrikladuEU.Class
{
    public class printToPdf : IHttpHandler
    {
        
        public void ProcessRequest(HttpContext context)
        {
            string fileName = Guid.NewGuid().ToString();
            string htmlText = context.Request.Form["html"].ToString();
            htmlText = htmlText.Replace("http://www.sbirkaprikladu.eu/ckeditor/plugins/ckeditor_wiris/integration/showimage.php?formula=", "http://sbirkaprikladu.eu/Files/Wiris/Cache/");
            htmlText = htmlText.Replace("/ckeditor/plugins/ckeditor_wiris/integration/showimage.php?formula=", "http://sbirkaprikladu.eu/Files/Wiris/Cache/");
            htmlText = htmlText.Replace("/Files/UserUploadFiles/", "http://sbirkaprikladu.eu/Files/UserUploadFiles/");
            string cssStyles = "<style type=\"text/css\">.fL { float: left; } .fR { float: right; } .clear { clear: both; } .toL { text-align: left; } .toC { text-align: center; } .toR { text-align: right; }";

            using (StreamReader cssReader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("/App_Themes/Gray/BootStrap/css/bootstrap.css")))
            {
                cssStyles += cssReader.ReadToEnd();                
            }
            using (StreamReader cssReader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("/App_Themes/Gray/BootStrap/css/bootstrap-responsive.css")))
            {
                cssStyles += cssReader.ReadToEnd();
            }
            using (StreamReader cssReader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("/App_Themes/print.less.css")))
            {
                cssStyles += cssReader.ReadToEnd();
            }
            cssStyles += ".label {text-shadow: 0 0 0 rgba(0, 0, 0, 0) !important;} ";
            cssStyles += " #printModalPN { display: none !important; } ";
            cssStyles += "</style>";

            using (StreamWriter htmlFile = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("/Files/Temp/" + fileName + ".html"), false, System.Text.Encoding.UTF8))
            {
                htmlFile.Write("<!DOCTYPE html><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title></title>" + cssStyles + "</head><body>");                
                htmlFile.Write(htmlText);
                htmlFile.Write("</body></html>");
            }

            toPdf("/Files/Temp/" + fileName + ".html", "/Files/Temp/" + fileName + ".pdf");            
            context.Response.Write("/Files/Temp/" + fileName + ".pdf");
        }

        public bool toPdf(string Url, string outputFilename)
        {
            var p = new System.Diagnostics.Process();
            p.StartInfo.FileName = System.Web.HttpContext.Current.Server.MapPath("/wkHtmlToPdf/wkhtmltopdf.exe");
            
            string options=" ";            

            p.StartInfo.Arguments = options + " " + System.Web.HttpContext.Current.Server.MapPath(Url) + " " + System.Web.HttpContext.Current.Server.MapPath(outputFilename);
            p.StartInfo.WorkingDirectory = System.Web.HttpContext.Current.Server.MapPath("/wkHtmlToPdf/");
            p.Start();
            p.WaitForExit(60000);
            
            int returnCode = p.ExitCode;
            p.Close();
            
            // if 0 or 2, it worked (not sure about other values, I want a better way to confirm this)
            return (returnCode == 0 || returnCode == 2);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}