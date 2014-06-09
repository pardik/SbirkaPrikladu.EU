using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class addExampleToCollectionBT : System.Web.UI.UserControl
    {
        Int64 _exampleId = 0;
        public Int64 exampleId { get { return _exampleId; } set { _exampleId = value; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (user.isAnonymous) insertToCollectionBT.Visible = false;
                SqlDataSource1.SelectCommand = "SELECT * FROM [collections] WHERE [ownerId] = @ownerId";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("ownerId", user.uniqueId.ToString());
                collectionsDDL.DataBind();
                if (collectionsDDL.Items.Count == 0) { modalBodyOK.Visible = false; modalBodyNoCollections.Visible = true; insertCollectionModalBT.Visible = false; }

                if (Session["collectionToInsertId"] != null)
                    foreach (ListItem li in collectionsDDL.Items) if (li.Value == Session["collectionToInsertId"].ToString()) { li.Selected = true; break; }                
            }
            if (Session["collectionToInsertId"] != null)
            {
                insertToCollectionBT.Visible = false; 
                insertToTheSamePN.Visible = true;
                addToTheSameBT.ToolTip = "Vložit do sbírky: " + collectionManager.getCollectionName(Convert.ToInt64(Session["collectionToInsertId"].ToString()));
                addToTheSame2BT.ToolTip = "Vložit do sbírky: " + collectionManager.getCollectionName(Convert.ToInt64(Session["collectionToInsertId"].ToString()));
            }
        }

        protected void insertToCollection(object sender, EventArgs e)
        {
            Session["collectionToInsertId"] = collectionsDDL.SelectedValue;            
            switch (collectionManager.insertExampleToCollection(exampleId, Convert.ToInt64(collectionsDDL.SelectedValue)))
            {
                case "OK": ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p></p><p>Příklad byl úspěšně přidán do sbírky: " + collectionManager.getCollectionName(Convert.ToInt64(collectionsDDL.SelectedValue)) + "</p>', 'alert-succes');", true); break;
                case "noMultiple": ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p>Příklad je již ve sbírce " + collectionManager.getCollectionName(Convert.ToInt64(collectionsDDL.SelectedValue)) + " obsažen na pozici č." + collectionManager.getExamplePosition(exampleId, Convert.ToInt64(collectionsDDL.SelectedValue)) + ".<br />Každý příklad může být v každé sbírce jen jednou.</p>', 'alert-info');", true); break;
            }            
        }        
    }
}