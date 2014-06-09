using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Collections
{
    public partial class deleteCollection : System.Web.UI.Page
    {
        Int64 collectionId { get { return Convert.ToInt64(Request.QueryString["id"].ToString()); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (collectionManager.getCollectionOwnerId(collectionId) != user.uniqueId && Roles.GetRolesForUser()[0] != "Moderator" && Roles.GetRolesForUser()[0] != "Administrator") Response.End();
        }

        protected void confirmCHB_CheckedChanged(object sender, EventArgs e)
        {
            deleteBT.Enabled = confirmCHB.Checked;
        }

        protected void deleteCollectionFromDTB(object sender, EventArgs e)
        {
            if (!confirmCHB.Checked) return;
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "BEGIN TRANSACTION; DELETE [collections] WHERE [id] = @id; DELETE [examplesInCollections] WHERE [collectionId] = @id; COMMIT TRANSACTION;";
                dboManager.command.Parameters.AddWithValue("@id", Request.QueryString["id"].ToString());
                dboManager.command.ExecuteNonQuery();
            }
            Response.Redirect("/Admin/Collections/myCollectionsList.aspx", true);
        }
    }
}