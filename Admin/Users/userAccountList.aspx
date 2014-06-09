<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="userAccountList.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.userAcountList" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>        
            <div class="row"><div class="span12"><div class="well">
                <a href="/Admin/Users/createUser.aspx" class="btn btn-primary btn-large fR">Vytvořit nový uživatelský účet</a>
                <h1 runat="server">Správa uživatelských účtů</h1>
            </div></div></div>
            
            <div class="row">
                <div class="span12">
                    <div class="well">
                        <asp:DropDownList ID="accountStatusDDL" AutoPostBack="true" runat="server">
                            <asp:ListItem Text="Aktivní účty" Value="Active" />
                            <asp:ListItem Text="Zakázané účty" Value="Baned" />
                            <asp:ListItem Text="Vše" Value="%" />
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" SelectCommand="SELECT aspnet_UsersDetails.name, aspnet_UsersDetails.surName, aspnet_UsersDetails.userStatus, aspnet_Users.*, aspnet_Roles.RoleName, aspnet_Roles.RoleId, aspnet_Membership.LoweredEmail AS email FROM aspnet_Membership RIGHT OUTER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId LEFT OUTER JOIN aspnet_Roles INNER JOIN aspnet_UsersInRoles ON aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId LEFT OUTER JOIN aspnet_UsersDetails ON aspnet_Users.UserId = aspnet_UsersDetails.userId WHERE ([userStatus] LIKE @userStatus AND [userStatus] <> 'PreRegistered' AND [userStatus] <> 'Registered' ) ORDER BY aspnet_UsersDetails.surName">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="accountStatusDDL" Name="userStatus" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="usersGW" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="SqlDataSource1" PageSize="100">
                            <Columns>                                
                                <asp:TemplateField HeaderText="Příjmení" SortExpression="surName"><ItemTemplate><a href='/Admin/Users/userDetail.aspx?userId=<%# Eval("UserId") %>'><%# Eval("surName") %></a></ItemTemplate></asp:TemplateField>
                                <asp:TemplateField HeaderText="Jméno" SortExpression="name"><ItemTemplate><a href='/Admin/Users/userDetail.aspx?userId=<%# Eval("UserId") %>'><%# Eval("name") %></a></ItemTemplate></asp:TemplateField>                                
                                <asp:BoundField DataField="UserName" HeaderText="Login (e-mail)" SortExpression="UserName" />
                                <asp:TemplateField HeaderText="Př." HeaderStyle-CssClass="toC" HeaderStyle-Font-Bold="false" ItemStyle-CssClass="toC pr"><ItemTemplate><%# SbirkaPrikladuEU.user.getCreatedExamplesNr(new Guid(Eval("UserId").ToString())) %></ItemTemplate></asp:TemplateField>
                                <asp:TemplateField HeaderText="Sb." HeaderStyle-CssClass="toC" HeaderStyle-Font-Bold="false" ItemStyle-CssClass="toC sb"><ItemTemplate><%# SbirkaPrikladuEU.user.getCreatedCollectionsNr(new Guid(Eval("UserId").ToString())) %></ItemTemplate></asp:TemplateField>
                                <asp:BoundField DataField="LastActivityDate" HeaderText="Poslední aktivita" SortExpression="LastActivityDate" DataFormatString="{0:dd.MM.yyyy | hh:mm}" />                                
                                <asp:TemplateField HeaderText="Oprávnění" SortExpression="RoleName"><ItemTemplate><%# SbirkaPrikladuEU.user.translateRoleToCzech(Eval("RoleName").ToString()) %></ItemTemplate></asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" SortExpression="userStatus"><ItemTemplate><%# SbirkaPrikladuEU.user.getStatus(new Guid(Eval("UserId").ToString())) %></ItemTemplate></asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="btn-group fR">
                                            <a href='/Admin/Users/editUser.aspx?userId=<%# Eval("UserId") %>' class="btn btn-mini btn-primary">Editovat</a><div class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                                            <ul class="dropdown-menu">
                                                <li><a href='/Admin/Users/userDetail.aspx?userId=<%# Eval("UserId") %>'><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Zobrazit detail účtu</a></li>
                                                <li><a href='/Admin/Users/editUser.aspx?userId=<%# Eval("UserId") %>'><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat uživatelský účet</a></li>
                                                <li><a href='/Admin/Users/deleteUser.aspx?userId=<%# Eval("UserId") %>'><i class="icon-trash"></i>&nbsp;&nbsp;&nbsp;Smazat uživatelský účet</a></li>
                                            </ul>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>                                
                            </Columns>
                            <EmptyDataTemplate>
                                <div class='alert alert-info'><p>V této skupině nejsou žádné uživatelské účty.</p></div>
                            </EmptyDataTemplate>
                            <PagerTemplate>
                                <uc:gridViewPager runat="server" />
                            </PagerTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        $(".pr").each(function () { if ($(this).html() == "0") $(this).html("-"); });
        $(".sb").each(function () { if ($(this).html() == "0") $(this).html("-"); });
    </script>
</asp:Content>