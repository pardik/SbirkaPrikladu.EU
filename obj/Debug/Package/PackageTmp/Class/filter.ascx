<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="filter.ascx.cs" Inherits="SbirkaPrikladuEU.Class.filter" %>
<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <div class="well">
            <div class="fR toC">
                <p><strong>Zobrazovat příklady pro:</strong></p>
                <div class="btn-group" data-toggle="buttons-checkbox">                    
                    <asp:Button ID="ZS1BT" Text="1.stupeň ZŠ" CssClass="btn" runat="server" OnClick="st1ZS_Click" />
                    <asp:Button ID="ZS2BT" Text="2.stupeň ZŠ" CssClass="btn" runat="server" OnClick="st2ZS_Click" />
                    <asp:Button ID="stredoskolskyBT" Text="Středoškoláky" CssClass="btn" runat="server" OnClick="stredoskolsky_Click" />
                </div>
            </div>
            <br class="clear" />
        </div>
    </ContentTemplate>
</asp:UpdatePanel>