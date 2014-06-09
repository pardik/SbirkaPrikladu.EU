<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="myExampleList.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Examples.myExampleList" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/difficultyProgressBar.ascx" TagName="difficultyProgressBar" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
<asp:UpdatePanel runat="server">
<ContentTemplate>        
    <div class="row"><div class="span12"><div class="well">
    <a href="/Admin/Examples/insertNewExample.aspx" class="btn btn-large btn-primary fR">Vložit nový příklad</a>
    <h1 runat="server">Vámi vložené příklady</h1>
    </div></div></div>

    <div class="row"><div class="span12"><div class="well">    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>"></asp:SqlDataSource>
    <asp:GridView ID="examplesGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" RowStyle-CssClass="gwRow">
        <Columns>            
            <asp:TemplateField HeaderText="Název příkladu" SortExpression="name"><ItemTemplate><a href="/p/<%# Eval("id") %>"><%# Eval("name") %></a></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Skupina" SortExpression="groupIds"><ItemTemplate><%# SbirkaPrikladuEU.exampleManager.groupNames(Eval("groupIds").ToString())[0] %></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Stupeň školy" SortExpression="schoolGrade"><ItemTemplate><%# SbirkaPrikladuEU.exampleManager.schoolGradeToText(Eval("schoolGrade").ToString()) %></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Obtížnost dle autora"><ItemTemplate><uc:difficultyProgressBar difficulty='<%# Eval("difficulty") %>' runat="server" /></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Uživatelská oblíbenost"><ItemTemplate><uc:ratingStars exampleId='<%# Eval("id") %>' runat="server" /></ItemTemplate></asp:TemplateField>
            <asp:TemplateField HeaderText="Vloženo" SortExpression="insertingDate"><ItemTemplate><%# Convert.ToDateTime(Eval("insertingDate")).ToString("dd.MM.yyyy | HH:mm")%></ItemTemplate></asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>            
                    <div class="btn-group fR">
                        <a href='/Admin/Examples/editExample.aspx?id=<%# Eval("id") %>' class="btn btn-mini btn-primary">Editovat</a><div class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                        <ul class="dropdown-menu">
                            <li><a href='/p/<%# Eval("id") %>'><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Zobrazit příklad</a></li>
                            <li><a href='/Admin/Examples/editExample.aspx?id=<%# Eval("id") %>'><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat příklad</a></li>
                            <li><a href='/Admin/Examples/deleteExample.aspx?id=<%# Eval("id") %>'><i class="icon-trash"></i>&nbsp;&nbsp;&nbsp;Smazat příklad</a></li>
                        </ul>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <ItemTemplate><tr><td colspan="100%"><div class="gwEnterRow"><div class="gwEnterRowContent"><%# Eval("enter") %></div></div></td></tr></ItemTemplate>
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
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>