<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="deleteUser.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.deleteUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="span12">
                    <div class="hero-unit">                        
                        <h1>Pozor ! <small>Smazání uživatelského účtu: <%= SbirkaPrikladuEU.user.fullNameFromId(Request.QueryString["userId"].ToString())%></small></h1>                        
                        <p></p>
                        <asp:Panel ID="PN01" runat="server">
                            <div class="alert">
                                <button class="close" data-dismiss="alert">&times;</button>
                                <strong>Upřesnění!</strong><br /> 
                                Uživatelský účet bude trvale vymazán. Vymazány budou také všechny jeho sbírky.<br />
                                Pokud smažete uživatelský účet stane se autorem všech jeho příkladů SbírkaPříkladů.eu.<br />
                                Toto je nevratný krok.
                            </div>
                            <p class="form-inline"><asp:CheckBox ID="confirmCHB" Text="&nbsp;potvrdit smazání" AutoPostBack="true" runat="server" OnCheckedChanged="confirmCHB_CheckedChanged" /></p>
                        </asp:Panel>
                        <asp:Panel ID="PN02" runat="server" Visible="false">
                            <div class="alert">
                                <button class="close" data-dismiss="alert">&times;</button>
                                <strong>Upřesnění!</strong><br /> 
                                Pokoušíte se smazat svůj vlastní uživatelský účet.<br />
                                Je nám líto, ale z důvodu bezpečnosti systému toto není možné.<br />
                                Pokud přesto trváte na smazání svého uživatelského účtu, požádejte o to některého ze správců systému.
                            </div>
                        </asp:Panel>
                        <p>
                            <asp:Button ID="deleteBT" ClientIDMode="Static" Text="Rozumím - Přesto smazat účet" CssClass="btn btn-danger" Enabled="false" runat="server" OnClick="deleteAccount" />&nbsp;&nbsp;&nbsp;
                            <a href="javascript:history.back()" class="btn btn-primary">Zpět - Nemazat účet</a>
                        </p>
                    </div>            
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>