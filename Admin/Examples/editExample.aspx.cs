using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;

namespace SbirkaPrikladuEU.Admin.Examples
{
    public partial class editExample : System.Web.UI.Page
    {
        Int64 exampleId { get { return Convert.ToInt64(Request.QueryString["id"].ToString()); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (exampleManager.getExampleOwnerId(exampleId) != user.uniqueId && Roles.GetRolesForUser()[0] != "Moderator" && Roles.GetRolesForUser()[0] != "Administrator") Response.End();
            if (!IsPostBack)
            {
                new mpTreeView().fillTreeView("exampleGroups", exampleGroupsTV);
                exampleGroupsTV.CollapseAll();
                exampleGroupsTV.Nodes[0].Expand();
                fillControls();
            }

            showPanelsAndButtons();
        }

        protected void fillControls()
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examples] WHERE [id] = @exampleId";
                dboManager.command.Parameters.AddWithValue("@exampleId", exampleId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) Response.End();                
                exampleNameTB.Text = reader["name"].ToString();
                enterCKE.Text = reader["enter"].ToString();
                solutionCKE.Text = reader["solution"].ToString();
                resultCKE.Text = reader["result"].ToString();
                labelNamesTB.Text = reader["labels"].ToString();

                foreach (ListItem li in schoolGradeCHBL.Items) if (reader["schoolGrade"].ToString().Contains("-" + li.Value + "-")) li.Selected = true;
                schoolGradeCHBL_SelectedIndexChanged(null, null);
                foreach (ListItem li in difficultyRBL.Items) if (li.Value == reader["difficulty"].ToString()) { li.Selected = true; break; }

                foreach (string id in reader["groupIds"].ToString().Split('-'))
                {
                    if (id == "") continue;
                    TreeNode tn = new mpTreeView().findNodeByValue(exampleGroupsTV.Nodes, id);
                    tn.Checked = true;
                    while (tn.Parent != null) { tn.Expand(); tn = tn.Parent; }
                }
            }
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
                case "1": H1Tag.InnerHtml = "Upravte příklad dle Vašich požadavků";
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
        }

        protected void gotoPageLB_Click(object sender, EventArgs e)
        {
            currentPageHF.Value = (sender as LinkButton).ID.Replace("LB", "");
            showPanelsAndButtons();
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

        protected void updateExample(object sender, EventArgs e)
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

            exampleManager.updateExample(exampleId, name, enterCKE.Text, solutionCKE.Text, resultCKE.Text, groupIds, schoolGradeIds, Convert.ToInt32(difficultyRBL.SelectedValue), labels);

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
            video = youTubeUrlTB.Text.Substring(youTubeUrlTB.Text.LastIndexOf("v=")).Split(new[] {'?', '&'}).FirstOrDefault(a => a.Contains("v=")).Substring(2);
            solutionCKE.Text += "<iframe width='450' height='300' src='//www.youtube.com/embed/" + video + "?rel=0' frameborder='0' allowfullscreen></iframe>";
            youTubeUrlTB.Text = "";
        }
    }
}