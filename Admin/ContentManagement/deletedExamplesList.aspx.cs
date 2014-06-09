using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU.Admin.ContentManagement
{
    public partial class deletedExamplesList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void deleteExampleDefinitively(object sender, EventArgs e)
        {
            Int64 id = Convert.ToInt64(deleteIdHF.Value);

            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examplesInCollections] WHERE [exampleId] = @exid"; //select example included collections ids
                dboManager.command.Parameters.AddWithValue("@exId", id);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                List<Int64> pomIds = new List<Int64>();
                while (reader.Read()) pomIds.Add(Convert.ToInt64(reader["collectionId"].ToString()));       //save example included collections ids
                reader.Dispose();
                dboManager.command.CommandText = "DELETE [examplesInCollections] WHERE [exampleId] = @exId;";    //delete example from collections                
                dboManager.command.CommandText += "DELETE [examples] WHERE [id] = @exId;";           //delete example from dtb
                dboManager.command.ExecuteNonQuery();
                foreach (Int64 pomId in pomIds) collectionManager.recomputePositions(pomId);                //recompute examples positions in affected collections
            }

            foreach (GridViewRow gwr in examplesGW.Rows)
            {
                if (examplesGW.DataKeys[gwr.RowIndex].Value.ToString() == id.ToString()) gwr.Visible = false;
            }            
        }
    }
}