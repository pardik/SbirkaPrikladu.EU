<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="examplesFromGroupId.ascx.cs" Inherits="SbirkaPrikladuEU.Class.examplesFromGroupId" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/difficultyProgressBar.ascx" TagName="difficultyProgressBar" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:UpdatePanel runat="server">
    <ContentTemplate>    
        <div class="row"><div class="span9"><div class="well">            
            <h2 id="groupNameTag" runat="server"></h2>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>"></asp:SqlDataSource>
            <asp:GridView ID="examplesGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" RowStyle-CssClass="gwRow" PageSize="5">
                <Columns>            
                    <asp:TemplateField HeaderText="Název příkladu"><ItemTemplate><a href="/p/<%# Eval("id") %>"><h3><%# Eval("name") %></h3></a></ItemTemplate></asp:TemplateField>
                    <%-- <asp:TemplateField HeaderText="Skupina"><ItemTemplate><%# SbirkaPrikladuEU.exampleManager.groupNames(Eval("groupIds").ToString())[0] %></ItemTemplate></asp:TemplateField> --%>
                    <asp:TemplateField HeaderText="Stupeň školy"><ItemTemplate><%# SbirkaPrikladuEU.exampleManager.schoolGradeToText(Eval("schoolGrade").ToString()) %></ItemTemplate></asp:TemplateField>            
                    <asp:TemplateField HeaderText="Obtížnost dle autora"><ItemTemplate><uc:difficultyProgressBar difficulty='<%# Eval("difficulty") %>' runat="server" /></ItemTemplate></asp:TemplateField>
                    <%-- <asp:TemplateField HeaderText="Autor"><ItemTemplate><%# SbirkaPrikladuEU.user.fullNameFromId(Eval("ownerId").ToString()) %></ItemTemplate></asp:TemplateField> --%>
                    <asp:TemplateField HeaderText="Uživatelská oblíbenost" ItemStyle-CssClass="visible-desktop" HeaderStyle-CssClass="visible-desktop"><ItemTemplate><uc:ratingStars exampleId='<%# Eval("id") %>' runat="server" /></ItemTemplate></asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate><tr><td colspan="100%"><div class="gwEnterRow"><div class="gwEnterRowContent"><%# Eval("enter") %></div></div></td></tr></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class='alert alert-info'><span class='close' data-dismiss='alert'>&times;</span><h3>Je nám líto.</h3><p>V této skupině nejsou doposud zadány žádné příklady, nebo jsou zadány příklady, které nevyhovují Vašemu nastavení filtrů na typ školy.</p></div>
                </EmptyDataTemplate>
                <PagerTemplate>
                    <uc:gridViewPager runat="server" />
                </PagerTemplate>
            </asp:GridView>
        </div></div></div>
    </ContentTemplate>
</asp:UpdatePanel>