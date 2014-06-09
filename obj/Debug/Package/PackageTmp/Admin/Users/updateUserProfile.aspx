<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="updateUserProfile.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.updateUserProfile" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Panel ID="contentPN" runat="server">
                <div class="row"><div class="span12"><div class="well">
                    <div class="fR">
                        <a href="javascript:history.back()" class="btn btn-primary btn-large">Zpět</a>&nbsp;&nbsp;&nbsp;
                        <asp:Button Text="Uložit změny" CssClass="btn btn-success btn-large" runat="server" OnClick="updateUserBT_Click" />
                    </div>
                    <h1 runat="server">Nastavte si uživatelský profil</h1>
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
                            <br />
                            <div class="toC"><a href="javascript:void(0)" data-toggle="collapse" data-target="#changePassDiv">Změnit heslo</a><br /><br /></div>
                            <div id="changePassDiv" class="collapse">
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>