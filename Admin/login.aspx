<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.login" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">    
    <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false">
        <LayoutTemplate>
            <asp:Panel runat="server" DefaultButton="LoginButton">
                <div class="well">
                    <h1>Log In</h1>
                    <p>Přihlaste se svým uživatelským e-mailem a heslem, prosím...</p>
                </div>
                <div class="well form-inline">
                    <asp:TextBox ID="UserName" runat="server" CssClass="input-large" placeholder="E-mail" />
                    <asp:TextBox ID="Password" runat="server" CssClass="input-large" placeholder="Heslo" TextMode="Password" />
                    <br /><br />
                    <label class="checkbox"><asp:CheckBox ID="rememberCHB" runat="server"/>Neodhlašovat</label>
                    <br /><br />
                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Přihlásit" CssClass="btn btn-primary span2"/>                
                    <asp:Button runat="server" Text="Vytvořit účet" CssClass="btn span2" PostBackUrl="/Admin/Users/registerUser.aspx" />
                    <br /><br />
                    <a href="/Admin/Users/cantLogin.aspx">Nemůžete se přihlásit na svůj účet?</a>
                </div>
            </asp:Panel>
        </LayoutTemplate>
    </asp:Login>
</asp:Content>
