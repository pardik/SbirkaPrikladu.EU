<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="aritmeticka-posloupnost01.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Posloupnosti.aritmeticka_posloupnost01" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" tabTosHowNr="1" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
    <div class="row">        
        <div class="span9">
            <div class="pgH well geogebraAppletContainer">
                <div class="page-header">
                  <h1>Aritmetická posloupnost 1 <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <iframe scrolling="no" src="https://www.geogebratube.org/material/iframe/id/100346/width/widthToReplace/height/500/border/888888/rc/false/ai/false/sdz/true/smb/false/stb/false/stbh/true/ld/false/sri/true/at/preferhtml5" width="830px" height="500px" style="border:0px;"></iframe>
                <script>
                    var iframeTag = $('.geogebraAppletContainer').find('iframe');
                    var src = $(iframeTag).attr('src');
                    src = src.replace('widthToReplace', $('.geogebraAppletContainer').width());
                    $(iframeTag).attr('src', src);
                    $(iframeTag).attr('width', $('.geogebraAppletContainer').width() + "px");
                </script>
            </div>
        </div>
    </div>
    <script>
        $('.geogebraApplet').width($('.geogebraAppletContainer').width() - 1);
    </script>
</asp:Content>