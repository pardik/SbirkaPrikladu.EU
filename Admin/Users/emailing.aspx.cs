using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class emailing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            fillUsersToSearchByuserControls();
        }
               

        protected void fillUsersToSearchByuserControls()
        {
            using (dboManager dboManager = new dboManager())
            {
                SqlDataReader reader = dboManager.ExecuteQuery("SELECT aspnet_UsersDetails.name, aspnet_UsersDetails.surName, aspnet_UsersDetails.userStatus, aspnet_Users.*, aspnet_Roles.RoleName, aspnet_Roles.RoleId, aspnet_Membership.LoweredEmail AS email FROM aspnet_Membership RIGHT OUTER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId LEFT OUTER JOIN aspnet_Roles INNER JOIN aspnet_UsersInRoles ON aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId LEFT OUTER JOIN aspnet_UsersDetails ON aspnet_Users.UserId = aspnet_UsersDetails.userId WHERE [userStatus] <> 'PreRegistered' ORDER BY aspnet_UsersDetails.surName");
                string html = "";
                while (reader.Read())
                {
                    html += "<div data-userId=\"" + reader["userId"].ToString() + "\"  data-roleName=\"" + reader["RoleName"].ToString() + "\"class=\"alert alert-info userItem\"><i class=\"icon-user\"></i>";
                    html += reader["surName"].ToString() + "&nbsp;";
                    html += reader["name"].ToString();
                    html += "<br /><span class='emailAddr'>" + reader["email"].ToString() + "</span>";
                    html += "</div>";
                }
                searchByUserModalUsersListBottom.InnerHtml = html;
                searchByUserModalUsersListUpper.InnerHtml = html;
            }
        }

        protected void primarySubmitBT_Click(object sender, EventArgs e)
        {
            List<string> emails = new List<string>();
            emails = emailAddrHF.Value.Split(new char[] { ',' }).ToList();
            emails.RemoveAt(emails.Count - 1);
            string subject = !string.IsNullOrEmpty(subjectTB.Text) ? subject = subjectTB.Text : "SbírkaPříkladů.eu";
            try
            {
                foreach (string email in emails)
                {
                    emailManager.sendEmail(null, email, subject, emailTextCKE.Text);
                }
                
            }
            catch (Exception ex) 
            {
                messageWasSendH3.InnerText = "Chyba při odesílání zprávy";
                messageWasSendP.InnerText = ex.Message;
                errModalBT.Visible = true;
                successModalBT.Visible = false;
            }

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "modalJS", "$('.modal').modal('show');", true);

        }
    }
}