<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="deletedExamplesList.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.ContentManagement.deletedExamplesList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
    <asp:HiddenField ID="deleteIdHF" ClientIDMode="Static" Value="0" runat="server" />
    <div class="row"><div class="span12"><div class="well">    
    <h1 runat="server">Seznam smazaných příkladů</h1>
    </div></div></div>

    <div class="row"><div class="span12"><div class="well">    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" SelectCommand="SELECT * FROM [examples] WHERE [status] = 'DELETED' ORDER BY [deletingDate] DESC"></asp:SqlDataSource>
    <asp:GridView ID="examplesGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
        <Columns>            
            <asp:TemplateField HeaderText="Název příkladu" SortExpression="name"><ItemTemplate><a href="/p/<%# Eval("id") %>"><%# Eval("name") %></a></ItemTemplate></asp:TemplateField>            
            <asp:TemplateField HeaderText="Ve sbírce"><ItemTemplate><%# SbirkaPrikladuEU.collectionManager.getInHowManyCollectionsIsExampleIncluded(Convert.ToInt64(Eval("id"))) %>x</ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Autor"><ItemTemplate><%# SbirkaPrikladuEU.user.fullNameFromId(Eval("lastOwnerBeforeDeleting").ToString()) %></ItemTemplate></asp:TemplateField>            
            <asp:TemplateField HeaderText="Vloženo" SortExpression="insertingDate"><ItemTemplate><%# Convert.ToDateTime(Eval("insertingDate")).ToString("dd.MM.yyyy | HH:mm")%></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Smazáno" SortExpression="deletingDate"><ItemTemplate><%# Convert.ToDateTime(Eval("deletingDate")).ToString("dd.MM.yyyy | HH:mm")%></ItemTemplate></asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>            
                    <div class="btn-group fR">
                        <a href='/Admin/Examples/editExample.aspx?id=<%# Eval("id") %>' class="btn btn-mini btn-primary">Editovat</a><div class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                        <ul class="dropdown-menu">
                            <li><a href='/p/<%# Eval("id") %>'><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Zobrazit příklad</a></li>
                            <li><a href='/Admin/Examples/editExample.aspx?id=<%# Eval("id") %>'><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat příklad</a></li>
                            <li>
                                <a href="#modalConfirm" data-toggle="modal" onclick="$('#deleteIdHF').val('<%# Eval("id") %>');"><i class='icon-trash'></i>&nbsp;&nbsp;&nbsp;Smazat definitivně</a>
                                <%--
                                <asp:LinkButton ID="deleteBT" datakey='<%# Eval("id") %>' Text="<i class='icon-trash'></i>&nbsp;&nbsp;&nbsp;Smazat definitivně" runat="server" OnClick="deleteExampleDefinitively" data-toggle="modal" href="#myModal" />                                
                                <asp:ConfirmButtonExtender TargetControlID="deleteBT" ConfirmText="Opravdu definitivně smazat příklad?&#10;Příklad bude odstraněn také ze všech uživatelských sbírek. Toto je nevratný krok." runat="server" />
                                --%>
                            </li>
                        </ul>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class='alert alert-info'><span type='button' class='close' data-dismiss='alert'>&times;</span><h3>Je nám líto.</h3><p>V této skupině doposud nejsou zadány žádné příklady.</p></div>
        </EmptyDataTemplate>
        <PagerTemplate>
            <uc:gridViewPager runat="server" />
        </PagerTemplate>
    </asp:GridView>
    </div></div></div>

    <div class="modal hide fade" id="modalConfirm">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <h3 id="h3">Definitivně smazat příklad</h3>
        </div>
        <div class="modal-body">
            <div class="alert alert-danger">                
                <h3>Pozor!</h3>                
                <p>Příklad bude odstraněn také ze všech sbírek ostatních uživatelů. Toto je nevratný krok.</p>
            </div>            
        </div>
        <div class="modal-footer">
            <asp:Button ID="delConfirmBT" ClientIDMode="Static" Text="Rozumím - Přesto zmazat příklad" class="btn btn-danger" data-dismiss="modal" UseSubmitBehavior="false" runat="server" OnClick="deleteExampleDefinitively" />            
            <a href="#" class="btn btn-primary" data-dismiss="modal">Zpět - Nemazat příklad</a>
        </div>
    </div>
    

</ContentTemplate>
<Triggers>
    <asp:AsyncPostBackTrigger ControlID="delConfirmBT" />
</Triggers>
</asp:UpdatePanel>

</asp:Content>
