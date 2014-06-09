using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;
using System.IO;

namespace SbirkaPrikladuEU
{
    public partial class scheduledTasks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            setBanedTilUsersToActive();
            deleteLongTimePreregisteredUsers();
            deleteTempDirectory();
        }

        protected void setBanedTilUsersToActive()
        {
            string taskName = "Aktivace dočasně zakázaných účtů";
            try
            {
                using (dboManager dboManager = new dboManager())
                {
                    dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [banedTil] < @now";
                    dboManager.command.Parameters.AddWithValue("@now", DateTime.Now);
                    SqlDataReader reader = dboManager.command.ExecuteReader();
                    while (reader.Read())
                    {
                        user.setUserToActive(new Guid(reader["userId"].ToString()));
                        string email = Membership.GetUser(new Guid(reader["userId"].ToString())).Email;
                        emailManager.sendEmail(null, email, "Aktivace uživatelského účtu", "Váš účet na <a href='http://sbirkaprikladu.eu'>SbírcePříkladů.eu</a>, který byl dočasně zakázán administrátorem, byl opět automaticky aktivován.<br />Pokud požadujete další informace, kontaktujte nás.<br /><br />S pozdravem tým SbírkyPříkladů.");
                    }
                }
                userManagementUL.InnerHtml += "<li><i class='icon-ok'></i>&nbsp;&nbsp;&nbsp;" + taskName + "</li>";
            }
            catch (Exception ex) { userManagementUL.InnerHtml += "<li><span class='alert-danger'><i class='icon-warning-sign'></i>&nbsp;&nbsp;&nbsp;" + taskName + "<ul style='padding-left: 20px;'><li>" + ex.Message + "</li></ul><span></li>"; }
        }

        protected void deleteLongTimePreregisteredUsers()
        {
            string taskName = "Mazání předregistrovaných uživatelů bez autorizace e-mailem";
            try
            {
                using (dboManager dboManager = new dboManager())
                {
                    dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [userStatus] = 'PreRegistered'";                    
                    SqlDataReader reader = dboManager.command.ExecuteReader();
                    while (reader.Read())
                    {
                        if (Membership.GetUser(new Guid(reader["userId"].ToString())).CreationDate < DateTime.Now.AddDays(2))
                        {
                            Membership.DeleteUser(Membership.GetUser(new Guid(reader["userId"].ToString())).UserName);
                            dboManager.command2.CommandText = "DELETE [aspnet_UsersDetails] WHERE [userId] = @userId";
                            dboManager.command2.Parameters.Clear();
                            dboManager.command2.Parameters.AddWithValue("@userId", reader["userId"].ToString());
                            dboManager.command2.ExecuteNonQuery();
                        }
                    }
                }
                userManagementUL.InnerHtml += "<li><i class='icon-ok'></i>&nbsp;&nbsp;&nbsp;" + taskName + "</li>";
            }
            catch (Exception ex) { userManagementUL.InnerHtml += "<li><span class='alert-danger'><i class='icon-warning-sign'></i>&nbsp;&nbsp;&nbsp;" + taskName + "<ul style='padding-left: 20px;'><li>" + ex.Message + "</li></ul><span></li>"; }
        }

        protected void deleteTempDirectory()
        {
            string taskName = "Mazání dočasných souborů /Files/Temp/";
            try
            {
                string[] files = Directory.GetFiles(Server.MapPath("/Files/Temp"));
                foreach (string file in files)
                {
                    if (File.Exists(file)) File.Delete(file);                    
                }
                fileSystemUL.InnerHtml += "<li><i class='icon-ok'></i>&nbsp;&nbsp;&nbsp;" + taskName + "</li>";
            }
            catch (Exception ex) { fileSystemUL.InnerHtml += "<li><span class='alert-danger'><i class='icon-warning-sign'></i>&nbsp;&nbsp;&nbsp;" + taskName + "<ul style='padding-left: 20px;'><li>" + ex.Message + "</li></ul><span></li>"; }
        }

    }
}