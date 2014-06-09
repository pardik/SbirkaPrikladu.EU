using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU
{
    public partial class showCollection : System.Web.UI.Page
    {
        public Int64 collectionId { get { return Convert.ToInt64(Page.RouteData.Values["collectionId"].ToString()); } }
        public bool hideExamplesHeaders;
        public bool hideExamplesSolutions;
        public bool hideExamplesResults;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!collectionManager.isCollectionPublic(collectionId) && user.isAnonymous) Response.End();
            if (!collectionManager.isCollectionPublic(collectionId) && !(collectionManager.getCollectionOwnerId(collectionId) == user.uniqueId || Roles.GetRolesForUser()[0] == "Moderator" || Roles.GetRolesForUser()[0] == "Administrator")) Response.End();
            if (!user.isAnonymous && (collectionManager.getCollectionOwnerId(collectionId) == user.uniqueId || Roles.GetRolesForUser()[0] == "Moderator" || Roles.GetRolesForUser()[0] == "Administrator")) editBtDiv.Visible = true;

            hideExamplesHeaders = collectionManager.getHideExaplesHeaders(collectionId);
            hideExamplesSolutions = collectionManager.getHideExaplesSolutions(collectionId);
            hideExamplesResults = collectionManager.getHideExaplesResults(collectionId);

            SqlDataSource1.SelectCommand = "SELECT examples.*, examplesInCollections.position FROM examplesInCollections INNER JOIN examples ON examplesInCollections.exampleId = examples.id WHERE (examplesInCollections.collectionId = @collectionId) ORDER BY position";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("collectionId", collectionId.ToString());

            examplesRPT.DataBind();
        }               
    }
}