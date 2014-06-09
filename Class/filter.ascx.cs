using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU.Class
{
    public partial class filter : System.Web.UI.UserControl
    {
        public bool filter1StZs { get { if (ZS1BT.CssClass == "btn active") return true; else return false; } }
        public bool filter2StZs { get { if (ZS2BT.CssClass == "btn active") return true; else return false; } }
        public bool filterStredoskolsky { get { if (stredoskolskyBT.CssClass == "btn active") return true; else return false; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ZS1BT.CssClass=="btn" && ZS2BT.CssClass == "btn" && stredoskolskyBT.CssClass == "btn")
                { 
                    Session["filter1StZs"] = true;
                    Session["filter2StZs"] = true;
                    Session["filterStredoskolsky"] = true;
                    ZS1BT.CssClass = "btn active";
                    ZS2BT.CssClass = "btn active";
                    stredoskolskyBT.CssClass = "btn active";
                    Page.DataBind();
                }
            }
        }

        protected void Page_Prerender(object sender, EventArgs e)
        {
            if (ZS2BT.CssClass == "btn" && stredoskolskyBT.CssClass == "btn") ZS1BT.Enabled = false; else ZS1BT.Enabled = true;
            if (ZS1BT.CssClass == "btn" && stredoskolskyBT.CssClass == "btn") ZS2BT.Enabled = false; else ZS2BT.Enabled = true;
            if (ZS1BT.CssClass == "btn" && ZS2BT.CssClass == "btn") stredoskolskyBT.Enabled = false; else stredoskolskyBT.Enabled = true;
        }

        protected void st1ZS_Click(object sender, EventArgs e)
        {
            if (Session["filter1StZs"] == null) { Session["filter1StZs"] = true; (sender as Button).CssClass = "btn active"; }
            else { Session["filter1StZs"] = null; (sender as Button).CssClass = "btn"; }            
        }

        protected void st2ZS_Click(object sender, EventArgs e)
        {
            if (Session["filter2StZs"] == null) { Session["filter2StZs"] = true; (sender as Button).CssClass = "btn active"; }
            else { Session["filter2StZs"] = null; (sender as Button).CssClass = "btn"; }
        }

        protected void stredoskolsky_Click(object sender, EventArgs e)
        {
            if (Session["filterStredoskolsky"] == null) { Session["filterStredoskolsky"] = true; (sender as Button).CssClass = "btn active"; }
            else { Session["filterStredoskolsky"] = null; (sender as Button).CssClass = "btn"; }
        }
        
        
        
    }
    
}