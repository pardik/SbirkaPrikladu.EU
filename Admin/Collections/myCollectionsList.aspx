﻿<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="myCollectionsList.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Collections.myCollectionsList" %>
<%@ Register Src="/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
<asp:UpdatePanel runat="server">
<ContentTemplate>
    <div class="row"><div class="span12"><div class="well">
    <a class="btn btn-large btn-primary fR" data-toggle="modal" href="#newCollectionModal">Založit novou sbírku</a>
    <h1 runat="server">Vaše sbírky příkladů</h1>
    </div></div></div>

    <div class="row"><div class="span12"><div class="well">
    <input id="searchCollectionTB" type="text" class="input-large" placeholder="Hledat..." onkeyup="searchCollection($(this).val());" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>"></asp:SqlDataSource>
    <asp:GridView ID="collectionsGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" RowStyle-CssClass="gwRow collectionRow">
        <Columns>            
            <asp:TemplateField HeaderText="Název sbírky" SortExpression="name"><ItemTemplate><a href="/s/<%# Eval("id") %>" class="collectionName"><%# Eval("name") %></a></ItemTemplate></asp:TemplateField>            
            <asp:TemplateField><ItemTemplate><%# SbirkaPrikladuEU.collectionManager.getChangedExamplesNrInCollection(Convert.ToInt64(Eval("id"))) != 0 ? "<a href='/s/" + Eval("id") + "' title='Příklady byly, poté co byly vloženy do Vaší sbírky, pozměněny autorem. Raději si zkontrolujte zda je vše v pořádku.' class='alert-danger'><i class='icon icon-warning-sign'></i>&nbsp;&nbsp;&nbsp;Ve sbírce došlo k úpravě příkladů</a>" : "" %></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Štítky" SortExpression="name"><ItemTemplate><%# getLabelsHtml(Eval("labels").ToString()) %></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Veřejná" SortExpression="isPublic"><ItemTemplate><asp:CheckBox Checked='<%# Eval("isPublic") %>' dataKey='<%# Eval("id") %>' runat="server" AutoPostBack="true" OnCheckedChanged="changeIsPublic" /></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Nadpisy" SortExpression="hideExamplesHeaders"><ItemTemplate><asp:CheckBox Checked='<%# !Convert.ToBoolean(Eval("hideExamplesHeaders")) %>' dataKey='<%# Eval("id") %>' runat="server" AutoPostBack="true" OnCheckedChanged="changeHideHeaders" /></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Řešení" SortExpression="hideExamplesSolutions"><ItemTemplate><asp:CheckBox Checked='<%# !Convert.ToBoolean(Eval("hideExamplesSolutions")) %>' dataKey='<%# Eval("id") %>' runat="server" AutoPostBack="true" OnCheckedChanged="changeHideSolutions" /></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Výsledky" SortExpression="hideExamplesResults"><ItemTemplate><asp:CheckBox Checked='<%# !Convert.ToBoolean(Eval("hideExamplesResults")) %>' dataKey='<%# Eval("id") %>' runat="server" AutoPostBack="true" OnCheckedChanged="changeHideResults" /></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Poslední úprava" SortExpression="lastUpdate"><ItemTemplate><%# Convert.ToDateTime(Eval("lastUpdate")).ToString("dd.MM.yyyy | HH:mm")%></ItemTemplate></asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="btn-group fR">
                        <a href='/Admin/Collections/editCollection.aspx?id=<%# Eval("id") %>' class="btn btn-mini btn-primary">Editovat</a><div class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                        <ul class="dropdown-menu">
                            <li><a href='/s/<%# Eval("id") %>'><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Zobrazit sbírku</a></li>
                            <li><a href='/Admin/Collections/editCollection.aspx?id=<%# Eval("id") %>'><i class=" icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat sbírku</a></li>
                            <li><a href='/Admin/Collections/deleteCollection.aspx?id=<%# Eval("id") %>'><i class="icon-trash"></i>&nbsp;&nbsp;&nbsp;Smazat sbírku</a></li>
                        </ul>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class='alert alert-info'><span type='button' class='close' data-dismiss='alert'>&times;</span><h3>Je nám líto.</h3><p>Nemáte založeny žádné sbírky příkladů.</p></div>
        </EmptyDataTemplate>
        <PagerTemplate>
            <uc:gridViewPager runat="server" />
        </PagerTemplate>
    </asp:GridView>
    </div></div></div>
    
    <asp:Panel ID="newCollectionModal" ClientIDMode="Static" class="modal hide fade" DefaultButton="createNewCollectionBT" runat="server">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h3>Založte si novou sbírku příkladů.</h3>
        </div>
        <div class="modal-body">
            <div class="form-horizontal">
                <div class="control-group">
                    <div class=" control-label">Název sbírky:</div>
                    <div class=" controls"><asp:TextBox ID="newCollectionNameTB" CssClass="input-xlarge" placeholder="Zvolte název pečlivě, prosím..." runat="server" /></div>
                </div>
                <div class="control-group">
                    <div class=" control-label">Veřejně přístupná:</div>
                    <div class="controls">
                        <asp:DropDownList ID="newCollectionIsPublicDDL" CssClass="input-xlarge" runat="server">
                            <asp:ListItem Text="Ne - Sbírka bude soukromá" Value="false" />
                            <asp:ListItem Text="Ano - Sbírka bude veřejně přístupná" Value="true" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <div class=" control-label">Štítky:</div>
                    <div class=" controls"><asp:TextBox ID="labelsTB" CssClass="input-xlarge" placeholder="Zvolte štítky nebo klíčová slova pro snadnější orientaci a vyhledávání. Oddělujte čárkou." runat="server" /></div>
                </div>
                <div class="control-group">
                    <div class=" control-label">Omezení:</div>
                    <div class="controls">
                        <asp:DropDownList ID="hideExamplesHeadersDDL" CssClass="input-xlarge" runat="server">
                            <asp:ListItem Text="Zobrazovat nadpisy příkladů" Value="false" />
                            <asp:ListItem Text="Skrýt nadpisy příkladů" Value="true" />
                        </asp:DropDownList>
                    </div>
                    <br />
                    <div class="controls">
                        <asp:DropDownList ID="hideExamplesSolutionsDDL" CssClass="input-xlarge" runat="server">
                            <asp:ListItem Text="Zobrazovat řešení příkladů" Value="false" />
                            <asp:ListItem Text="Skrýt řešení příkladů" Value="true" />
                        </asp:DropDownList>
                    </div>
                    <br />
                    <div class="controls">
                        <asp:DropDownList ID="hideExamplesResultsDDL" CssClass="input-xlarge" runat="server">
                            <asp:ListItem Text="Zobrazovat výsledek příkladů" Value="false" />
                            <asp:ListItem Text="Skrýt výsledky příkladů" Value="true" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <br />
            <div class="alert alert-info">
                <span type='button' class='close' data-dismiss='alert'>&times;</span>
                <p><strong>Dobrá rada nad zlato!</strong></p>
                <p>Volte název sbírky rozumně. Počítejte s tím, že sbírek budete mít časem více a nebude snadné se v nich vyznat.</p>
                <p>Neveřejné sbírky můžete zobrazit pouze vy, veřejné sbírky mohou zobrazit i ostatní uživatelé.</p>
                <p>Štítky Vám pomohou v orientaci a následném vyhledávání mezi Vašimi sbírkami. Jednotlivé štítky oddělujte čárkou. Ostatní uživatelé Vaše štítky neuvidí.</p>
                <p>Omezení se samozřejmě netýkají Vás, ale co zakážete to ostatní uživatelé neuvidí.</p>
            </div>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Zrušit</a>
            <asp:Button ID="createNewCollectionBT" Text="Založit sbírku" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" runat="server" OnClick="createNewCollection" />
        </div>
    </asp:Panel>

</ContentTemplate>
<Triggers>
    <asp:AsyncPostBackTrigger ControlID="createNewCollectionBT" />
</Triggers>
</asp:UpdatePanel> 

    <script>
        function searchCollection(searchText) {
            $('.collectionRow').hide();
            $('.collectionName').each(function () {
                if ($(this).text().toLowerCase().indexOf(searchText.toLowerCase()) >= 0){
                    $(this).closest('.collectionRow').show();
                }
            });
            $('.collectionLabel').each(function () {
                if ($(this).text().toLowerCase().indexOf(searchText.toLowerCase()) >= 0) {
                    $(this).closest('.collectionRow').show();
                }
            });
        }
    </script>
</asp:Content>