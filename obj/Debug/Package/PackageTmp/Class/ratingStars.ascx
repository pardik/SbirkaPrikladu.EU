<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ratingStars.ascx.cs" Inherits="SbirkaPrikladuEU.Class.ratingStars" %>
<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <asp:HiddenField ID="exampleIdFH" Value="0" runat="server" />    
        <span id="disabledPN" visible="false" runat="server" class="ratingStars fL dropdown-toggle"><span class="cover"></span><span class="filled" style='width:<%= ratingPct %>%'></span></span>
        <div id="enabledPN" runat="server" class="btn-group pointer fL">
            <div class="dropdown-toggle" data-toggle="dropdown" href="#">
                <span class="ratingStars fL dropdown-toggle"><span class="cover"></span><span class="filled" style='width:<%= ratingPct %>%'></span></span>
            </div>
            <ul class="dropdown-menu">
                <li><asp:LinkButton ID="LB100" Text="Skvělý" runat="server" OnClick="ratingLB_Click" /></li>
                <li><asp:LinkButton ID="LB75" Text="Líbí se mi" runat="server" OnClick="ratingLB_Click" /></li>
                <li><asp:LinkButton ID="LB50" Text="Dobrý" runat="server" OnClick="ratingLB_Click" /></li>
                <li><asp:LinkButton ID="LB25" Text="Nic moc" runat="server" OnClick="ratingLB_Click" /></li>
                <li><asp:LinkButton ID="LB0" Text="Špatný" runat="server" OnClick="ratingLB_Click" /></li>
            </ul>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>