<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="gridViewPager.ascx.cs" Inherits="SbirkaPrikladuEU.Class.gridViewPager" %>
<asp:Repeater ID="repPager" OnItemCommand="repPager_ItemCommand" runat="server">
    <HeaderTemplate>
        <div class="btn-group">
        <asp:LinkButton ID="firstPageLB" CssClass="btn btn-mini" ToolTip="První strana" runat="server" OnClick="firstPageLB_Click"><i class="icon-step-backward"></i></asp:LinkButton>
    </HeaderTemplate>
    <ItemTemplate>                            
        <asp:LinkButton ID="lnkPage" CssClass="btn btn-mini gwPagerBtn" Text='<%# Container.DataItem %>' CommandName="ChangePage" CommandArgument="<%# Container.DataItem %>" runat="server" />
    </ItemTemplate>
    <FooterTemplate>
        <asp:LinkButton ID="lastPageLB" CssClass="btn btn-mini" ToolTip="Poslední strana" runat="server" OnClick="lastPageLB_Click"><i class="icon-step-forward"></i></asp:LinkButton>
        </div>
    </FooterTemplate>
</asp:Repeater>