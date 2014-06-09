<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="registerUser.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.registerUser" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Panel ID="contentPN" runat="server">
                <div class="row"><div class="span12"><div class="well">
                    <asp:Button Text="Odeslat žádost" CssClass="btn btn-success btn-large fR" runat="server" OnClick="registerUserBT_Click" />
                    <h1 runat="server">Žádost o registraci</h1>
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
                                <label class="control-label">Požaduji oprávnění:</label>
                                <asp:RadioButtonList ID="rolesRBL" RepeatDirection="Horizontal" CssClass="rolesRBL" runat="server"></asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                    <div class="span6">
                        <div class="well">
                            <div id="errorDivTag" class="alert alert-error" runat="server" visible="false"></div>
                            <div class="alert alert-info">
                                <strong>Upřesnění!</strong><br />
                                <p>Všechny údaje jsou povinné. E-mail bude použit také jako uživatelské jméno.<br />
                                Minimální délka hesla je <%= Membership.MinRequiredPasswordLength %> znaků.</p>
                                <p>Zadávejte Váš skutečný e-mail. Nemusíte se obávat nevyžádaných zpráv.<br />Na e-mail obdržíte pouze potvzení registrace.</p>
                                <strong>Oprávnění</strong>
                                <ul>
                                    <li><strong>Registrovaný uživatel</strong> může vytvářet uživatelské sbírky, může je tisknout a zpřístupňovat pomocí permalinku, může příkladům přidávat uživatelské hodnocení.</li>
                                    <li><strong>Tvůrce</strong> může navíc vkládat nové příklady pod licencí CC-BY-SA 3.0, řadit je do kategorií a dávat jim příznaky. Zároveň může měnit a mazat vše co vytvořil.</li>
                                </ul>                                
                            </div>                            
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
                            <p>Vaše žádost o registraci uživatelského účtu byla přijata.</p>
                            <p>Na zadaný e-mail jsme odeslali odkaz, kterým potvrdíte Vaši žádost. Žádost potvrďte nejpozději v průběhu 2 následujících dnů. Poté bude žádost schválena.</p>
                            <p>&nbsp;</p>
                            <a href="/" class="btn btn-primary span1">OK</a>                            
                        </div>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>