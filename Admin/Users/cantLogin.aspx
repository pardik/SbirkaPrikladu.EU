<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="cantLogin.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.cantLogin" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>    
            <asp:Panel ID="PN01" runat="server" DefaultButton="sendPassBT">
                <div class="well">
                    <h1>Zapomněli jste své heslo? <small>Nic se neděje, my Vám ho pošleme.</small></h1>            
                </div>        
                <div class="well">                    
                    <asp:Panel ID="emailNotExistPN" class="well alert-error" runat="server" Visible="false">
                        <button class="close" data-dismiss="alert">&times;</button>
                        <strong>Něco je špatně!</strong><br />Uživatel s takovýmto e-mailem neexistuje.<br />Pokud jste si jisti, že zadáváte e-mail správně, kontaktujte <a href="mailto:podpora@sbirkaprikladu.eu">SbírkuPříkladů</a>, prosím.
                    </asp:Panel>            
                    <uc:mpTextBox ID="emailTB" runat="server" CssClass="input-large" waterMarkText="Zadejte e-mail" requiredValidatorErrorMessage="Zadejte e-mail" />            
                    <asp:Button ID="sendPassBT" runat="server" Text="Pošlete mi heslo" CssClass="btn btn-primary span2" OnClick="sendPassword"/>            
                </div>                
            </asp:Panel>
            <asp:Panel ID="successPN" CssClass="well" runat="server" Visible="false">
                <h1>Poslali jsme Vám e-mail</h1><br />
                <p>Jak to funguje?</p>
                <p>Z důvodu bezpečnosti neposíláme hesla přímo. V e-mailu naleznete odkaz, na který když kliknete, dojde k resetování hesla.</p>                    
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>