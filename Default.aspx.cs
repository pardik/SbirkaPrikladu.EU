using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.RouteData.Values["groupId"] != null) { topHeroUnitTag.Visible = false; examplesFromGroupIdUC.groupId = Page.RouteData.Values["groupId"].ToString(); lastInsertedExamplesUC.Visible = false; }
            if (!user.isAnonymous) topHeroUnitTag.Visible = false;

            if (Session["pf2013Showed"] == null) Session["pf2013Showed"] = DateTime.Now;
            else if (Convert.ToDateTime(Session["pf2013Showed"].ToString()) > DateTime.Now.AddMinutes(-30)) pf2013Tag.Visible = false;
            else Session["pf2013Showed"] = null;

            if (DateTime.Now > new DateTime(2013, 01, 10)) pf2013Tag.Visible = false;
        }        
    }
}