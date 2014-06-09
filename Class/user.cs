using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU
{
    public class user
    {
        public static Guid rootUserUniqueId { get { return new Guid("00000000-0000-0000-0000-000000000000"); } }

        public static string fullName()
        {
            string UserID = null;
            try
            {
                MembershipUser pomObj = Membership.GetUser();
                UserID = pomObj.ProviderUserKey.ToString();
            }
            catch { FormsAuthentication.SignOut(); return ""; }
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", UserID);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return null;
                return reader["name"].ToString() + " " + reader["surName"].ToString();
            }            
        }

        public static Guid uniqueId 
        { 
            get 
            {
                try
                {
                    MembershipUser pomObj = Membership.GetUser();
                    return new Guid(pomObj.ProviderUserKey.ToString());
                }
                catch { return new Guid("11111111-1111-1111-1111-111111111111"); /*anonymous GUID*/ }
            } 
        }

        public static bool isAnonymous
        {
            get
            {
                if (uniqueId.ToString() == "11111111-1111-1111-1111-111111111111") return true;
                else return false;
            }
        }

        public static string fullNameFromId(string userId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", userId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return null;
                return reader["name"].ToString() + " " + reader["surName"].ToString();
            }
        }

        public static void registerUserAccount(string email, string pass, string name, string surname, string roleName)
        {
            MembershipCreateStatus createStatus;
            MembershipUser newUser = Membership.CreateUser(email, pass, email, null, null, false, out createStatus);
            string userId = Membership.FindUsersByEmail(email)[email].ProviderUserKey.ToString();
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "INSERT INTO [aspnet_UsersDetails] (userId, name, surName, userStatus) VALUES (@userId, @name, @surName, 'PreRegistered')";
                dboManager.command.Parameters.AddWithValue("@userId", userId);
                dboManager.command.Parameters.AddWithValue("@name", name.Trim());
                dboManager.command.Parameters.AddWithValue("@surName", surname.Trim());
                dboManager.command.ExecuteNonQuery();
            }
            Roles.AddUserToRole(email, roleName);
        }

        public static void createUserAccount(string email, string pass, string name, string surname, string roleName)
        {
            MembershipUser newUser = Membership.CreateUser(email, pass, email);
            string userId = Membership.FindUsersByEmail(email)[email].ProviderUserKey.ToString();
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "INSERT INTO [aspnet_UsersDetails] (userId, name, surName) VALUES (@userId, @name, @surName)";
                dboManager.command.Parameters.AddWithValue("@userId", userId);
                dboManager.command.Parameters.AddWithValue("@name", name.Trim());
                dboManager.command.Parameters.AddWithValue("@surName", surname.Trim());
                dboManager.command.ExecuteNonQuery();
            }
            Roles.AddUserToRole(email, roleName);
        }

        public static void updateUserAccount(Guid updatedUserUniqueId, Guid currentLogedAdministratorUniqueId, string email, string pass, string name, string surname)
        {
            MembershipUser mu = Membership.GetUser(updatedUserUniqueId);
            updateUserAccount(updatedUserUniqueId, currentLogedAdministratorUniqueId, email, pass, name, surname, Roles.GetRolesForUser(mu.UserName)[0], mu.IsApproved);
        }

        public static void updateUserAccount(Guid updatedUserUniqueId, Guid currentLogedAdministratorUniqueId, string email, string pass, string name, string surname, string roleName, bool active)
        {
            String oldAdminName = Membership.GetUser(currentLogedAdministratorUniqueId).UserName;
            MembershipUser updUser = Membership.GetUser(updatedUserUniqueId);            
            updUser.UnlockUser();   //unlock user for changing

            updUser = Membership.GetUser(updatedUserUniqueId);  //get updUser one more
            Roles.RemoveUserFromRoles(updUser.UserName, Roles.GetRolesForUser(updUser.UserName));
            Roles.AddUserToRole(updUser.UserName, roleName);            
            updUser.Email = email;
            updUser.IsApproved = active;            
            if (!string.IsNullOrEmpty(pass)) updUser.ChangePassword(updUser.ResetPassword(), pass);
            Membership.UpdateUser(updUser);
                        
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "BEGIN TRANSACTION;";
                dboManager.command.CommandText += "UPDATE [aspnet_UsersDetails] SET [name] = @name, [surName] = @surName, [userStatus] = @userStatus WHERE [userId] = @userId;";
                dboManager.command.CommandText += "UPDATE [aspnet_Users] SET [UserName] = @email, [LoweredUserName] = @email WHERE [userId] = @userId;";
                dboManager.command.CommandText += "COMMIT TRANSACTION;";
                dboManager.command.Parameters.AddWithValue("@userId", updatedUserUniqueId);
                dboManager.command.Parameters.AddWithValue("@name", name.Trim());
                dboManager.command.Parameters.AddWithValue("@surName", surname.Trim());
                dboManager.command.Parameters.AddWithValue("@email", email.ToLower());
                if(active) dboManager.command.Parameters.AddWithValue("@userStatus", "Active");
                else dboManager.command.Parameters.AddWithValue("@userStatus", "Baned");
                dboManager.command.ExecuteNonQuery();
            }
            if (updatedUserUniqueId == currentLogedAdministratorUniqueId && email.ToLower() != oldAdminName)
            {
                HttpContext.Current.Session.Abandon();
                FormsAuthentication.SignOut();
                FormsAuthentication.RedirectToLoginPage();
            }
        }

        public static void deleteUserAccount(Guid userUniqueId)
        {
            try
            {
                using (dboManager dboManager = new dboManager())
                {
                    dboManager.command.CommandText = "BEGIN TRANSACTION;";
                    dboManager.command.CommandText += "UPDATE [examples] SET [ownerId] = @spId WHERE [ownerId] = @userId;";
                    dboManager.command.CommandText += "DELETE [aspnet_UsersDetails] WHERE [userId] = @userId;";
                    dboManager.command.CommandText += "DELETE [examplesInCollections] WHERE id IN (SELECT examplesInCollections.id FROM collections INNER JOIN examplesInCollections ON collections.id = examplesInCollections.collectionId WHERE (collections.ownerId = @userId));"; //delete examples in collections
                    dboManager.command.CommandText += "DELETE [collections] WHERE ownerId = @userId;";
                    dboManager.command.CommandText += "COMMIT TRANSACTION;";
                    dboManager.command.Parameters.AddWithValue("@userId", userUniqueId.ToString());
                    dboManager.command.Parameters.AddWithValue("@spId", user.rootUserUniqueId.ToString());
                    dboManager.command.ExecuteNonQuery();
                }
                string email = Membership.GetUser(userUniqueId).Email;
                Membership.DeleteUser(Membership.GetUser(userUniqueId).UserName);
                emailManager.sendEmail(null, email, "Smazání uživatelského účtu", "Váš účet na <a href='http://sbirkaprikladu.eu'>SbírcePříkladů.eu</a> byl trvale odstraněn administrátorem.<br />Pokud požadujete další informace, kontaktujte nás.<br /><br />S pozdravem tým SbírkyPříkladů.");
            }
            catch { }
        }

        public static List<System.Web.UI.WebControls.ListItem> getAllRolesInApplication()
        {
            List<System.Web.UI.WebControls.ListItem> rolesLI = new List<System.Web.UI.WebControls.ListItem>();
            rolesLI.Add(new System.Web.UI.WebControls.ListItem("Registrovaný uživatel", "RegistredUser"));
            rolesLI.Add(new System.Web.UI.WebControls.ListItem("Tvůrce", "Author"));
            rolesLI.Add(new System.Web.UI.WebControls.ListItem("Moderátor", "Moderator"));
            rolesLI.Add(new System.Web.UI.WebControls.ListItem("Administrátor", "Administrator"));
            return rolesLI;            
        }

        public static string getName(Guid userUniqueId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", userUniqueId.ToString());
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return null;
                return reader["name"].ToString();
            }
        }

        public static string getSurName(Guid userUniqueId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", userUniqueId.ToString());
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return null;
                return reader["surName"].ToString();
            }
        }

        public static string getStatus(Guid userUniqueId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [aspnet_UsersDetails] WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", userUniqueId.ToString());
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return null;
                switch (reader["userStatus"].ToString())
                {
                    case "Active": return "Aktivní";
                    case "Baned": if (string.IsNullOrEmpty(reader["banedTil"].ToString())) return "Zakázán";
                        else return string.Format("Zakázán do {0:dd.MM.yyyy}", Convert.ToDateTime(reader["banedTil"].ToString()));
                }
                return reader["userStatus"].ToString();
            }
        }

        public static void setUserToActive(Guid userUniqueId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [aspnet_UsersDetails] SET [userStatus] = 'Active', [banedTil] = NULL WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", userUniqueId.ToString());                
                dboManager.command.ExecuteNonQuery();
                MembershipUser mu = Membership.GetUser(userUniqueId);
                mu.IsApproved = true;
                Membership.UpdateUser(mu);                
            }
        }

        public static void setBanTil(DateTime tilDateTime, Guid updatedUserUniqueId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [aspnet_UsersDetails] SET [userStatus] = 'Baned', [banedTil] = @banedTil WHERE [UserId] = @userId";
                dboManager.command.Parameters.AddWithValue("@userId", updatedUserUniqueId.ToString());
                dboManager.command.Parameters.AddWithValue("@banedTil", tilDateTime);
                dboManager.command.ExecuteNonQuery();                
            }
        }

        public static string getBanTil(Guid updatedUserUniqueId)
        {
            using (dboManager dboManager = new dboManager())
            {
                try
                {
                    dboManager.command.CommandText = "SELECT [banedTil] FROM [aspnet_UsersDetails] WHERE [UserId] = @userId";
                    dboManager.command.Parameters.AddWithValue("@userId", updatedUserUniqueId.ToString());
                    DateTime dt = Convert.ToDateTime(dboManager.command.ExecuteScalar().ToString());
                    return dt.ToShortDateString();
                }
                catch { return null; }
            }
        }        

        public static string translateRoleToCzech(string RoleName)
        {
            switch (RoleName)
            {
                case "RegistredUser": return "Registrovaný uživatel";
                case "Author": return "Tvůrce";
                case "Moderator": return "Moderátor";
                case "Administrator": return "Administrátor";
            }
            return RoleName;
        }

        public static Int64 getCreatedExamplesNr(Guid userId)
        {
            using (dboManager dboManager = new dboManager())
            {
                try
                {
                    dboManager.command.CommandText = "SELECT COUNT (id) FROM [examples] WHERE [ownerId] = @userId";
                    dboManager.command.Parameters.AddWithValue("@userId", userId.ToString());
                    Int64 nr = Convert.ToInt64(dboManager.command.ExecuteScalar().ToString());
                    return nr;
                }
                catch { return 0; }
            }
        }
        
        public static Int64 getCreatedCollectionsNr(Guid userId)
        {
            using (dboManager dboManager = new dboManager())
            {
                try
                {
                    dboManager.command.CommandText = "SELECT COUNT (id) FROM [collections] WHERE [ownerId] = @userId";
                    dboManager.command.Parameters.AddWithValue("@userId", userId.ToString());
                    Int64 nr = Convert.ToInt64(dboManager.command.ExecuteScalar().ToString());
                    return nr;
                }
                catch { return 0; }
            }
        }
    }
}