using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;

namespace SbirkaPrikladuEU
{
    public partial class showExample : System.Web.UI.Page
    {
        public int difficulty = 0;
        public Int64 exampleId { get { return Convert.ToInt64(Page.RouteData.Values["exampleId"].ToString()); } }

        protected void Page_Load(object sender, EventArgs e)
        {            
            if(!IsPostBack) fillControls();
            groupMenuUC.selectedNodeId = exampleManager.getExampleGroupIds(Convert.ToInt64(Page.RouteData.Values["exampleId"].ToString()))[0].ToString();
            addExampleToCollectionUC.exampleId = exampleId;
        }
        
        protected void fillControls()
        {            
            if (Page.RouteData.Values["exampleId"] == null) return;
            
            ratingStarsUC.exampleId = exampleId;            
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examples] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (!reader.Read()) return;

                char[] pomChar = reader["name"].ToString().Trim().ToCharArray();
                pomChar[0] = char.ToUpper(pomChar[0]);      // first letter to uppercase
                nameLB.InnerText = new string(pomChar);

                pomChar = reader["name"].ToString().Trim().ToCharArray();
                pomChar[0] = char.ToUpper(pomChar[0]);      // first letter to uppercase
                Header.Title = new string(pomChar);

                exampleNrLB.Text = reader["id"].ToString();

                List<string> groupsNames = exampleManager.groupNames(reader["groupIds"].ToString());
                exampleGroupsTag.InnerHtml = "";
                foreach (string name in groupsNames) exampleGroupsTag.InnerHtml += name + "<br />";
                                
                schoolGradeLB.Text = exampleManager.schoolGradeToText(reader["schoolGrade"].ToString());
                exampleAuthorLB.Text = exampleManager.authorFullName(exampleId);
                difficulty = Convert.ToInt32(reader["difficulty"].ToString());
                difficultyProgressBarUC.difficulty = difficulty;

                enterPN.InnerHtml = reader["enter"].ToString();
                solutionPN.InnerHtml = reader["solution"].ToString();
                if (string.IsNullOrEmpty(solutionPN.InnerHtml)) solutionDiv.InnerHtml = "<div class='alert alert-info'><span type='button' class='close' data-dismiss='alert'>&times;</span><h3>Řešení příkladu není k dispozici</h3></div>";                
                resultPN.InnerHtml = reader["result"].ToString();

                if (!user.isAnonymous && (reader["ownerId"].ToString() == user.uniqueId.ToString() || Roles.GetRolesForUser()[0] == "Moderator" || Roles.GetRolesForUser()[0] == "Administrator")) editBtDiv.Visible = true;
                else editBtDiv.Visible = false;
            }
            
        }
    }
}