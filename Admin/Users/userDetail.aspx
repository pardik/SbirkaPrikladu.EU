<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="userDetail.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.userDetail" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/difficultyProgressBar.ascx" TagName="difficultyProgressBar" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
<asp:UpdatePanel runat="server">
<ContentTemplate>        
    <div class="row"><div class="span12"><div class="well">
    <div class="btn-group fR">                    
        <a href='/Admin/Users/editUser.aspx?userId=<%= Request.QueryString["userId"].ToString() %>' class="btn btn-large btn-primary">Editovat uživatelský účet</a>        
        <div id="navDDLBT" class="btn btn-large btn-primary dropdown-toggle" data-toggle="dropdown" runat="server"><span class="caret"></span></div>
        <ul class="dropdown-menu fR">
            <li><a href='/Admin/Users/editUser.aspx?userId=<%= Request.QueryString["userId"].ToString() %>'><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat uživatelský účet</a></li>
            <li><a href='/Admin/Users/deleteUser.aspx?userId=<%= Request.QueryString["userId"].ToString() %>'><i class="icon-trash"></i>&nbsp;&nbsp;&nbsp;Smazat uživatelský účet</a></li>            
        </ul>
    </div>
    <h1 runat="server">Detail uživatelského účtu</h1>
    <br />
    <asp:Panel CssClass="form-horizontal" Enabled="false" runat="server">
        <div class="control-group fL">
            <label class="control-label">Jméno a příjmení:</label>
            <div class="controls">
                <asp:TextBox ID="nameTB" runat="server" />
            </div>
        </div>
        <div class="control-group fL">
            <label class="control-label">Status účtu:</label>
            <div class="controls">
                <asp:TextBox ID="statusTB" runat="server" />
            </div>
        </div>        
        <br class="clear" />
        <div class="control-group fL">
            <label class="control-label">E-mail:</label>
            <div class="controls">
                <asp:TextBox ID="emailTB" runat="server" />
            </div>
        </div>                                                                                    
        <div class="control-group fL">
            <label class="control-label">Oprávnění:</label>
            <div class="controls">
                <asp:TextBox ID="roleTB" runat="server" />
            </div>
        </div>
        <br class="clear" />
        <div class="control-group fL">
            <label class="control-label">Poslední aktivita:</label>
            <div class="controls">
                <asp:TextBox ID="lastActivityTB" runat="server" />
            </div>
        </div>
        <br class="clear" />
    </asp:Panel>
     
     </div></div></div>

    <div class="row"><div class="span12"><div class="well">
        <h2>Uživatel je tvůrcem následujících příkladů a sbírek:</h2>
        <div class="tabbable">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#examplesTab" data-toggle="tab">Příklady (<%= SbirkaPrikladuEU.user.getCreatedExamplesNr(userId).ToString() %>)</a></li>
                <li><a href="#collectionsTab" data-toggle="tab">Sbírky (<%= SbirkaPrikladuEU.user.getCreatedCollectionsNr(userId).ToString() %>)</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="examplesTab">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>"></asp:SqlDataSource>                    
                    <asp:GridView ID="examplesGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1" RowStyle-CssClass="gwRow" AllowPaging="false" PageSize="1000">
                        <Columns>            
                            <asp:TemplateField HeaderText="Název příkladu" SortExpression="name"><ItemTemplate><a href="/p/<%# Eval("id") %>"><%# Eval("name") %></a></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Skupina" SortExpression="groupIds"><ItemTemplate><%# SbirkaPrikladuEU.exampleManager.groupNames(Eval("groupIds").ToString())[0] %></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Stupeň školy" SortExpression="schoolGrade"><ItemTemplate><%# SbirkaPrikladuEU.exampleManager.schoolGradeToText(Eval("schoolGrade").ToString()) %></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Obtížnost dle autora"><ItemTemplate><uc:difficultyProgressBar difficulty='<%# Eval("difficulty") %>' runat="server" /></ItemTemplate></asp:TemplateField>            
                            <asp:TemplateField ><ItemTemplate><asp:CheckBox Text="Zkontrolováno" Checked='<%# Eval("verified") %>' CssClass="checkbox" Height="0" dataKey='<%# Eval("id") %>' AutoPostBack="true" runat="server" OnCheckedChanged="verifiedCHB_CheckedChanged" /><br /><asp:CheckBox Text="Zaplaceno" Checked='<%# Eval("paid") %>' CssClass="checkbox" Height="0" dataKey='<%# Eval("id") %>' AutoPostBack="true" runat="server" OnCheckedChanged="paidCHB_CheckedChanged" /></ItemTemplate></asp:TemplateField>
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
                </div>
                <div class="tab-pane" id="collectionsTab">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>"></asp:SqlDataSource>
                    <asp:GridView ID="collectionsGW" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource2" RowStyle-CssClass="gwRow" PageSize="1000">
                        <Columns>            
                            <asp:TemplateField HeaderText="Název sbírky" SortExpression="name"><ItemTemplate><a href="/s/<%# Eval("id") %>"><%# Eval("name") %></a></ItemTemplate></asp:TemplateField>            
                            <asp:TemplateField><ItemTemplate><%# SbirkaPrikladuEU.collectionManager.getChangedExamplesNrInCollection(Convert.ToInt64(Eval("id"))) != 0 ? "<a href='/s/" + Eval("id") + "' title='Příklady byly, poté co byly vloženy do Vaší sbírky, pozměněny autorem. Raději si zkontrolujte zda je vše v pořádku.' class='alert-danger'><i class='icon icon-warning-sign'></i>&nbsp;&nbsp;&nbsp;Ve sbírce došlo k úpravě příkladů</a>" : "" %></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Veřejná sbírka" SortExpression="isPublic"><ItemTemplate><asp:CheckBox ID="CheckBox1" Checked='<%# Eval("isPublic") %>' dataKey='<%# Eval("id") %>' runat="server" AutoPostBack="true" OnCheckedChanged="changeIsPublic" /></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Poslední úprava" SortExpression="lastUpdate"><ItemTemplate><%# Convert.ToDateTime(Eval("lastUpdate")).ToString("dd.MM.yyyy | HH:mm")%></ItemTemplate></asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class='alert alert-info'><span type='button' class='close' data-dismiss='alert'>&times;</span><h3>Je nám líto.</h3><p>Nemáte založeny žádné sbírky příkladů.</p></div>
                        </EmptyDataTemplate>
                        <PagerTemplate>
                            <uc:gridViewPager ID="GridViewPager1" runat="server" />
                        </PagerTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div></div></div>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>