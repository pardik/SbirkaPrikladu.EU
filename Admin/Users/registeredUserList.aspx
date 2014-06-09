<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="registeredUserList.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.registeredUserList" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<%@ Register Src="~/Class/gridViewPager.ascx" TagName="gridViewPager" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>        
            <div class="row"><div class="span12"><div class="well">                
                <h1 runat="server">Žádosti o registraci uživatelských účtů</h1>
            </div></div></div>
            
            <div class="row">
                <div class="span12">
                    <div class="well">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" SelectCommand="SELECT aspnet_UsersDetails.name, aspnet_UsersDetails.surName, aspnet_Users.*, aspnet_Roles.RoleName, aspnet_Roles.RoleId, aspnet_Membership.LoweredEmail AS email FROM aspnet_Membership RIGHT OUTER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId LEFT OUTER JOIN aspnet_Roles INNER JOIN                         aspnet_UsersInRoles ON aspnet_Roles.RoleId = aspnet_UsersInRoles.RoleId ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId LEFT OUTER JOIN aspnet_UsersDetails ON aspnet_Users.UserId = aspnet_UsersDetails.userId WHERE userStatus = 'Registered'"></asp:SqlDataSource>
                        <asp:GridView ID="usersGW" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="SqlDataSource1">
                            <Columns>                                
                                <asp:BoundField DataField="UserName" HeaderText="Login" SortExpression="UserName" />
                                <asp:BoundField DataField="surName" HeaderText="Příjmení" SortExpression="surName" />
                                <asp:BoundField DataField="name" HeaderText="Jméno" SortExpression="name" />
                                <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="email" />
                                <asp:BoundField DataField="LastActivityDate" HeaderText="Poslední aktivita" SortExpression="LastActivityDate" DataFormatString="{0:dd.MM.yyyy | hh:mm}" />                                
                                <asp:TemplateField HeaderText="Oprávnění" SortExpression="RoleName"><ItemTemplate><%# SbirkaPrikladuEU.user.translateRoleToCzech(Eval("RoleName").ToString()) %></ItemTemplate></asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>            
                                        <div class="btn-group fR" runat="server">
                                            <asp:LinkButton runat="server" CommandArgument='<%# Eval("UserId") %>' class="btn btn-mini btn-primary" OnClick="authorizeUser">Schválit</asp:LinkButton><div class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                                            <ul class="dropdown-menu">                                                
                                                <li><asp:LinkButton runat="server" CommandArgument='<%# Eval("UserId") %>' OnClick="authorizeUser"><i class="icon-ok"></i>&nbsp;&nbsp;&nbsp;Schválit žádost</asp:LinkButton></li>
                                                <li><asp:LinkButton runat="server" CommandArgument='<%# Eval("UserId") %>' OnClick="rejectUser"><i class="icon-remove"></i>&nbsp;&nbsp;&nbsp;Zamítnout žádost</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>                                
                            </Columns>
                            <EmptyDataTemplate><h3>Nemáte žádné nové žádosti o registraci uživatelského účtu</h3></EmptyDataTemplate>
                            <PagerTemplate>
                                <uc:gridViewPager runat="server" />
                            </PagerTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>