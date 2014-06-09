using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Admin.Collections
{
    public partial class myCollectionsList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["a"] != null && Request.QueryString["a"].ToString() == "createNew") ScriptManager.RegisterStartupScript(Page, Page.GetType(), "createNewScript", "$('#newCollectionModal').modal();", true);
            }

            SqlDataSource1.SelectCommand = "SELECT * FROM [collections] WHERE [ownerId] = @ownerId ORDER BY [name]";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("ownerId", user.uniqueId.ToString());            
        }

        protected void createNewCollection(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(newCollectionNameTB.Text)) return;

            collectionManager.createCollection(newCollectionNameTB.Text, Convert.ToBoolean(newCollectionIsPublicDDL.SelectedValue), labelsTB.Text, Convert.ToBoolean(hideExamplesHeadersDDL.SelectedValue), Convert.ToBoolean(hideExamplesSolutionsDDL.SelectedValue), Convert.ToBoolean(hideExamplesResultsDDL.SelectedValue));
            newCollectionNameTB.Text = null;            
            collectionsGW.DataBind();
        }

        protected void changeIsPublic(object sender, EventArgs e)
        {
            collectionManager.setIsPublic(Convert.ToInt64((sender as CheckBox).Attributes["dataKey"].ToString()), (sender as CheckBox).Checked);
        }

        protected void changeHideHeaders(object sender, EventArgs e)
        {
            collectionManager.hideExamplesHeaders(Convert.ToInt64((sender as CheckBox).Attributes["dataKey"].ToString()), !(sender as CheckBox).Checked);
        }

        protected void changeHideSolutions(object sender, EventArgs e)
        {
            collectionManager.hideExamplesSolutions(Convert.ToInt64((sender as CheckBox).Attributes["dataKey"].ToString()), !(sender as CheckBox).Checked);
        }

        protected void changeHideResults(object sender, EventArgs e)
        {
            collectionManager.hideExamplesResults(Convert.ToInt64((sender as CheckBox).Attributes["dataKey"].ToString()), !(sender as CheckBox).Checked);
        }

        protected string getLabelsHtml(string labelsString)
        {
            var html = "";
            foreach (var item in labelsString.Split(new []{','}))
            {
                if (item.Trim() == "") continue;
                html += "<span class='label label-default collectionLabel'>" + item + "</span><span> </span>";
            }
            return html;
        }
    }
}