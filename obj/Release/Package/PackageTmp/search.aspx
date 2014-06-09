<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="SbirkaPrikladuEU.search" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
    <div class="well">
        <h2>Výsledky vyhledávání</h2>
        <asp:Panel ID="categoriesPN" runat="server">
            <h3>Názvy skupin obsahující '<%= searchPattern %>'</h3>
            <div id="categoriesPNDiv" runat="server"></div>
            <hr />
        </asp:Panel>
        
        <asp:Panel ID="examplesPN" runat="server">
            <h3>Názvy příkladů obsahující '<%= searchPattern %>'</h3>
            <div id="examplesPNDiv" runat="server"></div>
            <hr />
        </asp:Panel>
        
        <asp:Panel ID="fulltextPN" runat="server">
            <h3>Příklady ve kterých bylo nalezeno ve fulltextu '<%= searchPattern %>'</h3>
            <div id="fulltextPNDiv" runat="server"></div>
        </asp:Panel>       

        <asp:Panel ID="googlePN" runat="server">
            <hr />
            <h3>Můžete také zkusit vyhledávat přes Google</h3>
            <div id="googlePNDiv" runat="server">
            <!-- Put the following javascript before the closing </head> tag. -->
            <script>
                (function () {
                    var cx = '012793925062370889834:wy-vuatx8ak';
                    var gcse = document.createElement('script'); gcse.type = 'text/javascript'; gcse.async = true;
                    gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//www.google.com/cse/cse.js?cx=' + cx;
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(gcse, s);                    
                })();                
            </script>
            <!-- Place this tag where you want both of the search box and the search results to render -->
            <gcse:search></gcse:search>            
            </div>
        </asp:Panel>
    </div>
</asp:Content>