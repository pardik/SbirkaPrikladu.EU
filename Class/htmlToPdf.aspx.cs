using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;


namespace SbirkaPrikladuEU.Class
{
    public partial class htmlToPdf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            toPdf("http://sbirkaprikladu.eu", "/Chap0101.pdf");
        }

        public bool toPdf(string Url, string outputFilename)
        {
                        
            // get proj no for header
            //Project project = new Project(int.Parse(outputFilename));
            
            var p = new System.Diagnostics.Process();

            p.StartInfo.FileName = Server.MapPath("/wkHtmlToPdf/wkhtmltopdf.exe");

            string switches = "--print-media-type ";
            switches += "--margin-top 4mm --margin-bottom 4mm --margin-right 0mm --margin-left 0mm ";
            switches += "--page-size A4 ";
            switches += "--no-background ";
            switches += "--redirect-delay 100";

            switches = "";
            p.StartInfo.Arguments = Url + " " + Server.MapPath(outputFilename);
            
            //p.StartInfo.UseShellExecute = false; // needs to be false in order to redirect output
            //p.StartInfo.RedirectStandardOutput = true;
            //p.StartInfo.RedirectStandardError = true;
            //p.StartInfo.RedirectStandardInput = true; // redirect all 3, as it should be all 3 or none
            p.StartInfo.WorkingDirectory = Server.MapPath("/wkHtmlToPdf/");

            p.Start();

            // read the output here...
            //string output = p.StandardOutput.ReadToEnd();

            // ...then wait n milliseconds for exit (as after exit, it can't read the output)
            p.WaitForExit(60000);

            // read the exit code, close process
            int returnCode = p.ExitCode;
            p.Close();

            //div.InnerText = output;

            // if 0 or 2, it worked (not sure about other values, I want a better way to confirm this)
            return (returnCode == 0 || returnCode == 2);
        }
    }
}