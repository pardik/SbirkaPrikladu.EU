using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SbirkaPrikladuEU
{
    public class fileManager
    {
        public static string uploadFile(HttpPostedFile postedFile)
        {
            return uploadFile(postedFile, "/Files/UserUploadFiles/");
        }

        public static string uploadFile(HttpPostedFile postedFile, string directoryToUpload)
        {
            try
            {
                string localName = postedFile.FileName;
                string extension = postedFile.FileName.Remove(postedFile.FileName.LastIndexOf('.'));
                extension = postedFile.FileName.Replace(extension, "").ToLower();
                string name = Guid.NewGuid().ToString();
                postedFile.SaveAs(HttpContext.Current.Server.MapPath(directoryToUpload) + name + extension);

                using (dboManager dboManager = new dboManager())
                {
                    dboManager.command.CommandText = "INSERT INTO [uploadedFiles] (name, extension, path, userLocalFileName, ownerId, uploadDate) VALUES (@name, @extension, @path, @userLocalFileName, @ownerId, @uploadDate)";
                    dboManager.command.Parameters.AddWithValue("@name", name);
                    dboManager.command.Parameters.AddWithValue("@extension", extension);
                    dboManager.command.Parameters.AddWithValue("@path", directoryToUpload);
                    dboManager.command.Parameters.AddWithValue("@userLocalFileName", localName);
                    dboManager.command.Parameters.AddWithValue("@ownerId", user.uniqueId);
                    dboManager.command.Parameters.AddWithValue("@uploadDate", DateTime.Now);
                    dboManager.command.ExecuteNonQuery();
                }

                return directoryToUpload + name + extension;
            }
            catch { return null; }
        }
    }
}
