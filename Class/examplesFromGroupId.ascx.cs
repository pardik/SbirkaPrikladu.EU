using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class examplesFromGroupId : System.Web.UI.UserControl
    {
        string _groupId;
        public string groupId 
        { 
            get { return _groupId; } 
            set 
            { 
                _groupId = value;
                groupNameTag.InnerText = exampleManager.groupNames("-" + groupId + "-")[0];
            } 
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(groupId)) this.Visible = false;
            else this.Visible = true;
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty((Page.Master.FindControl("beforeBackClickedExamplesFromGroupPageIndexHF") as HiddenField).Value))
                try
                {
                    examplesGW.PageIndex = Convert.ToInt32((Page.Master.FindControl("beforeBackClickedExamplesFromGroupPageIndexHF") as HiddenField).Value);
                    (Page.Master.FindControl("beforeBackClickedExamplesFromGroupPageIndexHF") as HiddenField).Value = null;
                }
                catch { }

            try { (Page.Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).AddHistoryPoint("beforeBackClickedExamplesFromGroupGwPageIndex", examplesGW.PageIndex.ToString()); }
            catch { }

            string filter = "";
            if ((Parent.Parent.Parent.FindControl("exampleFilterUC") as filter).filter1StZs) filter += "[schoolGrade] LIKE '%-1-%'";
            if ((Parent.Parent.Parent.FindControl("exampleFilterUC") as filter).filter2StZs) { if (filter != "") filter += " OR "; filter += " [schoolGrade] LIKE '%-2-%' "; }
            if ((Parent.Parent.Parent.FindControl("exampleFilterUC") as filter).filterStredoskolsky) { if (filter != "") filter += " OR "; filter += " [schoolGrade] LIKE '%-3-%' "; }
            SqlDataSource1.SelectCommand = "SELECT * FROM [examples] WHERE [groupIds] LIKE '%-' + @groupId + '-%' AND [status] = 'Active' AND (" + filter + ") ORDER BY [lastUpdate] DESC";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("groupId", groupId);
            examplesGW.DataBind();            
        }
    }
}