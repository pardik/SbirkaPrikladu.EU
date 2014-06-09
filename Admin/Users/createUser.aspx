<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="createUser.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.createUser" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Panel ID="contentPN" runat="server">
                <div class="row"><div class="span12"><div class="well">
                    <asp:Button Text="Vytvořit nový uživatelský účet" CssClass="btn btn-success btn-large fR" runat="server" OnClick="createUserBT_Click" />
                    <h1 runat="server">Nový uživatelský účet</h1>
                </div></div></div>
            
                <div class="row">
                    <div class="span6">
                        <div class="well form-horizontal">
                            <br />
                            <div class="control-group">
                                <label class="control-label">Jméno:</label>
                                <div class="controls">
                                    <uc:mpTextBox ID="nameTB" runat="server" requiredValidatorErrorMessage="Zadejte jméno, prosím." />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Příjmení:</label>
                                <div class="controls">
                                    <uc:mpTextBox ID="surnameTB" runat="server" requiredValidatorErrorMessage="Zadejte příjmení, prosím." />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">E-mail:</label>
                                <div class="controls">
                                    <asp:TextBox ID="emailTB" runat="server" />
                                    <asp:RequiredFieldValidator ID="requiredEmailValid" ControlToValidate="emailTB" runat="server" ErrorMessage="Zadejte e-mail, prosím." Display="None" />
                                    <asp:ValidatorCalloutExtender ID="valExt01" TargetControlID="requiredEmailValid" runat="server" />
                                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="emailTB" ErrorMessage="Formát e-mailové adresy je chybný" Display="None"></asp:RegularExpressionValidator>
                                    <asp:ValidatorCalloutExtender ID="valExt02" TargetControlID="regexEmailValid" runat="server" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Heslo:</label>
                                <div class="controls">
                                    <asp:TextBox ID="passTB" TextMode="Password" runat="server" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Heslo znovu:</label>
                                <div class="controls">
                                    <asp:TextBox ID="pass2TB" TextMode="Password" runat="server" />
                                </div>
                            </div>
                            <br />
                            <div class="control-group">
                                <label class="control-label">Oprávnění:</label>
                                <asp:RadioButtonList ID="rolesRBL" RepeatDirection="Horizontal" CssClass="rolesRBL" runat="server"></asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="well">
                            <div class="alert alert-info">
                                <strong>Upřesnění!</strong><br />
                                Všechny údaje jsou povinné. E-mail bude použit také jako uživatelské jméno.
                                Minimální délka hesla je <%= Membership.MinRequiredPasswordLength %> znaků.
                            </div>
                            <div id="errorDivTag" class="alert alert-error" runat="server" visible="false"></div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="successPN" Visible="false" runat="server">
                <div class="row">
                    <div class="span12">
                        <div class="pgH hero-unit">
                            <h1>Výborně</h1>
                            <p>&nbsp;</p>
                            <p>Byl vytvořen nový uživatleský účet.</p>
                            <p>Účet je aktivní a nevyžaduje ověření e-mailové adresy.</p>
                            <p>&nbsp;</p>
                            <a href="/Admin/Users/userAccountList.aspx" class="btn btn-primary span1">OK</a>
                            <a href="/Admin/Users/createUser.aspx" class="btn btn-primary span2">Vytvořit další účet</a>
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>