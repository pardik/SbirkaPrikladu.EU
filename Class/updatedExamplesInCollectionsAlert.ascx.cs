using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;

namespace SbirkaPrikladuEU.Class
{
    public partial class updatedExamplesInCollectionsAlert : System.Web.UI.UserControl
    {
        public string exampleId { get { return exampleIdHF.Value; } set { exampleIdHF.Value = value; } }
        public string collectionId { get { return collectionIdHF.Value; } set { collectionIdHF.Value = value; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (user.isAnonymous) return;
            if (!(collectionManager.getCollectionOwnerId(Convert.ToInt64(collectionId)) == user.uniqueId || Roles.GetRolesForUser()[0] == "Moderator" || Roles.GetRolesForUser()[0] == "Administrator")) return;

            if (string.IsNullOrEmpty(exampleId)) return;
            if (string.IsNullOrEmpty(collectionId)) return;
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examplesInCollections] WHERE [exampleId] = @eId AND [collectionId] = @cId";
                dboManager.command.Parameters.AddWithValue("@eId", exampleId);
                dboManager.command.Parameters.AddWithValue("@cId", collectionId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return;
                DateTime inCollDate = Convert.ToDateTime(reader["compareDate"].ToString());
                if (inCollDate < exampleManager.getExampleLastUpdate(Convert.ToInt64(exampleId)))
                {
                    alertDIV.Visible = true;
                    (Page.Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).RegisterAsyncPostBackControl(okBT);
                }
            }
        }

        protected void ok_Click(object sender, EventArgs e)
        {
            alertDIV.Visible = false;
            using (dboManager dboManager = new dboManager())
            {                
                dboManager.command.CommandText = "UPDATE examplesInCollections SET compareDate = @dateTime WHERE (id IN (SELECT examplesInCollections_1.id FROM examplesInCollections AS examplesInCollections_1 INNER JOIN collections ON examplesInCollections_1.collectionId = collections.id WHERE (collections.ownerId = @userId) AND (examplesInCollections_1.exampleId = @exampleId)))";
                dboManager.command.Parameters.AddWithValue("@dateTime", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@exampleId", exampleId);
                dboManager.command.Parameters.AddWithValue("@userId", collectionManager.getCollectionOwnerId(Convert.ToInt64(collectionId)));
                dboManager.command.ExecuteNonQuery();
            }
        }
    }
}