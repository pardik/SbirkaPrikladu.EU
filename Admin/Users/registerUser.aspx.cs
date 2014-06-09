using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class registerUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (ListItem li in user.getAllRolesInApplication())
                {
                    rolesRBL.Items.Add(li);
                }
                rolesRBL.Items[0].Selected = true;
                rolesRBL.Items.Remove(rolesRBL.Items[3]);
                rolesRBL.Items.Remove(rolesRBL.Items[2]);                
            }
        }

        public void registerUserBT_Click(object sender, EventArgs args)
        {
            errorDivTag.InnerHtml = null;
            if (passTB.Text.Contains(" ")) errorDivTag.InnerHtml += "<li>Heslo nesmí obsahovat mezery</li>";
            if (passTB.Text != pass2TB.Text) errorDivTag.InnerHtml += "<li>Zadaná hesla nejsou stejná</li>";
            if (passTB.Text.Count() > 0 && passTB.Text.Count() < Membership.MinRequiredPasswordLength) errorDivTag.InnerHtml += "<li>Minimální délka hesla je " + Membership.MinRequiredPasswordLength + " znaků</li>";
            if (passTB.Text.Count() < 1) errorDivTag.InnerHtml += "<li>Nezadali jste heslo. Heslo je povinné</li>";
            if (Membership.FindUsersByEmail(emailTB.Text).Count > 0) errorDivTag.InnerHtml += "<li>Pro tento e-mail je již registrován jiný uživatel</li>";

            if (string.IsNullOrEmpty(errorDivTag.InnerHtml))
            {
                try
                {
                    user.registerUserAccount(emailTB.Text, passTB.Text, nameTB.Text, surnameTB.Text, rolesRBL.SelectedValue);
                    string mailBody = "<h1>Vítejte!</h1>";
                    mailBody += "<p>Někdo použil tuto e-mailovou adresu pro registraci uživatelského účtu do <a href='http://sbirkaprikladu.eu'>SbírkyPříkladů</a></p>";
                    mailBody += "<p>Pokud je to vpořádku dokončete žádost o registraci kliknutím na následující odkaz <a href='http://sbirkaprikladu.eu/Admin/Users/confirmUserEmailRegistration.aspx?uId=" + Membership.FindUsersByName(emailTB.Text)[emailTB.Text].ProviderUserKey.ToString() + "'>";
                    mailBody += "http://sbirkaprikladu.eu/Admin/Users/confirmUserEmailRegistration.aspx?uId=" + Membership.FindUsersByName(emailTB.Text)[emailTB.Text].ProviderUserKey.ToString() + "</a></p>";
                    mailBody += "<p>Pokud jste o registraci nežádali, považujte prosím tento e-mail za bezpředmětný.</p>";
                    mailBody += "<p><br /><br />S pozdravem tým SbírkyPříkladů</p>";
                    emailManager.sendEmail(null, emailTB.Text, "Žádost o registraci uživatelského účtu", mailBody);
                }
                catch (MembershipCreateUserException e) { errorDivTag.InnerHtml += "<li>" + GetErrorMessage(e.StatusCode) + "</li>"; }
                catch (HttpException e) { errorDivTag.InnerHtml += "<li>" + e.Message + "</li>"; }
            }

            if (!string.IsNullOrEmpty(errorDivTag.InnerHtml))
            {
                errorDivTag.InnerHtml = "<strong>Něco je špatně!</strong><ul>" + errorDivTag.InnerHtml;
                errorDivTag.InnerHtml += "</ul>";
                errorDivTag.Visible = true;
                return;
            }
            else
            {
                errorDivTag.Visible = false;
            }
            contentPN.Visible = false;
            successPN.Visible = true;            
        }

        public string GetErrorMessage(MembershipCreateStatus status)
        {
            switch (status)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "Uživatel s tímto e-mailem již existuje.";
                case MembershipCreateStatus.DuplicateEmail:
                    return "Uživatel s tímto e-mailem již existuje.";
                case MembershipCreateStatus.InvalidPassword:
                    return "Heslo nesplňuje požadavky, opravte jej prosím.";
                case MembershipCreateStatus.InvalidEmail:
                    return "E-mailová adresa je chybná.";
                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";
                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";
                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";
                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
                default:
                    return "Nastala neznámá chyba. Pokud potíže přetrvávají, kontaktuje správce systému.";
            }
        }
    }
}