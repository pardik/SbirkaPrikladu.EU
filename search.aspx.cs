using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU
{
    public partial class search : System.Web.UI.Page
    {        
        public string searchPattern { get { return Request.QueryString["s"]; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!string.IsNullOrEmpty(searchPattern)) goSearch();
            
            TextBox searchTB = (Master.FindControl("searchPN") as UserControl).FindControl("searchTB") as TextBox;
            searchTB.Text = searchPattern;
        }

        protected void goSearch()
        {   
            using (dboManager dboManager = new dboManager())
            {
                string pomStr = searchPattern.Replace("-", " ").Replace(".", " ").Replace(",", " ").Replace("[", " ").Replace("]", " ");
                while (pomStr.Contains("  ")) pomStr = pomStr.Replace("  ", " ");
                string[] pomStrArray = pomStr.Split(' ');

                string result = null;   //search categories
                pomStr = null;
                for (int i = 0; i < pomStrArray.Count(); i++)
                {
                    if (i > 0) pomStr += " OR ";
                    pomStr += "[name] COLLATE Latin1_General_CI_AI LIKE '%' + @search" + i + " + '%' COLLATE Latin1_General_CI_AI";
                    dboManager.command.Parameters.AddWithValue("@search" + i, pomStrArray[i]);
                }
                dboManager.command.Parameters.AddWithValue("@searchPattern", searchPattern);
                dboManager.command.CommandText = "SELECT * FROM [exampleGroups] WHERE " + pomStr;
                SqlDataReader reader = dboManager.command.ExecuteReader();
                while (reader.Read())
                {
                    result += "<li><a href='/g/" + reader["id"].ToString() + "'>" + reader["name"].ToString() + "</a></li>";
                }
                reader.Close();
                if (result != null) { categoriesPNDiv.InnerHtml = "<ul>" + result + "</ul>"; categoriesPN.Visible = true; }
                else categoriesPN.Visible = false;

                result = null;  //search examples
                dboManager.command.CommandText = "SELECT * FROM [examples] WHERE " + pomStr;
                reader = dboManager.command.ExecuteReader();
                while (reader.Read())
                {
                    result += "<li><a href='/p/" + reader["id"].ToString() + "'>" + reader["name"].ToString() + "</a></li>";
                }
                reader.Close();
                if (result != null) { examplesPNDiv.InnerHtml = "<ul>" + result + "</ul>"; examplesPN.Visible = true; }
                else examplesPN.Visible = false;

                result = null;  //search fulltext
                pomStr = null;
                for (int i = 0; i < pomStrArray.Count(); i++)
                {
                    if (i > 0) pomStr += " OR ";
                    pomStr += "[enter] COLLATE Latin1_General_CI_AI LIKE '%' + @search" + i + " + '%' COLLATE Latin1_General_CI_AI OR [solution] COLLATE Latin1_General_CI_AI LIKE '%' + @search" + i + " + '%' COLLATE Latin1_General_CI_AI OR [result] COLLATE Latin1_General_CI_AI LIKE '%' + @search" + i + " + '%' COLLATE Latin1_General_CI_AI";                    
                }
                dboManager.command.CommandText = "SELECT * FROM [examples] WHERE " + pomStr;
                reader = dboManager.command.ExecuteReader();
                while (reader.Read())
                {
                    result += "<li><a href='/p/" + reader["id"].ToString() + "'>" + reader["name"].ToString() + "</a></li>";
                }
                reader.Close();
                if (result != null) { fulltextPNDiv.InnerHtml = "<ul>" + result + "</ul>"; fulltextPN.Visible = true; }
                else fulltextPN.Visible = false;

                //googlePNDiv.InnerHtml = GetContentFromURI("http://www.google.cz/?as_q=site:sbirkaprikladu.eu+o+projektu#sclient=psy-ab&hl=cs&site=&source=hp&q=site:sbirkaprikladu.eu+o+projektu&btnK=Hledat+Googlem&oq=site:sbirkaprikladu.eu+o+projektu&gs_l=hp.12...0.0.0.5297.0.0.0.0.0.0.0.0..0.0...0.0...1c._DtUJbXcKXI&pbx=1&bav=on.2,or.r_gc.r_pw.&fp=4998302f3ca498e3&biw=1908&bih=670", "GET");
            }
        }

        static String GetContentFromURI(String uri, String verb)
        {
            System.Net.WebRequest req = System.Net.WebRequest.Create(uri);


            req.ContentType = "application/x-www-form-urlencoded";
            req.Method = verb;
            req.ContentLength = 0;


            System.Net.WebResponse resp = req.GetResponse();
            if (resp == null) return null;


            System.IO.StreamReader sr = new System.IO.StreamReader(resp.GetResponseStream());
            return sr.ReadToEnd().Trim();
        }
    }
}