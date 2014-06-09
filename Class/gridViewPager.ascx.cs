using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class gridViewPager : System.Web.UI.UserControl
    {
        GridView examplesGW = new GridView();

        protected void Page_Load(object sender, EventArgs e)
        {
            while (sender.ToString() != "System.Web.UI.WebControls.GridView") sender = (sender as Control).Parent;
            examplesGW = sender as GridView;
            examplesGW.DataBound += examplesGW_DataBound;
        }

        protected void examplesGW_DataBound(object sender, EventArgs e)
        {
            GridViewRow pagerRow = examplesGW.BottomPagerRow;
            if (pagerRow != null)
            {
                List<int> pages = new List<int>();
                if (examplesGW.PageIndex < 10) for (int i = 0; i < 20; i++) { if (i >= examplesGW.PageCount) break; pages.Add(i + 1); }
                else if (examplesGW.PageIndex > examplesGW.PageCount - 20) for (int i = examplesGW.PageCount - 20; i < examplesGW.PageCount; i++) pages.Add(i + 1);
                else for (int i = examplesGW.PageIndex - 10; i < examplesGW.PageIndex + 10; i++) pages.Add(i + 1);
                
                repPager.DataSource = pages;
                repPager.DataBind();
                LinkButton pomLB = new LinkButton();

                try
                {
                    for (int j = 0; j < repPager.Items.Count; j++)
                    {
                        pomLB = repPager.Items[j].FindControl("lnkPage") as LinkButton;
                        if (pomLB.Text == (examplesGW.PageIndex + 1).ToString()) pomLB.CssClass = "btn btn-mini active gwPagerBtn";
                    }
                }
                catch { }
            }
        }

        protected void repPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ChangePage")
            {
                examplesGW.PageIndex = Convert.ToInt32(e.CommandArgument) - 1;
            }
        }

        protected void firstPageLB_Click(object sender, EventArgs e)
        {
            examplesGW.PageIndex = 0;
        }

        protected void lastPageLB_Click(object sender, EventArgs e)
        {
            examplesGW.PageIndex = examplesGW.PageCount - 1;
        }
    }
}