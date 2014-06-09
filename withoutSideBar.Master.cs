using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace SbirkaPrikladuEU
{
    public partial class withoutSideBar : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            registerGwExpandRowScript();
        }

        protected void registerGwExpandRowScript()
        {
            using (StreamReader reader = new StreamReader(Server.MapPath("/Scripts/gwRowExpander.js"))) 
            {
                string str = reader.ReadToEnd();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "gwExpandRowJS", str, true);
            }
            
        }
    }
}