using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU
{
    public partial class sitemap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            header1.Visible = false;
            Response.ContentType = "text/xml; charset=utf-8";

            using (dboManager dboManager = new dboManager())
            {
                SqlDataReader reader = dboManager.ExecuteQuery("SELECT * FROM [examples] WHERE [status] = 'Active' ORDER BY [lastUpdate] DESC");
                XmlDocument xmlDoc = new XmlDocument();
                XmlNode declaration = xmlDoc.CreateNode(XmlNodeType.XmlDeclaration, null, null);
                xmlDoc.AppendChild(declaration);

                XmlNode urlset = xmlDoc.CreateNode(XmlNodeType.Element, "urlset", "http://www.sitemaps.org/schemas/sitemap/0.9");
                
                while (reader.Read())
                {                    
                    XmlNode url = xmlDoc.CreateNode(XmlNodeType.Element, "url", null);
                    XmlNode loc = xmlDoc.CreateNode(XmlNodeType.Element, "loc", null);
                    loc.InnerXml = "http://www.sbirkaprikladu.eu/p/" + reader["id"].ToString();
                    XmlNode lastmod = xmlDoc.CreateNode(XmlNodeType.Element, "lastmod", null);
                    DateTime lastUpdate = Convert.ToDateTime(reader["lastUpdate"].ToString());
                    lastmod.InnerXml = lastUpdate.ToString("yyyy-MM-dd");
                                        
                    url.AppendChild(loc);
                    url.AppendChild(lastmod);                    
                    urlset.AppendChild(url);                    
                }                
                xmlDoc.AppendChild(urlset);
                Response.Write(xmlDoc.OuterXml.Replace(" xmlns=\"\"", ""));
            }            
        }        
    }
}