using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class searchExamplesByAuthorShowResult : System.Web.UI.Page
    {
        string[] userIds;
        TextBox searchTB;
        protected void Page_Load(object sender, EventArgs e)
        {
            searchTB = (Master.FindControl("searchPN") as UserControl).FindControl("searchTB") as TextBox;
            if (!IsPostBack)
            {
                if (Session["searchByUserTextBoxPattern"] != null) searchTB.Text = Session["searchByUserTextBoxPattern"].ToString();
            }
            userIds = Session["searchByUserSelectedIds"].ToString().Split(',');
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {            
            SqlDataSource1.SelectParameters.Clear();
            string pomWhere = "";
            for (int i = 0; i < userIds.Count() - 1; i++)
            {
                SqlDataSource1.SelectParameters.Add("id"+i, userIds[i]);
                pomWhere += "[ownerId] = @id" + i + " OR ";
            }
            pomWhere += "[ownerId] = @id0 ";


            SqlDataSource1.SelectCommand = "SELECT * FROM [examples] WHERE (" + pomWhere + ") AND [status] = 'Active' ";
            searchTB.Text = searchTB.Text.Trim();
            if (!string.IsNullOrEmpty(searchTB.Text))
            {
                SqlDataSource1.SelectCommand += "AND ([name] LIKE '%' + @searchText + '%' OR [enter] LIKE '%' + @searchText + '%' OR [solution] LIKE '%' + @searchText + '%' OR [result] LIKE '%' + @searchText + '%') ";
                SqlDataSource1.SelectParameters.Add("searchText", searchTB.Text);
            }
            SqlDataSource1.SelectCommand += "ORDER BY [lastUpdate] DESC";
            examplesGW.DataBind();

            if (!string.IsNullOrEmpty((Page.Master.FindControl("beforeBackClickedSearchExamplesByAutorPageIndexHF") as HiddenField).Value))
                try
                {
                    examplesGW.PageIndex = Convert.ToInt32((Page.Master.FindControl("beforeBackClickedSearchExamplesByAutorPageIndexHF") as HiddenField).Value);
                    (Page.Master.FindControl("beforeBackClickedSearchExamplesByAutorPageIndexHF") as HiddenField).Value = null;
                }
                catch { }

            try { (Page.Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).AddHistoryPoint("beforeBackClickedSearchExamplesByAutorGWPageIndex", examplesGW.PageIndex.ToString()); }
            catch { }
        }
    }
}