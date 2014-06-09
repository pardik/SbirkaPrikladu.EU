using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class updateUserProfile : System.Web.UI.Page
    {
        Guid userId { get { return user.uniqueId; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MembershipUser mu = Membership.GetUser();
                string userRole = Roles.GetRolesForUser(mu.UserName)[0].ToString();
                nameTB.Text = user.getName(userId);
                surnameTB.Text = user.getSurName(userId);
                emailTB.Text = mu.Email;                
            }
        }

        public void updateUserBT_Click(object sender, EventArgs args)
        {
            errorDivTag.InnerHtml = null;
            if (passTB.Text.Contains(" ")) errorDivTag.InnerHtml += "<li>Heslo nesmí obsahovat mezery</li>";
            if (passTB.Text != pass2TB.Text) errorDivTag.InnerHtml += "<li>Zadaná hesla nejsou stejná</li>";
            if (passTB.Text.Count() > 0 && passTB.Text.Count() < Membership.MinRequiredPasswordLength) errorDivTag.InnerHtml += "<li>Minimální délka hesla je " + Membership.MinRequiredPasswordLength + " znaků</li>";
            if (Membership.FindUsersByEmail(emailTB.Text).Count > 0 && Membership.GetUser(userId).Email.ToLower().Trim() != emailTB.Text.ToLower().Trim()) errorDivTag.InnerHtml += "<li>Pro tento e-mail je již registrován jiný uživatel</li>";

            if (string.IsNullOrEmpty(errorDivTag.InnerHtml))
            {
                try
                {
                    user.updateUserAccount(userId, user.uniqueId, emailTB.Text, passTB.Text, nameTB.Text, surnameTB.Text);
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
            Response.Redirect("/", true);
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