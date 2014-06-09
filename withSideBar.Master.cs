using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace SbirkaPrikladuEU
{
    public partial class withSideBar : System.Web.UI.MasterPage
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
        
        protected void ScriptManager1_Navigate(object sender, HistoryEventArgs e)
        {
            try { beforeBackClickedLastInsertedExamplesPageIndexHF.Value = e.State["beforeBackClickedLastInsertedExamplesGwPageIndex"].ToString(); }
            catch { }
            try { beforeBackClickedExamplesFromGroupPageIndexHF.Value = e.State["beforeBackClickedExamplesFromGroupGwPageIndex"].ToString(); }
            catch { }
            try { beforeBackClickedSearchExamplesByAutorPageIndexHF.Value = e.State["beforeBackClickedSearchExamplesByAutorGWPageIndex"].ToString(); }
            catch { }
        }

    }
}