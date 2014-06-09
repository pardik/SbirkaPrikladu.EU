using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU.Class
{
    public partial class ratingStars : System.Web.UI.UserControl
    {
        public Int64 exampleId { get { return Convert.ToInt64(exampleIdFH.Value); } set { exampleIdFH.Value = value.ToString(); recomputeRating(); } }
        int _ratingPct = 0;
        public int ratingPct { get { return _ratingPct; } set { _ratingPct = value; } }
        bool _Enabled = true;
        public bool Enabled
        {
            get { return _Enabled; }
            set
            {
                _Enabled = value;
                if (Enabled) { enabledPN.Visible = true; disabledPN.Visible = false; }
                else { disabledPN.Visible = true; enabledPN.Visible = false; }                
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (user.isAnonymous) { Enabled = false; disabledPN.Attributes["title"] = "Hlasovat monou pouze registrovaní uživatelé"; }
            recomputeRating();            
        }

        protected void recomputeRating()
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [userRating] WHERE [exampleId] = @exampleId";
                dboManager.command.Parameters.AddWithValue("@exampleID", exampleId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                int i = 0;
                ratingPct = 0;
                while (reader.Read())
                {
                    i++;
                    ratingPct += Convert.ToInt32(reader["rating"].ToString());
                    if (reader["userId"].ToString() == user.uniqueId.ToString()) { Enabled = false; disabledPN.Attributes["title"] = "Tento příklad již byl Vámi dříve hodnocen"; }                    
                }
                if (i == 0) ratingPct = 50;
                else ratingPct /= i;
            }
        }

        protected void ratingLB_Click(object sender, EventArgs e)
        {
            int pomRat = Convert.ToInt32((sender as LinkButton).ID.Replace("LB", ""));
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "INSERT INTO [userRating] (exampleID, userId, userIp, rating, actionDateTime) VALUES (@exampleID, @userId, @userIp, @rating, @actionDateTime)";
                dboManager.command.Parameters.AddWithValue("@exampleID", exampleId);
                dboManager.command.Parameters.AddWithValue("@userId", user.uniqueId.ToString());
                dboManager.command.Parameters.AddWithValue("@userIp", Request.UserHostAddress);
                dboManager.command.Parameters.AddWithValue("@rating", pomRat);
                dboManager.command.Parameters.AddWithValue("@actionDateTime", DateTime.Now);
                dboManager.command.ExecuteNonQuery();
            }
            recomputeRating();
        }
    }
}