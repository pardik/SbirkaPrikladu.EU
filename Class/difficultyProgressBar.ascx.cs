using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class difficultyProgressBar : System.Web.UI.UserControl
    {
        int _difficulty = 0;
        public int difficulty
        { 
            get { return _difficulty; }
            set 
            {
                _difficulty = value;
                barDiv.Attributes.CssStyle.Clear();
                if (difficulty >= 0)
                {
                    barDiv.InnerText = difficulty.ToString();
                    barDiv.Attributes.CssStyle.Add("width", (difficulty * 20).ToString() + "%");
                }
                else
                {                    
                    barDiv.Attributes.CssStyle.Add("width", "0%");
                    coverDiv.InnerHtml = "Nelze&nbsp;určit";                    
                    coverDiv.Attributes.CssStyle.Add("font-size", ".8em");
                    coverDiv.Attributes.CssStyle.Add("text-align", "center");
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}