using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SbirkaPrikladuEU.Class
{
    public partial class reportExampleBT : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (user.isAnonymous) { reportExampleABT.Visible = false; reportExampleModalPN.Visible = false; }
            if (!IsPostBack)
            {                
                reportExampleTextTB.Text = "Dobrý den!" + Environment.NewLine + "Chci nahlásit příklad " + Request.Url.AbsoluteUri + Environment.NewLine + Environment.NewLine + "Příklad hlásím z těchto důvodů:" + Environment.NewLine;
            }
        }

        protected void submitBT_Click(object sender, EventArgs e)
        {
            Int64 exampleId = Convert.ToInt64(Page.RouteData.Values["exampleId"].ToString());
            string emailText = reportExampleTextTB.Text;
            emailText = emailText.Replace("\r\n", "<br />");

            emailText += "<br /><br /><br />--<br />Zprávu odeslal uživatel " + user.fullName();
            if (string.IsNullOrEmpty(user.fullName())) emailText += "- anonymně (uživatel nebyl přihlášen).";
            emailText += "<br />Url příkladu: " + Request.Url.AbsoluteUri;
            emailText += "<br />IP odesilatele: " + Request.UserHostAddress;
            emailManager.sendEmail(null, "podpora@sbirkaprikladu.eu", "Hlášení příkladu č." + exampleId, emailText);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "info", "showInfo('<h3>SbírkaPříkladů.eu</h3><p></p><p>Příklad byl nahlášen na uživatelskou podporu. Děkujeme.</p>', 'alert-succes');", true);
        }
    }
}