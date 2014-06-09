﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class createUser : System.Web.UI.Page
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
            }
        }
        
        public void createUserBT_Click(object sender, EventArgs args)
        {          
            errorDivTag.InnerHtml = null;            
            if (passTB.Text.Contains(" ")) errorDivTag.InnerHtml += "<li>Heslo nesmí obsahovat mezery</li>";
            if (passTB.Text != pass2TB.Text) errorDivTag.InnerHtml += "<li>Zadaná hesla nejsou stejná</li>";
            if (passTB.Text.Count() < 1) errorDivTag.InnerHtml += "<li>Nezadali jste heslo. Heslo je povinné</li>";
            if (Membership.FindUsersByEmail(emailTB.Text).Count > 0) errorDivTag.InnerHtml += "<li>Pro tento e-mail je již registrován jiný uživatel</li>";
            
            if (string.IsNullOrEmpty(errorDivTag.InnerHtml))
            {
                try 
                {                    
                    user.createUserAccount(emailTB.Text, passTB.Text, nameTB.Text, surnameTB.Text, rolesRBL.SelectedValue);
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