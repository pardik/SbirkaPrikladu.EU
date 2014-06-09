<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SbirkaPrikladuEU.Default" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<%@ Register Src="~/Class/examplesFromGroupId.ascx" TagName="examplesFromgroupId" TagPrefix="uc" %>
<%@ Register Src="~/Class/lastInsertedExamples.ascx" TagName="lastInsertedExamples" TagPrefix="uc" %>
<%@ Register Src="~/Class/filter.ascx" TagName="filter" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" PostBackUrlEnabled="false" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
<asp:UpdatePanel runat="server">
    <ContentTemplate>
    <div id="pf2013Tag" class="row pf2013" runat="server">
        <img class="span9" src="App_Themes/Gray/imgs/pf2013.jpg" alt="PF 2013" />        
    </div>

    <div id="topHeroUnitTag" class="row" runat="server">
        <div class="span9">
            <div class="hero-unit">
                <h1>Vítejte <small>ve sbírce příkladů z matematiky</small></h1>
                <br /><br />
                <p>SbírkaPříkladů.eu je projekt otevřený všem příznivcům matematiky.<br />Veškeré matematické příklady zde jsou Vám volně k dispozici.</p>
                <br />
                <p>Chcete vlastní uživatelský účet?<br /><a href="/Admin/Users/registerUser.aspx" class="btn btn-primary">Registrujte se zdarma</a></p>
            </div>
        </div>
    </div>
        
    <uc:filter ID="exampleFilterUC" runat="server" />

    <uc:examplesFromgroupId ID="examplesFromGroupIdUC" runat="server" />

    <uc:lastInsertedExamples ID="lastInsertedExamplesUC" runat="server" />
    
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>