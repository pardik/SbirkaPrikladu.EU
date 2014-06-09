using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class confirmUserEmailRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Request.QueryString["uId"].ToString();
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [userId] = @uId AND [userStatus] = 'PreRegistered'";
                dboManager.command.Parameters.AddWithValue("@uId", userId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return;
                reader.Dispose();
                dboManager.command.CommandText = "UPDATE [aspnet_UsersDetails] SET [userStatus] = 'Registered' WHERE [userId] = @uId";                
                dboManager.command.ExecuteNonQuery();
                string mailBody = "<h1>Registrace nových uživatelů!</h1>";
                mailBody += "<p>Ve <a href='http://sbirkaprikladu.eu'>SbírcePříkladů</a> existují nové žádosti o registraci uživatelských účtů.</p>";                
                mailBody += "<p>Autorizovat, nebo zamítnout, žádosti můžete <a href='sbirkaprikladu.eu/Admin/Users/registeredUserList.aspx'>ZDE</a></p>";
                mailBody += "<p><br /><br />S pozdravem SbírkaPříkladů</p>";
                emailManager.sendEmail(null, "podpora@sbirkaprikladu.eu", "Žádost o registraci uživatelského účtu", mailBody);
            }
        }
    }
}