<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="deleteExample.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Examples.deleteExample" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="span12">
                    <div class="hero-unit">
                        <h1>Pozor ! <small>Smazání příkladu: <%= SbirkaPrikladuEU.exampleManager.getExampleName(Convert.ToInt64(Request.QueryString["id"].ToString()))%></small></h1>
                        <p></p>                        
                        <div class="alert">
                            <button class="close" data-dismiss="alert">&times;</button>
                            <strong>Upřesnění!</strong><br />
                            Ve SbírcePříkladů.eu funguje mazání poněkud jinak než jej běžně znáte.<br />
                            Pokud příklad smažete vzdáváte se automaticky jeho autorství, nebude se tedy zobrazovat mezi Vašimi příklady, ani v jednotlivých skupinách.<br />
                            Uživatelům, kteří mají Váš příklad ve svých sbírkách se však tento příklad bude nadále zobrazovat. Vlastnictví příkladu přejde na SbírkuPříkladů.eu
                        </div>
                        <p class="form-inline"><asp:CheckBox ID="confirmCHB" Text="&nbsp;potvrdit smazání" AutoPostBack="true" runat="server" OnCheckedChanged="confirmCHB_CheckedChanged" /></p>
                        <p>
                            <asp:Button ID="deleteBT" ClientIDMode="Static" Text="Rozumím - Přesto smazat příklad" CssClass="btn btn-danger" Enabled="false" runat="server" OnClick="changeOwnerToRoot" />&nbsp;&nbsp;&nbsp;
                            <a href="javascript:history.back()" class="btn btn-primary">Zpět - Nemazat příklad</a>
                        </p>
                    </div>            
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>