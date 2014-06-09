<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="updatedExamplesInCollectionsAlert.ascx.cs" Inherits="SbirkaPrikladuEU.Class.updatedExamplesInCollectionsAlert" %>
<div id="alertDIV" class="alert alert-danger" runat="server" visible="false">
    <asp:HiddenField ID="exampleIdHF" runat="server" />
    <asp:HiddenField ID="collectionIdHF" runat="server" />
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <asp:LinkButton ID="okBT" class="btn btn-mini fR" runat="server" OnClick="ok_Click" ToolTip="Příště upozornění na tento příklad nezobrazovat"><i class="icon icon-ok"></i>&nbsp;&nbsp;&nbsp;Zkontrolováno</asp:LinkButton>
    <h4>Pozor!</h4>
    Příklad byl, poté co byl vložen do Vaší sbírky, pozměněn autorem. Raději si zkontrolujte zda je vše v pořádku.
</div>