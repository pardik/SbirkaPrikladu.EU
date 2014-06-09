using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class printBT : System.Web.UI.UserControl
    {
        public string whatIsPrinting { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (whatIsPrinting == "collection")
            {
                examplePrintTextDIV.Visible = false;
            }
            if (whatIsPrinting == "example")
            {
                collectionPrintTextDIV.Visible = false;
                examplesSpacesDIV.Visible = false;
            }
        }
    }
}