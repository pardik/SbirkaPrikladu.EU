using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Admin.Examples
{
    public partial class myExampleList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [examples] WHERE [ownerId] = @ownerId ORDER BY [lastUpdate] DESC";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("ownerId", user.uniqueId.ToString());
        }
    }
}