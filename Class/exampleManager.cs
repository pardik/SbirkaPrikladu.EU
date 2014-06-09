using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace SbirkaPrikladuEU
{
    public class exampleManager
    {
        public static string getExampleName(Int64 exampleId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [name] FROM [examples] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                return pom;
            }            
        }

        public static Guid getExampleOwnerId(Int64 exampleId)
        {         
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [ownerId] FROM [examples] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                return new Guid(pom);
            }            
        }

        public static List<Int64> getExampleGroupIds(Int64 exampleId)
        {
            List<Int64> groupIds = new List<Int64>();
            using (dboManager dboManager = new dboManager())
            {                
                dboManager.command.CommandText = "SELECT [groupIds] FROM [examples] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                string[] pomArr = pom.Split('-');
                foreach (string pom2 in pomArr)
                {
                    try { groupIds.Add(Convert.ToInt64(pom2)); }
                    catch { }
                }
            }
            return groupIds;
        }

        public static DateTime getExampleLastUpdate(Int64 exampleId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [lastUpdate] FROM [examples] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                return Convert.ToDateTime(pom);
            }
        }

        public static void insertExampleGroup(string name, Int64 parentId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "INSERT INTO [exampleGroups] (name, parentId, position) VALUES (@name, @parentId, " + Int64.MaxValue + ")";
                dboManager.command.Parameters.AddWithValue("@name", name);
                dboManager.command.Parameters.AddWithValue("@parentId", parentId);
                dboManager.command.ExecuteNonQuery();
            }
            recomputeGroupPositions(parentId);
        }

        public static void renameGroup(Int64 groupId, string newName)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [exampleGroups] SET [name] = @name WHERE [id] = @groupId";
                dboManager.command.Parameters.AddWithValue("@name", newName);
                dboManager.command.Parameters.AddWithValue("@groupId", groupId);
                dboManager.command.ExecuteNonQuery();
            }            
        }

        public static void recomputeGroupPositions(Int64 parentId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [exampleGroups] WHERE [parentId] = @parentId ORDER BY [position]";                
                dboManager.command.Parameters.AddWithValue("@parentId", parentId);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                int i = 0;
                while (reader.Read())
                {
                    dboManager.command2.CommandText = "UPDATE [exampleGroups] SET [position] = " + i + " WHERE [id] = " + reader["id"].ToString();
                    dboManager.command2.ExecuteNonQuery();
                    i++;
                }
            }
        }

        public static List<string> groupNames(string groupIds)
        {
            string[] pomStr = groupIds.Split('-');
            List<string> names = new List<string>();

            using (dboManager dboManager = new dboManager())
            {                
                dboManager.command.CommandText = "SELECT * FROM [exampleGroups] WHERE ";
                int i = 0;
                foreach (string str in pomStr)
                {
                    if (string.IsNullOrEmpty(str)) continue;
                    if (i > 0) dboManager.command.CommandText += " OR ";
                    dboManager.command.CommandText += "[id] = " + str;
                    i = 1;
                }
                SqlDataReader reader = dboManager.command.ExecuteReader();
                while (reader.Read()) names.Add(reader["name"].ToString());
                return names;
            }            
        }

        public static string schoolGradeToText(string schoolGradeIds)
        {
            string retText = "";
            if (schoolGradeIds.Contains("-1-"))
            {
                if (!string.IsNullOrEmpty(retText)) retText += ",<br />";
                retText += "1.stupeň ZŠ";
            }
            if (schoolGradeIds.Contains("-2-"))
            {
                if (!string.IsNullOrEmpty(retText)) retText += ",<br />";
                retText += "2.stupeň ZŠ";
            }
            if (schoolGradeIds.Contains("-3-"))
            {
                if (!string.IsNullOrEmpty(retText)) retText += ",<br />";
                retText += "Středoškolský";
            }
            return retText;
        }

        public static string authorFullName(Int64 exampleId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examples] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);                
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if(!reader.Read()) return null;
                return user.fullNameFromId(reader["ownerId"].ToString());                
            } 
        }

        public static void addNewExample(string exampleName, string enter, string solution, string result, string groupIds, string schoolGradeIds, Int32 difficultyValue, string labels)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "INSERT INTO [examples] (name, enter, solution, result, groupIds, schoolGrade, difficulty, labels, ownerId, insertingDate, lastUpdate) VALUES (@name, @enter, @solution, @result, @groupIds, @schoolGrade, @difficulty, @labels, @ownerId, @insertingDate, @insertingDate)";
                dboManager.command.Parameters.AddWithValue("@name", exampleName);
                dboManager.command.Parameters.AddWithValue("@enter", enter);
                dboManager.command.Parameters.AddWithValue("@solution", solution);
                dboManager.command.Parameters.AddWithValue("@result", result);
                dboManager.command.Parameters.AddWithValue("@groupIds", groupIds);
                dboManager.command.Parameters.AddWithValue("@schoolGrade", schoolGradeIds);
                if (schoolGradeIds.Split('-').Count() > 3) dboManager.command.Parameters.AddWithValue("@difficulty", -1);
                else dboManager.command.Parameters.AddWithValue("@difficulty", difficultyValue);                
                dboManager.command.Parameters.AddWithValue("@labels", labels);
                dboManager.command.Parameters.AddWithValue("@ownerId", user.uniqueId.ToString());
                dboManager.command.Parameters.AddWithValue("@insertingDate", DateTime.Now);
                dboManager.command.ExecuteNonQuery();
            }            
        }

        public static void updateExample(Int64 exampleId, string exampleName, string enter, string solution, string result, string groupIds, string schoolGradeIds, Int32 difficultyValue, string labels)
        {
            using (dboManager dboManager = new dboManager())
            {
                solution = solution.Trim();
                if (string.IsNullOrEmpty(solution.Replace(" ", "").Replace("<br>", "").Replace("<br/>", "").Replace("&nbsp;", "").Replace("<p>", "").Replace("</p>", "").Replace("\n",""))) solution = string.Empty;    //test as solution is empty
                dboManager.command.CommandText = "UPDATE [examples] SET [name] = @name, [enter] = @enter, [solution] = @solution, [result] = @result, [groupIds] = @groupIds, [schoolGrade] = @schoolGrade, [difficulty] = @difficulty, [labels] = @labels, [lastUpdate] = @lastupdate WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", exampleId);
                dboManager.command.Parameters.AddWithValue("@name", exampleName);
                dboManager.command.Parameters.AddWithValue("@enter", enter);
                dboManager.command.Parameters.AddWithValue("@solution", solution);
                dboManager.command.Parameters.AddWithValue("@result", result);
                dboManager.command.Parameters.AddWithValue("@groupIds", groupIds);
                dboManager.command.Parameters.AddWithValue("@schoolGrade", schoolGradeIds);
                if (schoolGradeIds.Split('-').Count() > 3) dboManager.command.Parameters.AddWithValue("@difficulty", -1);
                else dboManager.command.Parameters.AddWithValue("@difficulty", difficultyValue);
                dboManager.command.Parameters.AddWithValue("@labels", labels);
                //dboManager.command.Parameters.AddWithValue("@ownerId", user.uniqueId.ToString());
                dboManager.command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                dboManager.command.ExecuteNonQuery();
            }
        }

    }    
}