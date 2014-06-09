using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class registeredUserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void authorizeUser(object sender, EventArgs e)
        {
            Guid userId = new Guid((sender as LinkButton).CommandArgument);            
            user.setUserToActive(userId);            
            MembershipUser mu = Membership.GetUser(userId);
            string mailBody = "<h1>Schváleno!</h1>";
            mailBody += "<p>Vaše žádost o registraci do <a href='http://sbirkaprikladu.eu'>SbírkyPříkladů</a> byla schválena.</p>";
            mailBody += "<p>Přihlaste se svým uživatelským jménem (e-mailem) a heslem.</p>";            
            mailBody += "<p><br /><br />S pozdravem tým SbírkyPříkladů</p>";
            emailManager.sendEmail(null, mu.Email, "Žádost o registraci uživatelského účtu", mailBody);
            (sender as LinkButton).Parent.Visible = false;
        }

        protected void rejectUser(object sender, EventArgs e)
        {
            Guid userId = new Guid((sender as LinkButton).CommandArgument);
            MembershipUser mu = Membership.GetUser(userId);
            user.deleteUserAccount(userId);
            string mailBody = "<h1>Je nám líto!</h1>";
            mailBody += "<p>Vaše žádost o registraci do <a href='http://sbirkaprikladu.eu'>SbírkyPříkladů</a> byla zamítnuta.</p>";
            mailBody += "<p>Pro podrobnější informace kontaktujte správce portálu.</p>";
            mailBody += "<p><br /><br />S pozdravem tým SbírkyPříkladů</p>";
            emailManager.sendEmail(null, mu.Email, "Žádost o registraci uživatelského účtu", mailBody);
            usersGW.DataBind();
            (sender as LinkButton).Parent.Visible = false;
        }
    }
}