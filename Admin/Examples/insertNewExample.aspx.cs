using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Examples
{
    public partial class insertNewExample : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (user.isAnonymous) Response.End();
            if (Roles.GetRolesForUser()[0] != "Author" && Roles.GetRolesForUser()[0] != "Moderator" && Roles.GetRolesForUser()[0] != "Administrator") Response.End();
            if (!IsPostBack)
            {
                new mpTreeView().fillTreeView("exampleGroups", exampleGroupsTV);
                exampleGroupsTV.CollapseAll();
                exampleGroupsTV.Nodes[0].Expand();
                helpWizzardVisibilitySet(true);
                finalBT.Attributes.Add("onclick", " this.disabled = true; " + ClientScript.GetPostBackEventReference(finalBT, null) + ";");                
            }
            else
            {
                helpWizzardVisibilitySet(false);
            }

            showPanelsAndButtons();
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (user.getCreatedExamplesNr(user.uniqueId) < 3)   //register helpWizzard clientscript if less 3 examplex inserted by loged user
            {
                AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "clrAllTimeoutsScript", "clearAllTimeouts();", true);
                switch (currentPageHF.Value)
                {
                    case "1": AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "helpWizzardScriptA", "if($('#" + PNL01.ClientID + "').css('visibility')=='visible'){helpWizz(1000, '#helpA00', 25000, 'right');helpWizz(8000, '#helpA01', 8000, 'right', 310);helpWizz(14000, '#helpA02', 8000, 'right', 240);helpWizz(20000, '#helpA03', 5000, 'left', 0, 80);}", true);
                        break;
                    case "2": AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "helpWizzardScriptB", "if($('#" + PNL02.ClientID + "').css('visibility')=='visible'){helpWizz(2000, '#helpB01', 5000, 'left', -200);helpWizz(8000, '#helpB02', 5000, 'bottom', 0, -200);helpWizz(14000, '#helpB03', 5000);helpWizz(20000, '#helpA03', 5000, 'left', 0, 80);}", true);
                        break;
                    case "3":
                        break;
                    case "4":
                        break;
                    case "5": AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "helpWizzardScriptE", "if($('#" + PNL05.ClientID + "').css('visibility')=='visible'){helpWizz(2000, '#helpE01', 5000, 'right', 0, -200);helpWizz(8000, '#helpE02', 5000, 'right', 100);helpWizz(14000, '#helpE03', 3000, 'right', 50);helpWizz(17000, '#helpE04', 3000, 'right', 50);helpWizz(20000, '#helpE05', 3000, 'right', 50);helpWizz(24000, '#helpE06', 5000, 'bottom', -70);}", true);
                        break;
                }
            }
        }

        protected void helpWizzardVisibilitySet(bool visible)
        {            
            if (user.getCreatedExamplesNr(user.uniqueId) >= 3) visible = false;
            helpA00.Visible = visible;
            helpA01.Visible = visible;
            helpA02.Visible = visible;
            helpA03.Visible = visible;
            helpB01.Visible = visible;
            helpB02.Visible = visible;
            helpB03.Visible = visible;
            helpE01.Visible = visible;
            helpE02.Visible = visible;
            helpE03.Visible = visible;
            helpE04.Visible = visible;
            helpE05.Visible = visible;
            helpE06.Visible = visible;            
        }

        protected void showPanelsAndButtons()
        {
            
            backBT.Visible = true;
            continueBT.Visible = true;
            finalBT.Visible = false;
            PNL01.Visible = false;
            PNL02.Visible = false;
            PNL03.Visible = false;
            PNL04.Visible = false;
            PNL05.Visible = false;
            summaryErrorPN.Visible = false;
            navDDLBT.Attributes.Remove("class");
            navDDLBT.Attributes.Add("class", "btn btn-large btn-primary dropdown-toggle");

            switch (currentPageHF.Value)
            {
                case "1": H1Tag.InnerHtml = "Je skvělé, že chcete rozšířit sbírku o nový příklad";                    
                    backBT.Visible = false;
                    PNL01.Visible = true;
                    break;
                case "2": H1Tag.InnerHtml = "Zadání příkladu";                    
                    PNL02.Visible = true;
                    break;
                case "3": H1Tag.InnerHtml = "Řešení příkladu";                    
                    PNL03.Visible = true;
                    break;
                case "4": H1Tag.InnerHtml = "Výsledek příkladu";
                    PNL04.Visible = true;
                    break;
                case "5": H1Tag.InnerHtml = "Sumarizace";
                    PNL05.Visible = true;
                    continueBT.Visible = false;
                    finalBT.Visible = true;
                    navDDLBT.Attributes.Remove("class");
                    navDDLBT.Attributes.Add("class", "btn btn-large btn-success dropdown-toggle");
                    selectedSchoolGradeToSummary();
                    selectedGroupsToSumary();
                    validateSummary();
                    break;
            }
        }

        protected void selectedNodeChanged(object sender, EventArgs e)
        {
            if (exampleGroupsTV.Nodes[0].Selected) return;
            if (Convert.ToBoolean(exampleGroupsTV.SelectedNode.Expanded)) exampleGroupsTV.SelectedNode.Collapse();
            else exampleGroupsTV.SelectedNode.Expand();
            exampleGroupsTV.Nodes[0].Select();
        }

        protected void continueBT_Click(object sender, EventArgs e)
        {
            int pom = Convert.ToInt32(currentPageHF.Value);
            pom++;
            currentPageHF.Value = pom.ToString();
            showPanelsAndButtons();
            helpWizzardVisibilitySet(true);
        }

        protected void backBT_Click(object sender, EventArgs e)
        {
            int pom = Convert.ToInt32(currentPageHF.Value);
            pom--;
            currentPageHF.Value = pom.ToString();
            showPanelsAndButtons();
        }

        protected void schoolGradeCHBL_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = 0;
            foreach (ListItem li in schoolGradeCHBL.Items) if (li.Selected) i++;
            if (i > 1) { difficultyRBL.SelectedIndex = 2; difficultyRBL.Enabled = false; }
            else difficultyRBL.Enabled = true;
        }

        protected void selectedSchoolGradeToSummary()
        {
            string pomStr = "";
            foreach (ListItem li in schoolGradeCHBL.Items)
            {
                if (!string.IsNullOrEmpty(pomStr)) pomStr += ", ";
                if (li.Selected) pomStr += li.Text;
            }
            summarySchoolGradeLB.Text = pomStr;
        }

        protected void selectedGroupsToSumary()
        {
            summaryGroupsTag.InnerHtml = "<strong>Zařazen do skupin:</strong><br />";
            int i = 0;
            foreach (TreeNode tvN in exampleGroupsTV.CheckedNodes)
            {
                if (i > 0) summaryGroupsTag.InnerHtml += "<br />";
                summaryGroupsTag.InnerHtml += tvN.Text;
                i = 1;
            }
        }

        protected void gotoPage(object sender, EventArgs e)
        {
            currentPageHF.Value = (sender as Button).Attributes["dataKey"].ToString();
            showPanelsAndButtons();
            helpWizzardVisibilitySet(true);
        }

        protected void gotoPageLB_Click(object sender, EventArgs e)
        {
            currentPageHF.Value = (sender as LinkButton).ID.Replace("LB", "");
            showPanelsAndButtons();
            helpWizzardVisibilitySet(true);
        }

        protected void validateSummary()
        {
            summaryErrorsTag.InnerHtml = null;
            if (string.IsNullOrEmpty(exampleNameTB.Text.Replace(" ", ""))) summaryErrorsTag.InnerHtml += "Není vyplněn název příkladu.<br />";
            if (exampleGroupsTV.CheckedNodes.Count < 1) summaryErrorsTag.InnerHtml += "Příklad musí být zařazen minimálně do jedné skupiny.<br />";
            if (schoolGradeCHBL.SelectedItem == null) summaryErrorsTag.InnerHtml += "Zvolte pro který školní stupěň je příklad určen.<br />";
            if (string.IsNullOrEmpty(enterCKE.Text.Replace(" ", ""))) summaryErrorsTag.InnerHtml += "Zadání příkladu je povinné. Vyplňte jej prosím.<br />";
            if (string.IsNullOrEmpty(resultCKE.Text.Replace(" ", ""))) summaryErrorsTag.InnerHtml += "Výsledek příkladu je povinný. Vyplňte jej prosím.<br />";

            if (string.IsNullOrEmpty(summaryErrorsTag.InnerHtml))
            {
                finalBT.Enabled = true;
                finalBT.ToolTip = "";
                summaryErrorPN.Visible = false;
            }
            else
            {
                finalBT.Enabled = false;
                finalBT.ToolTip = "Nemáte vyplněna všechna povinná pole";                
                summaryErrorPN.Visible = true;
            }
        }

        protected void insertExample(object sender, EventArgs e)
        {
            string name = exampleNameTB.Text;
            while (name.Contains("  ")) name = name.Replace("  ", " ");
            name = name.Trim();

            string labels = labelNamesTB.Text;            
            while (labels.Contains("  ")) labels = labels.Replace("  ", " ");
            while (labels.Contains(", ")) labels = labels.Replace(", ", ",");
            while (labels.Contains(" ,")) labels = labels.Replace(" ,", ",");
            while (labels.Contains(",,")) labels = labels.Replace(",,", ",");

            string groupIds = "";
            foreach (TreeNode tvN in exampleGroupsTV.CheckedNodes) groupIds += "-" + tvN.Value + "-";
            groupIds = groupIds.Replace("--", "-");

            string schoolGradeIds = "";
            foreach (ListItem li in schoolGradeCHBL.Items) if (li.Selected) schoolGradeIds += "-" + li.Value + "-";
            schoolGradeIds = schoolGradeIds.Replace("--", "-");

            exampleManager.addNewExample(name, enterCKE.Text, solutionCKE.Text, resultCKE.Text, groupIds, schoolGradeIds, Convert.ToInt32(difficultyRBL.SelectedValue), labels);

            PNL05.Visible = false;
            headerDiv.Visible = false;
            successPN.Visible = true;
        }

        protected void expandAllGroupsBT_Click(object sender, EventArgs e)
        {
            exampleGroupsTV.ExpandAll();
            expandAllGroupsBT.Visible = false;
            collapseAllGroupsBT.Visible = true;
        }
        
        protected void collapseAllGroupsBT_Click(object sender, EventArgs e)
        {
            exampleGroupsTV.CollapseAll();
            exampleGroupsTV.Nodes[0].Expand();
            expandAllGroupsBT.Visible = true;
            collapseAllGroupsBT.Visible = false;
        }

        protected void youTubeurlBT_Click(object sender, EventArgs e)
        {
            var video = "";
            //video = youTubeUrlTB.Text.Substring(youTubeUrlTB.Text.LastIndexOf("v=") + 2);
            video = youTubeUrlTB.Text.Substring(youTubeUrlTB.Text.LastIndexOf("v=")).Split(new[] { '?', '&' }).FirstOrDefault(a => a.Contains("v=")).Substring(2);
            solutionCKE.Text += "<iframe width='450' height='300' src='//www.youtube.com/embed/" + video + "?rel=0' frameborder='0' allowfullscreen></iframe>";
            youTubeUrlTB.Text = "";
        }
    }
}