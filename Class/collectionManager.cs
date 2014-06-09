using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SbirkaPrikladuEU.Class;

namespace SbirkaPrikladuEU
{
    public class collectionManager
    {
        public static void createCollection(string name, bool isPublic, string labels, bool hideHeaders, bool hideSolutions, bool hideResults)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "INSERT INTO [collections] (name, ownerId, createdDate, lastUpdate, isPublic, labels, hideExamplesHeaders, hideExamplesSolutions, hideExamplesResults) VALUES (@name, @ownerId, @createdDate, @lastUpdate, @isPublic, @labels, @hExHeaders, @hExSolutions, @hExResults)";
                dboManager.command.Parameters.AddWithValue("@name", name.Trim());
                dboManager.command.Parameters.AddWithValue("@ownerId", user.uniqueId.ToString());
                dboManager.command.Parameters.AddWithValue("@createdDate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@isPublic", isPublic);
                dboManager.command.Parameters.AddWithValue("@labels", labels.RemoveDiacritics().ToLower());
                dboManager.command.Parameters.AddWithValue("@hExHeaders", hideHeaders);
                dboManager.command.Parameters.AddWithValue("@hExSolutions", hideSolutions);
                dboManager.command.Parameters.AddWithValue("@hExResults", hideResults);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static void setIsPublic(Int64 collectionId, bool isPublic)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [collections] SET [isPublic] = @isPublic, [lastUpdate] = @lastUpdate WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                dboManager.command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@isPublic", isPublic);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static void hideExamplesHeaders(Int64 collectionId, bool hidden)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [collections] SET [hideExamplesHeaders] = @hidden, [lastUpdate] = @lastUpdate WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                dboManager.command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@hidden", hidden);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static void hideExamplesSolutions(Int64 collectionId, bool hidden)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [collections] SET [hideExamplesSolutions] = @hidden, [lastUpdate] = @lastUpdate WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                dboManager.command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@hidden", hidden);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static void hideExamplesResults(Int64 collectionId, bool hidden)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [collections] SET [hideExamplesResults] = @hidden, [lastUpdate] = @lastUpdate WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                dboManager.command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                dboManager.command.Parameters.AddWithValue("@hidden", hidden);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static string getCollectionName(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [name] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                return pom;
            }
        }

        public static string getLabels(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [labels] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                return pom;
            }
        }

        public static bool getHideExaplesHeaders(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [hideExamplesHeaders] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                var pom = Convert.ToBoolean(dboManager.command.ExecuteScalar().ToString());
                return pom;
            }
        }

        public static bool getHideExaplesSolutions(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [hideExamplesSolutions] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                var pom = Convert.ToBoolean(dboManager.command.ExecuteScalar().ToString());
                return pom;
            }
        }

        public static bool getHideExaplesResults(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [hideExamplesResults] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                var pom = Convert.ToBoolean(dboManager.command.ExecuteScalar().ToString());
                return pom;
            }
        }

        public static Guid getCollectionOwnerId(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [ownerId] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                string pom = dboManager.command.ExecuteScalar().ToString();
                return new Guid(pom);
            }
        }

        public static String getCollectionOwnerName(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [ownerId] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                string pomId = dboManager.command.ExecuteScalar().ToString();
                return user.fullNameFromId(pomId);
            }
        }

        public static bool isCollectionPublic(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [isPublic] FROM [collections] WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                string pomPublic = dboManager.command.ExecuteScalar().ToString();
                return Convert.ToBoolean(pomPublic);
            }
        }

        public static void recomputePositions(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examplesInCollections] WHERE [collectionId] = @colId ORDER BY [position]";
                dboManager.command.Parameters.AddWithValue("@colId", collectionId);                
                SqlDataReader reader = dboManager.command.ExecuteReader();
                int i = 0;
                while (reader.Read())
                {
                    i++;
                    dboManager.command2.CommandText = "UPDATE [examplesInCollections] SET [position] = " + i + " WHERE [id] = " + reader["id"].ToString();
                    dboManager.command2.ExecuteNonQuery();
                }                
            }
        }

        public static string insertExampleToCollection(Int64 exampleId, Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT * FROM [examplesInCollections] WHERE [exampleId] = @exId AND [collectionId] = @colId";
                dboManager.command.Parameters.AddWithValue("@colId", collectionId);
                dboManager.command.Parameters.AddWithValue("@exId", exampleId);
                dboManager.command.Parameters.AddWithValue("@pos", Int64.MaxValue);
                dboManager.command.Parameters.AddWithValue("@date", DateTime.Now);
                SqlDataReader reader = dboManager.command.ExecuteReader();
                if (reader.Read()) return "noMultiple" ;
                reader.Dispose();
                dboManager.command.CommandText = "INSERT INTO [examplesInCollections] (exampleId, collectionId, position, compareDate) VALUES (@exId, @colId, @pos, @date)";
                dboManager.command.ExecuteNonQuery();
            }
            recomputePositions(collectionId);
            return "OK";
        }

        public static Int64 getExamplePosition(Int64 exampleId, Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT [position] FROM [examplesInCollections] WHERE [exampleId] = @exId AND [collectionId] = @colId";
                dboManager.command.Parameters.AddWithValue("@colId", collectionId);
                dboManager.command.Parameters.AddWithValue("@exId", exampleId);
                return Convert.ToInt64(dboManager.command.ExecuteScalar().ToString());
            }            
        }

        public static Int64 getInHowManyCollectionsIsExampleIncluded(Int64 exampleId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT COUNT(id) AS inCollectionsCount FROM [examplesInCollections] WHERE [exampleId] = @exId";
                dboManager.command.Parameters.AddWithValue("@exId", exampleId);
                return Convert.ToInt64(dboManager.command.ExecuteScalar().ToString());
            }
        }

        public static void renameCollection(Int64 collectionId, string newCollectionName)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [collections] SET [name] = @newName WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@newName", newCollectionName);
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static void changeLabels(Int64 collectionId, string labels)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "UPDATE [collections] SET [labels] = @labels WHERE [id] = @id";
                dboManager.command.Parameters.AddWithValue("@labels", labels.RemoveDiacritics());
                dboManager.command.Parameters.AddWithValue("@id", collectionId);
                dboManager.command.ExecuteNonQuery();
            }
        }

        public static void changeExamplePosition(Int64 collectionId, Int64 exampleId, double newPosition)
        {            
            using (dboManager dboManager = new dboManager())
            {
                double oldPosition = Convert.ToDouble(dboManager.getScalar("examplesInCollections", "position", "exampleId = " + exampleId + " AND collectionId = " + collectionId));
                if (oldPosition == newPosition) return;
                if (oldPosition > newPosition) newPosition -= .5;
                if (oldPosition < newPosition) newPosition += .5;
                dboManager.command.CommandText = "UPDATE [examplesInCollections] SET [position] = @newPosition WHERE [collectionId] = @collectionId AND [exampleId] = @exampleId";
                dboManager.command.Parameters.AddWithValue("@newPosition", newPosition);
                dboManager.command.Parameters.AddWithValue("@collectionId", collectionId);
                dboManager.command.Parameters.AddWithValue("@exampleId", exampleId);
                dboManager.command.ExecuteNonQuery();
                recomputePositions(collectionId);
            }
        }

        public static void deleteExampleFromCollection(Int64 collectionId, Int64 exampleId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "DELETE [examplesInCollections] WHERE [collectionId] = @collectionId AND [exampleId] = @exampleId";
                dboManager.command.Parameters.AddWithValue("@collectionId", collectionId);
                dboManager.command.Parameters.AddWithValue("@exampleId", exampleId);
                dboManager.command.ExecuteNonQuery();
                recomputePositions(collectionId);
            }
        }

        public static int getChangedExamplesNrInCollection(Int64 collectionId)
        {
            using (dboManager dboManager = new dboManager())
            {
                dboManager.command.CommandText = "SELECT COUNT(examplesInCollections.exampleId) AS nr FROM examplesInCollections INNER JOIN examples ON examplesInCollections.exampleId = examples.id AND examplesInCollections.compareDate < examples.lastUpdate WHERE (examplesInCollections.collectionId = @cId)";
                dboManager.command.Parameters.AddWithValue("@cId", collectionId);
                return Convert.ToInt32(dboManager.command.ExecuteScalar().ToString());
            }
        }
    }
}