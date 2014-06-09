using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Users
{
    public partial class deleteUser : System.Web.UI.Page
    {
        Guid userId { get { return new Guid(Request.QueryString["userId"].ToString()); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (user.uniqueId == userId) { PN01.Visible = false; PN02.Visible = true; deleteBT.Visible = false; }            
        }

        protected void confirmCHB_CheckedChanged(object sender, EventArgs e)
        {
            deleteBT.Enabled = confirmCHB.Checked;
        }

        protected void deleteAccount(object sender, EventArgs e)
        {
            user.deleteUserAccount(userId);
            Response.Redirect("/Admin/Users/userAccountList.aspx", true);
        }
    }
}