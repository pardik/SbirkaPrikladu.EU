<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="exampleGroupsEdit.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.ContentManagement.exampleGroupsEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>        
            <div class="row">
                <div class="span12 page-header">            
                    <h1>Kategorie příkladů</h1>            
                </div>
            </div>

            <div class="row">        
                <div class="span6">            
                    <asp:TreeView ID="exampleGroupsTV" ShowLines="true" runat="server" OnSelectedNodeChanged="selectedNodeChanged"></asp:TreeView>            
                </div>
                <div class="span6">            
                    <asp:Panel runat="server" DefaultButton="insertNewGroupBT">            
                        <h3>Vložit novou kategorii</h3>
                        <asp:TextBox ID="newGroupNameTB" CssClass="input-xlarge" placeholder="Název nové kategorie" runat="server" /><br />
                        <asp:Button ID="insertNewGroupBT" Text="Vložit novou kategorii" CssClass="btn btn-primary" runat="server" OnClick="insertNewGroup" /><br /><br /><br />
                    </asp:Panel>            
                    <asp:Panel runat="server" DefaultButton="editGroupNameBT">
                        <h3>Změnit název kategorie</h3>
                        <asp:TextBox ID="editGroupNameTB" CssClass="input-xlarge" placeholder="Změňte název kategorie" runat="server" /><br />
                        <asp:Button ID="editGroupNameBT" Text="Editovat název kategorie" CssClass="btn btn-primary" runat="server" OnClick="renameGroup" />
                    </asp:Panel>            
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
