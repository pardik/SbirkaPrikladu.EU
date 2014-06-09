using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;

namespace SbirkaPrikladuEU
{
    public partial class imgrecompute : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string[] abc = Directory.GetFiles(Server.MapPath("/Files/Wiris/cache"));
            foreach (string a in abc)
            {
                WebClient pomWC = new WebClient();
                Uri pomUri = new Uri("http://localhost:25399/Admin/Examples/verifyWirisImage.aspx?img=" + a.Split('\\')[7]);
                try { pomWC.DownloadData(pomUri); }
                catch { }
            }
        }
    }
}