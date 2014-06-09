using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class cantLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void sendPassword(object sender, EventArgs e)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_Users] WHERE [UserName] = @email";
                dboManager.command.Parameters.AddWithValue("@email", emailTB.Text.Trim().ToLower());
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) { emailNotExistPN.Visible = true; return; }
                emailNotExistPN.Visible = false;
                PN01.Visible = false;
                successPN.Visible = true;

                MembershipUser mu = Membership.GetUser(emailTB.Text.Trim().ToLower());
                string uId = mu.ProviderUserKey.ToString();
                string mailBody = "<h1>Resetování hesla!</h1>";
                mailBody += "<p>Někdo použil tuto e-mailovou adresu pro resetování hesla uživatelského účtu do <a href='http://sbirkaprikladu.eu'>SbírkyPříkladů</a></p>";
                mailBody += "<p>Pokud je to vpořádku dokončete resetování kliknutím na následující odkaz <a href='http://sbirkaprikladu.eu/Admin/Users/resetUserPassword.aspx?uId=" + uId + "'>";
                mailBody += "http://sbirkaprikladu.eu/Admin/Users/resetUserPassword.aspx?uId=" + uId + "</a></p>";                
                mailBody += "<p>Pokud jste o resetování hesla nežádali, považujte prosím tento e-mail za bezpředmětný.</p>";
                mailBody += "<p><br /><br />S pozdravem tým SbírkyPříkladů</p>";
                emailManager.sendEmail(null, emailTB.Text.Trim().ToLower(), "Žádost o resetování hesla", mailBody);
            }
        }
    }
}