<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="photogalleryBrowser.aspx.cs" Inherits="SbirkaPrikladuEU.ckeditor.photogalleryBrowser" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/topMenu.ascx" TagName="topMenu" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <script src="/Scripts/jquery-1.7.2.js" type="text/javascript"></script>
    <script src="/Scripts/bootstrap.js" type="text/javascript"></script>
    <link rel="stylesheet/less" type="text/css" href="/App_Themes/Gray/Site.less.css" />
    <script src="/Scripts/less-1.3.0.min.js" type="text/javascript"></script>
    <title></title>
</head>
<body style="background-image: none;">
    <form id="form1" runat="server">        
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="true" />    
    <div class="container">
        <div class="row">
            <div class="span11 well">
                <h2>Nahrejte nový soubor, <small>nebo použijte některý již dříve nahraný</small></h2>
                <input id="fileInputTag" type="file" runat="server" />
                <asp:Button ID="uploadBT" CssClass="btn btn-primary" Text="Nahrát soubor" runat="server" OnClick="uploadFiles" />
                <div class="alert">
                  <span class="close" data-dismiss="alert">&times;</span>
                  <strong>Upozornění!</strong><br />Nahrávejte soubory pouze v potřebné velikosti.<br />Také rozměry obrázků před nahráním upravte tak, aby zbytečně nepřekračovaly potřebnou velikost. Děkujeme.
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <div class="row">            
            <div class="span12">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" />
                <asp:CheckBox ID="onlyMeUploadedCHB" Text="&nbsp;jen mnou nahrané soubory" Checked="true" CssClass="fR checkbox" Visible="false" AutoPostBack="true" runat="server" OnCheckedChanged="onlyMeUploadedCHB_Changed" />
                <asp:GridView ID="filesGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" AllowPaging="False" AllowSorting="True" PageSize="1000">
                    <Columns>
                        <asp:TemplateField HeaderText="Nahráno" SortExpression="uploadDate"><ItemTemplate><%# Convert.ToDateTime(Eval("uploadDate")).ToString("dd.MM.yyyy | HH:mm")%></ItemTemplate></asp:TemplateField>                                
                        <asp:TemplateField HeaderText="Název" SortExpression="userLocalFileName"><ItemTemplate><a href="#" class="usrLocName" <%# string.Format("imgPath='{0}{1}{2}'", Eval("path").ToString(),Eval("name").ToString(),Eval("extension").ToString()) %> <%# string.Format("onclick='setFileUrl(\"{0}{1}{2}\");'", Eval("path").ToString(),Eval("name").ToString(),Eval("extension").ToString()) %>><%# Eval("userLocalFileName") %></a></ItemTemplate></asp:TemplateField>
                        <asp:TemplateField HeaderText="Vlastník" SortExpression="ownerId"><ItemTemplate><%# SbirkaPrikladuEU.user.fullNameFromId(Eval("ownerId").ToString()) %></ItemTemplate></asp:TemplateField>
                    </Columns>
                    <PagerSettings Mode="Numeric" />
                    <PagerTemplate>
                        <uc:gridViewPager runat="server" />
                    </PagerTemplate>
                </asp:GridView>    
            </div>
        </div>                
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="filesGW" />
        </Triggers>
        </asp:UpdatePanel>
    </div>    
    </form>
    
    <script type="text/javascript">            
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
    </script>
</body>
</html>