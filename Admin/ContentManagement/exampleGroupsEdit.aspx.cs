using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Admin.ContentManagement
{
    public partial class exampleGroupsEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                new mpTreeView().fillTreeView("exampleGroups", exampleGroupsTV);
                if (exampleGroupsTV.SelectedNode == null) exampleGroupsTV.Nodes[0].Select();
                selectedNodeChanged(null, null);
            }
        }

        protected void selectedNodeChanged(object sender, EventArgs e)
        {
            editGroupNameTB.Text = exampleGroupsTV.SelectedNode.Text;
        }

        protected void insertNewGroup(object sender, EventArgs e)
        {
            Int64 selectedGroupId = Convert.ToInt64(exampleGroupsTV.SelectedNode.Value);
            if (string.IsNullOrEmpty(newGroupNameTB.Text)) return;
            exampleManager.insertExampleGroup(newGroupNameTB.Text, selectedGroupId);
            newGroupNameTB.Text = null;
            new mpTreeView().fillTreeView("exampleGroups", exampleGroupsTV);
            new mpTreeView().findNodeByValue(exampleGroupsTV.Nodes, selectedGroupId.ToString()).Select();
            exampleGroupsTV.ExpandAll();
        }

        protected void renameGroup(object sender, EventArgs e)
        {
            Int64 selectedGroupId = Convert.ToInt64(exampleGroupsTV.SelectedNode.Value);
            if (string.IsNullOrEmpty(editGroupNameTB.Text)) return;
            exampleManager.renameGroup(Convert.ToInt64(exampleGroupsTV.SelectedNode.Value), editGroupNameTB.Text);
            new mpTreeView().fillTreeView("exampleGroups", exampleGroupsTV);
            new mpTreeView().findNodeByValue(exampleGroupsTV.Nodes, selectedGroupId.ToString()).Select();
            exampleGroupsTV.ExpandAll();
        }
    }
}