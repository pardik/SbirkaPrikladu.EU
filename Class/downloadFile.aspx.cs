using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class downloadFile : System.Web.UI.Page
    {
        string filePath { get { return Request.QueryString["filePath"].ToString().Trim(); } }
        string fileName { get { return Request.QueryString["fileName"].ToString().Trim(); } }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (Request.QueryString["fileType"].ToString())
            {
                case "pdf": downloadPDF(); break;
            }            
        }

        protected void downloadPDF()
        {
            Response.ContentType = "Application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.TransmitFile(Server.MapPath(filePath));
            Response.End();
        }
    }
}