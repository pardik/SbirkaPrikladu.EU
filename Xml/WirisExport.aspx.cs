using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Xml
{
    public partial class WirisExport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            header1.Visible = false;
            Response.ContentType = "text/xml; charset=utf-8";

            using (var dbo = new dboManager())
            {
                Response.Write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
                Response.Write("<speu>\r\n");
                dbo.command.CommandText = "SELECT * FROM [examples]";
                var reader = dbo.command.ExecuteReader();
                while (reader.Read())
                {
                    Response.Write("<question type=\"essay\">\r\n");
                    Response.Write("<id>" + reader["id"] + "</id>\r\n");
                    Response.Write("<name><text>" + reader["name"] + "</text></name>\r\n");
                    
                    Response.Write("<questiontext format=\"html\"><text>");
                    if (!string.IsNullOrEmpty(reader["enter"].ToString())) Response.Write("<![CDATA[" + reader["enter"].ToString().Replace("src=\"/","src=\"http://sbirkaprikladu.eu/") + "]]>");
                    Response.Write("</text></questiontext>\r\n");

                    Response.Write("<solution><text>");
                    if (!string.IsNullOrEmpty(reader["solution"].ToString())) Response.Write("<![CDATA[" + reader["solution"].ToString().Replace("src=\"/", "src=\"http://sbirkaprikladu.eu/") + "]]>");
                    Response.Write("</text></solution>\r\n");

                    Response.Write("<answer fraction=\"0\"><text>");
                    if (!string.IsNullOrEmpty(reader["result"].ToString())) Response.Write("<![CDATA[" + reader["result"].ToString().Replace("src=\"/", "src=\"http://sbirkaprikladu.eu/") + "]]>");
                    Response.Write("</text></answer>\r\n");

                    Response.Write("</question>\r\n");
                }
            }

            Response.Write("</speu>\r\n");

        }
    }
}