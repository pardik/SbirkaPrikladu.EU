using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class userDetail : System.Web.UI.Page
    {
        public Guid userId { get { return new Guid(Request.QueryString["userId"].ToString()); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser mu = Membership.GetUser(userId);
                string userRole = Roles.GetRolesForUser(mu.UserName)[0].ToString();
                nameTB.Text = user.getName(userId) + " " + user.getSurName(userId);
                emailTB.Text = mu.Email;
                statusTB.Text = user.getStatus(userId);
                lastActivityTB.Text = mu.LastActivityDate.ToString("dd.MM.yyyy   |   HH:mm");

                foreach (ListItem li in user.getAllRolesInApplication())
                {
                    if (li.Value == userRole) roleTB.Text = li.Text;
                }
            }

            SqlDataSource1.SelectCommand = "SELECT * FROM [examples] WHERE [ownerId] = @ownerId ORDER BY [lastUpdate] DESC";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("ownerId", userId.ToString());

            SqlDataSource2.SelectCommand = "SELECT * FROM [collections] WHERE [ownerId] = @ownerId ORDER BY [name]";
            SqlDataSource2.SelectParameters.Clear();
            SqlDataSource2.SelectParameters.Add("ownerId", userId.ToString());
        }

        protected void verifiedCHB_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chb = sender as CheckBox;            
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [examples] SET [verified] = @ver WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", chb.Attributes["dataKey"].ToString());
                dboManager.command.Parameters.AddWithValue("@ver", chb.Checked);
                dboManager.command.ExecuteNonQuery();
            }
        }

        protected void paidCHB_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chb = sender as CheckBox;
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [examples] SET [paid] = @paid WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", chb.Attributes["dataKey"].ToString());
                dboManager.command.Parameters.AddWithValue("@paid", chb.Checked);
                dboManager.command.ExecuteNonQuery();
            }
        }

        protected void changeIsPublic(object sender, EventArgs e)
        {
            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, this.GetType(), "toCollectionPaneScript", "$('a[href=\"#collectionsTab\"]').tab('show');", true);
            collectionManager.setIsPublic(Convert.ToInt64((sender as CheckBox).Attributes["dataKey"].ToString()), (sender as CheckBox).Checked);
        }
    }
}