using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class lastInsertedExamples : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty((Page.Master.FindControl("beforeBackClickedLastInsertedExamplesPageIndexHF") as HiddenField).Value)) 
                try 
                {
                    examplesGW.PageIndex = Convert.ToInt32((Page.Master.FindControl("beforeBackClickedLastInsertedExamplesPageIndexHF") as HiddenField).Value);
                    (Page.Master.FindControl("beforeBackClickedLastInsertedExamplesPageIndexHF") as HiddenField).Value = null;
                }
                catch { }

            try { (Page.Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).AddHistoryPoint("beforeBackClickedLastInsertedExamplesGwPageIndex", examplesGW.PageIndex.ToString()); }
            catch { }
            string filter = "";
            if ((Parent.Parent.Parent.FindControl("exampleFilterUC") as filter).filter1StZs) filter += "[schoolGrade] LIKE '%-1-%'";
            if ((Parent.Parent.Parent.FindControl("exampleFilterUC") as filter).filter2StZs) { if (filter != "") filter += " OR "; filter += " [schoolGrade] LIKE '%-2-%' "; }
            if ((Parent.Parent.Parent.FindControl("exampleFilterUC") as filter).filterStredoskolsky) { if (filter != "") filter += " OR "; filter += " [schoolGrade] LIKE '%-3-%' "; }
            SqlDataSource1.SelectCommand = "SELECT * FROM [examples] WHERE [status] = 'Active' AND (" + filter + ") ORDER BY [insertingDate] DESC";
            examplesGW.DataBind();
        }
    }
}