using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

namespace SbirkaPrikladuEU.Class
{
    public partial class searchPN : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["searchByUserSelectedIds"] != null) searchByUserUsersIdsHF.Value = Session["searchByUserSelectedIds"].ToString();
            }
            fillUsersToSearchByuserControls();
        }

        protected void searchBT_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(searchTB.Text)) return;
            Response.Redirect("/search.aspx?s=" + searchTB.Text, true);
        }

        protected void fillUsersToSearchByuserControls()
        {
            using (dboManager dboManager = new dboManager())
            {
                //SqlDataReader reader = dboManager.ExecuteQuery("SELECT * FROM [aspnet_UsersDetails] ORDER BY [surName]");
                SqlDataReader reader = dboManager.ExecuteQuery("SELECT DISTINCT examples.ownerId, aspnet_UsersDetails.name, aspnet_UsersDetails.surName FROM examples INNER JOIN aspnet_UsersDetails ON examples.ownerId = aspnet_UsersDetails.userId WHERE (examples.status = N'Active') ORDER BY aspnet_UsersDetails.surName");
                string html = "";
                while (reader.Read())
                {
                    html += "<div data-userId=\"" + reader["ownerId"].ToString() + "\" class=\"alert alert-info userItem\"><i class=\"icon-user\"></i>";
                    html += reader["surName"].ToString() + "&nbsp;";
                    html += reader["name"].ToString();
                    Int64 nrOfEx = user.getCreatedExamplesNr(new Guid(reader["ownerId"].ToString()));
                    html += "<br /><span class='nrOfEx'>" + nrOfEx + "&nbsp;př.</span>";
                    html += "</div>";
                }
                searchByUserModalUsersListBottom.InnerHtml = html;
                searchByUserModalUsersListUpper.InnerHtml = html;
            }
        }

        protected void searchByUserSubmitBT_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(searchByUserUsersIdsHF.Value)) return;
            Session["searchByUserSelectedIds"] = searchByUserUsersIdsHF.Value;
            Session["searchByUserTextBoxPattern"] = searchTB.Text.Trim();
            Response.Redirect("/Class/searchExamplesByAuthorShowResult.aspx", true);         
        }

    }
}