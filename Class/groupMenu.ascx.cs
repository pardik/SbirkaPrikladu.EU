using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class groupMenu : System.Web.UI.UserControl
    {
        public int tabTosHowNr { get; set; } // priklady / generatory
        public TreeView groupsTV { get { return exampleGroupsTV; } }
        public string selectedNodeId { get { return selectedNodeIdHF.Value; } set { selectedNodeIdHF.Value = value; } }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["tryGenerators"] == null || Convert.ToDateTime(Session["tryGenerators"].ToString()) < DateTime.Now) { Session["tryGenerators"] = DateTime.Now.AddMinutes(5); ScriptManager.RegisterStartupScript(Page, this.GetType(), "showgenJS", "showTryGenerators();", true); }
            if (!IsPostBack)
            {                
                new mpTreeView().fillTreeView("exampleGroups", exampleGroupsTV);
                exampleGroupsTV.Nodes[0].NavigateUrl = "/";
                exampleGroupsTV.CollapseAll();
                exampleGroupsTV.Nodes[0].Expand();
                if (Page.RouteData.Values["groupId"] != null) { selectedNodeId = Page.RouteData.Values["groupId"].ToString(); }                
            }
            expandSelectedNode();
            if (Request.Url.AbsolutePath.ToLower().Contains("/generators")) ScriptManager.RegisterStartupScript(Page, this.GetType(), "leftMenuNoMoveJS", "$('.sideBar').css('max-width','280px');", true);
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "exmplesMenuTabs", "$('#exampleMenuTab li:eq(" + tabTosHowNr + ") a').tab('show');$('#exampleMenuTab a').click(function(e){e.preventDefault();$(this).tab('show');});", true);  // tabs priklady/generatory
        }

        protected void selectedNodeChanged(object sender, EventArgs e)
        {
            if (Convert.ToBoolean(exampleGroupsTV.SelectedNode.Expanded)) exampleGroupsTV.SelectedNode.Collapse();
            else exampleGroupsTV.SelectedNode.Expand();            
            if (exampleGroupsTV.SelectedNode != null && exampleGroupsTV.SelectedNode.ChildNodes.Count == 0) Response.Redirect("/g/" + exampleGroupsTV.SelectedValue, true);
            exampleGroupsTV.SelectedNode.Selected = false;
            tabTosHowNr = 0;
        }

        protected void expandSelectedNode()
        {
            if (!string.IsNullOrEmpty(selectedNodeId))
            {
                TreeNode pomTN = new mpTreeView().findNodeByValue(exampleGroupsTV.Nodes, selectedNodeId);
                pomTN.Select();
                while (pomTN.Parent != null)
                {
                    pomTN.Expand();
                    pomTN = pomTN.Parent;
                }
            }
        }
    }
}