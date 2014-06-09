<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="reportExampleBT.ascx.cs" Inherits="SbirkaPrikladuEU.Class.reportExampleBT" %>
<a id="reportExampleABT" class="btn btn-danger" data-toggle="modal" href="#reportExampleModalPN" runat="server"><i class="icon-fire icon-white"></i>&nbsp;Nahlásit</a>

<asp:Panel ID="reportExampleModalPN" ClientIDMode="Static" class="modal hide fade" runat="server">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h3>Nahlásit příklad</h3>
    </div>
    <div class="modal-body">
        <asp:TextBox ID="reportExampleTextTB" TextMode="MultiLine" Width="98%" Rows="10" runat="server" />
    </div>
    <div class="modal-footer">
        <a href="#" class="btn" data-dismiss="modal">Zrušit</a>
        <asp:LinkButton ID="submitBT" CssClass="btn btn-danger" OnClientClick="$(this).button('loading');" data-loading-text="<i class='icon-fire icon-white'></i>&nbsp;Čekejte...&nbsp;" OnClick="submitBT_Click" runat="server"><i class="icon-fire icon-white"></i>&nbsp;Nahlásit příklad</asp:LinkButton>
    </div>
</asp:Panel>
