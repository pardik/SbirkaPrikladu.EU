using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class resetUserPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Request.QueryString["uId"].ToString();
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [userId] = @uId";
                dboManager.command.Parameters.AddWithValue("@uId", userId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) Response.End();
                reader.Dispose();

                MembershipUser mu = Membership.GetUser(new Guid(userId));
                string email = mu.Email;
                //string newPass = Membership.GeneratePassword(Membership.MinRequiredPasswordLength, 0);
                string newPass = Guid.NewGuid().ToString("N").Substring(0, Membership.MinRequiredPasswordLength);
                mu.ChangePassword(mu.ResetPassword(), newPass);
                
                string mailBody = "<h1>Vaše heslo bylo resetováno!</h1>";
                mailBody += "<p>Na Vaši žádost jsme resetovali heslo do <a href='http://sbirkaprikladu.eu'>SbírkyPříkladů</a></p>";
                mailBody += "<p>Vaše nové heslo: <strong>" + newPass + "</strong></p>";
                mailBody += "<p>Po přihlášení si můžete heslo změnit v uživatelském profilu. Při přihlášení nezapoměňte dodržovat velikost písmen.</p>";
                mailBody += "<p><br /><br />S pozdravem tým SbírkyPříkladů</p>";
                emailManager.sendEmail(null, email, "Žádost o resetování hesla", mailBody);
            }
        }
    }
}