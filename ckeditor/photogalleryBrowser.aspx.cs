using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SbirkaPrikladuEU.ckeditor
{
    public partial class photogalleryBrowser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Roles.GetRolesForUser()[0] == "Administrator") onlyMeUploadedCHB.Visible = true;
            onlyMeUploadedCHB_Changed(null, null);
            System.Text.StringBuilder sb = new System.Text.StringBuilder();            
            sb.Append("$('.usrLocName').popover({ html: true, placement: \"right\", offset: 5, delay: { show: 300, hide: 100 }, ");
            sb.Append("template: '<div class=\"popover\"><div class=\"popover-inner\"><div class=\"popover-content\"><div></div></div></div></div>', ");
            sb.Append("title: \"\", ");
            sb.Append("content: function () {");
            sb.Append("if ($(this).attr('imgPath').toLowerCase().search('.jpg') >= 0) { return '<img class=\"ckeBrowserImgPopover\" src=\"' + $(this).attr('imgPath') + '\">';}");
            sb.Append("if ($(this).attr('imgPath').toLowerCase().search('.png') >= 0) { return '<img class=\"ckeBrowserImgPopover\" src=\"' + $(this).attr('imgPath') + '\">';}");
            sb.Append("if ($(this).attr('imgPath').toLowerCase().search('.gif') >= 0) { return '<img class=\"ckeBrowserImgPopover\" src=\"' + $(this).attr('imgPath') + '\">';}");
            sb.Append("if ($(this).attr('imgPath').toLowerCase().search('.bmp') >= 0) { return '<img class=\"ckeBrowserImgPopover\" src=\"' + $(this).attr('imgPath') + '\">';}");
            sb.Append("return 'Náhled nelze zobrazit';  }");
            sb.Append("});");

            sb.Append("$('.usrLocName').mouseenter(function(){ $(this).popover('show'); });");
            sb.Append("$('.usrLocName').mouseleave(function(){ $(this).popover('hide'); });");
            
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.GetType(), "imagesPopoverJS", sb.ToString(), true);
        }

        protected void onlyMeUploadedCHB_Changed(object sender, EventArgs e)
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [uploadedFiles] ORDER BY [uploadDate] DESC";
            if (onlyMeUploadedCHB.Checked)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [uploadedFiles] WHERE [ownerId] = @ownerId ORDER BY [uploadDate] DESC";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("ownerId", user.uniqueId.ToString());
            }            
            filesGW.DataBind();
        }

        protected void uploadFiles(object sender, EventArgs e)
        {
            string pathToFile = "";
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile postedFile = Request.Files[i];
                if (postedFile.ContentLength <= 0)
                {
                    //messageBox.show("Nejprve vyberte soubory. Poté klikněte na tlačítko Nahrát na server.");
                    return;
                }
                pathToFile = fileManager.uploadFile(postedFile);
            }
            
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script language='javascript'>            
            function getUrlParam(paramName) {
                var reParam = new RegExp('(?:[\?&]|&amp;)' + paramName + '=([^&]+)', 'i');
                var match = window.location.search.match(reParam);
                return (match && match.length > 1) ? match[1] : '';
            }            
            function setFileUrl(fileUrl) {
                var funcNum = getUrlParam('CKEditorFuncNum');
                window.opener.CKEDITOR.tools.callFunction(funcNum, fileUrl);
                window.close();
            }
            ");
            sb.Append(@"setFileUrl('" + pathToFile + "');");
            sb.Append(@"</script>");
                        
            if (!ClientScript.IsStartupScriptRegistered("bindFilePath"))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "bindFilePath", sb.ToString());
            }
        }
    }
}