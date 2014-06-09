using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class footer : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string script = @"$(document).ready(function(){
                        recomputeFooterPosition();
                        });                        
                        ";                        
            
            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, this.GetType(), "footerMovingScript", script, true);            
        }
    }
}