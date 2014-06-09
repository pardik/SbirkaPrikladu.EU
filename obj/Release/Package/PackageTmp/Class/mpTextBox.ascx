<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="mpTextBox.ascx.cs" Inherits="SbirkaPrikladuEU.Class.mpTextBox" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:HiddenField ID="dataKeyHF" runat="server" />
<asp:Panel ID="parentPanel" runat="server">
    <asp:TextBox runat="server" ID="TextBox1" ontextchanged="TextBox1_TextChanged" />
    <asp:RequiredFieldValidator ID="RequiredValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Tento údaj je nutno vyplnit." Display="None" Visible="false" />
    <asp:ValidatorCalloutExtender ID="RequiredValidator1Extender" TargetControlID="RequiredValidator1" runat="server" Enabled="false" />
    <asp:Panel ID="Panel1" runat="server" Visible="false" />
    <asp:AutoCompleteExtender ID="AutoCompleteExtender1" TargetControlID="TextBox1" runat="server" ServicePath="/Class/AutoComplete.asmx" EnableCaching="True" CompletionListElementID="Panel1" Enabled="false" />
    <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="TextBox1"  runat="server" Enabled="false" />
</asp:Panel>