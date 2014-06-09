<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="deleteCollection.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Collections.deleteCollection" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="span12">
                    <div class="hero-unit">
                        <h1>Pozor ! <small>Smazání sbírky: <%= SbirkaPrikladuEU.collectionManager.getCollectionName(Convert.ToInt64(Request.QueryString["id"].ToString()))%></small></h1>
                        <p></p>                        
                        <div class="alert">
                            <button class="close" data-dismiss="alert">&times;</button>                            
                            <strong>Upřesnění!</strong><br />
                            Nebojte se, pokud smažete sbírku, příklady v ní zahrnuté se nesmažou.<br />Tento krok, ale nelze vrátit a sbírku budete muset eventuálně znovu vytvořit.
                        </div>
                        <p class="form-inline"><asp:CheckBox ID="confirmCHB" Text="&nbsp;potvrdit smazání" AutoPostBack="true" runat="server" OnCheckedChanged="confirmCHB_CheckedChanged" /></p>
                        <p>
                            <asp:Button ID="deleteBT" ClientIDMode="Static" Text="Rozumím - Přesto smazat sbírku" CssClass="btn btn-danger" Enabled="false" runat="server" OnClick="deleteCollectionFromDTB" />&nbsp;&nbsp;&nbsp;
                            <a href="javascript:history.back()" class="btn btn-primary">Zpět - Nemazat sbírku</a>
                        </p>
                    </div>            
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>