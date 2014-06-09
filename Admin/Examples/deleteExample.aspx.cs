using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Examples
{
    public partial class deleteExample : System.Web.UI.Page
    {
        Int64 exampleId { get { return Convert.ToInt64(Request.QueryString["id"].ToString()); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (exampleManager.getExampleOwnerId(exampleId) != user.uniqueId && Roles.GetRolesForUser()[0] != "Moderator" && Roles.GetRolesForUser()[0] != "Administrator") Response.End();
        }

        protected void confirmCHB_CheckedChanged(object sender, EventArgs e)
        {
            deleteBT.Enabled = confirmCHB.Checked;
        }

        protected void changeOwnerToRoot(object sender, EventArgs e)
        {
            if (!confirmCHB.Checked) return;
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [examples] SET [lastOwnerBeforeDeleting] = @lastOwner, [ownerId] = @spId, [deletingDate] = @delDate, [status] = @status WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@lastOwner", exampleManager.getExampleOwnerId(exampleId).ToString());
                dboManager.command.Parameters.AddWithValue("@spId", user.rootUserUniqueId.ToString());
                dboManager.command.Parameters.AddWithValue("@delDate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@status", "DELETED");
                dboManager.command.Parameters.AddWithValue("@id", Request.QueryString["id"].ToString());
                dboManager.command.ExecuteNonQuery();
            }
            Response.Redirect("/Admin/Examples/myExampleList.aspx", true);
        }
    }
}