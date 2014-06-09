using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Collections
{
    public partial class editCollection : System.Web.UI.Page
    {
        public Int64 collectionId { get { return Convert.ToInt64(Request.QueryString["id"].ToString()); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!collectionManager.isCollectionPublic(collectionId) && user.isAnonymous) Response.End();
            if (!collectionManager.isCollectionPublic(collectionId) && !(collectionManager.getCollectionOwnerId(collectionId) == user.uniqueId || Roles.GetRolesForUser()[0] == "Moderator" || Roles.GetRolesForUser()[0] == "Administrator")) Response.End();

            if (!IsPostBack)
            {                
                fillControlls();
                examplesRPT.DataBind();
                if (user.getCreatedCollectionsNr(user.uniqueId) < 3)
                {
                    if (examplesRPT.Items.Count > 0) AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "helpWizzardScriptA", "helpWizz(2000, '#helpA01', 5000, 'right', 0, -300);helpWizz(8000, '#helpA02', 5000, 'bottom');", true);
                    else AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "helpWizzardScriptA", "helpWizz(2000, '#helpA01', 5000, 'right', 0, -300);", true);
                    helpWizzardVisibilitySet(true);
                }
                else helpWizzardVisibilitySet(false);                
            }
            else
            {
                helpWizzardVisibilitySet(false);
            }
        }

        protected void fillControlls()
        {
            SqlDataSource1.SelectCommand = "SELECT examples.*, examplesInCollections.position FROM examplesInCollections INNER JOIN examples ON examplesInCollections.exampleId = examples.id WHERE (examplesInCollections.collectionId = @collectionId) ORDER BY position";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("collectionId", collectionId.ToString());

            nameTB.Text = collectionManager.getCollectionName(collectionId);
            labelsTB.Text = collectionManager.getLabels(collectionId);
        }

        protected void examplesRepeaterItemCreated(object sender, RepeaterItemEventArgs e)
        {
            (Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).RegisterAsyncPostBackControl((e.Item.FindControl("positionTB") as SbirkaPrikladuEU.Class.mpTextBox).textBoxPointer);  //asyncpostback registration for positionTB in Repeater
            (Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).RegisterAsyncPostBackControl(e.Item.FindControl("deleteExampleFromCollectionBT") as LinkButton);  //asyncpostback registration for exampleDeletedBT in Repeater
            (Master.FindControl("ScriptManager1") as AjaxControlToolkit.ToolkitScriptManager).RegisterAsyncPostBackControl(e.Item.FindControl("deleteExampleFromCollectionContentBT") as LinkButton);  //asyncpostback registration for exampleDeletedContentBT in Repeater
        }

        protected void changeCollectionName(object sender, EventArgs e)
        {
            try
            {                
                collectionManager.renameCollection(collectionId, nameTB.Text);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p></p><p>Název sbírky byl změněn na <strong>" + nameTB.Text + "</strong></p>', 'alert-succes');", true);
            }
            catch (Exception Ex) { ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p>Přejmenování se nezdařilo. Patrně nastal problém s připojením k databázi. Zkuste to později, prosím.</p><p>" + Ex.Message.Replace("'", "").Replace("\"", "") + "</p>', 'alert-danger');", true); fillControlls(); }
        }

        protected void changeExamplePosition(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((sender as SbirkaPrikladuEU.Class.mpTextBox).Text)) { fillControlls(); return; }
            try
            {
                Int64 newPos = Convert.ToInt64((sender as SbirkaPrikladuEU.Class.mpTextBox).Text);
                Int64 exampleId = Convert.ToInt64((sender as SbirkaPrikladuEU.Class.mpTextBox).dataKey);
                collectionManager.changeExamplePosition(collectionId, exampleId, newPos);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p></p><p>Příklad <strong>" + exampleManager.getExampleName(exampleId) + "</strong> byl přesunut na pozici <strong>" + newPos + "</strong></p>', 'alert-succes');", true);
                fillControlls();                
            }
            catch (Exception Ex) { ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p>Změna pořadí se nezdařila. Patrně nastal problém s připojením k databázi. Zkuste to později, prosím.</p><p>" + Ex.Message.Replace("'", "").Replace("\"", "") + "</p>', 'alert-danger');", true); fillControlls(); }
        }

        protected void deleteExampleFromCollection(object sender, EventArgs e)
        {
            try
            {
                Int64 exampleId = Convert.ToInt64((sender as LinkButton).CommandArgument);
                collectionManager.deleteExampleFromCollection(collectionId, exampleId);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p></p><p>Ze sbírky byl odebrán příklad <strong>" + exampleManager.getExampleName(exampleId) + "</strong></p>', 'alert-succes');", true);
                fillControlls();
            }
            catch (Exception Ex) { ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p>Smazání příkladu ze sbírky se nezdařilo. Patrně nastal problém s připojením k databázi. Zkuste to později, prosím.</p><p>" + Ex.Message.Replace("'","").Replace("\"","") + "</p>', 'alert-danger');", true); fillControlls(); }
        }

        protected void helpWizzardVisibilitySet(bool visible)
        {
            if (user.getCreatedCollectionsNr(user.uniqueId) >= 5) visible = false;
            helpA01.Visible = visible;
            helpA02.Visible = visible;            
        }

        protected void changeLabels(object sender, EventArgs e)
        {
            try
            {
                collectionManager.changeLabels(collectionId, labelsTB.Text);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p></p><p>Štítky byly změněny na <strong>" + labelsTB.Text + "</strong></p>', 'alert-succes');", true);
            }
            catch (Exception Ex) { ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p>Přejmenování se nezdařilo. Patrně nastal problém s připojením k databázi. Zkuste to později, prosím.</p><p>" + Ex.Message.Replace("'", "").Replace("\"", "") + "</p>', 'alert-danger');", true); fillControlls(); }
        }
    }
}