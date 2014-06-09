<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="topMenu.ascx.cs" Inherits="SbirkaPrikladuEU.topMenu" %>
<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <%--<div class="hidden-desktop">
                <ul class="nav">
                    <li><a data-toggle="collapse" data-target=".nav-collapse">SbírkaPříkladů.eu - Hlavní menu</a></li>
                </ul>
            </div>
                --%>                        
            <ul class="nav">
                <li><a href="/">Hlavní strana</a></li>
                
                <li class="dropdown Administrator Moderator Author RegistredUser hidden">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sbírky příkladů<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/Admin/Collections/myCollectionsList.aspx?a=createNew">Založit novou sbírku</a></li>
                        <li><a href="/Admin/Collections/myCollectionsList.aspx">Seznam mých sbírek</a></li>
                    </ul>
                </li>

                <li class="dropdown Administrator Moderator Author hidden">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Příklady<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/Admin/Examples/insertNewExample.aspx">Nový příklad</a></li>
                        <li><a href="/Admin/Examples/myExampleList.aspx">Seznam mých příkladů</a></li>
                    </ul>
                </li>

                <li class="dropdown Administrator hidden">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Správa obsahu<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/Admin/ContentManagement/exampleGroupsEdit.aspx">Kategorie příkladů</a></li>
                        <li><a href="/Admin/ContentManagement/deletedExamplesList.aspx">Smazané příklady</a></li>                        
                        <li><a href="/scheduledTasks.aspx">Automatická denní údržba</a></li>
                    </ul>
                </li>

                <li class="dropdown Administrator hidden">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Uživatelé<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/Admin/Users/createUser.aspx">Vytvořit nový účet</a></li>
                        <li><a href="/Admin/Users/userAccountList.aspx">Správa uživatelských účtů</a></li>
                        <li><a href="/Admin/Users/registeredUserList.aspx">Žádosti o registraci</a></li>
                        <li><a href="/Admin/Users/emailing.aspx">Poslat e-mail</a></li>
                    </ul>
                </li>                                                
            </ul>
            <ul class="nav nav-login">                
                <li class="dropdown Administrator hidden">
                <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
                    <AnonymousTemplate>
                        <li>
                        <a href="~/Admin/login.aspx" ID="HeadLoginStatus" runat="server">Přihlásit se</a>
                        </li>
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%= SbirkaPrikladuEU.user.fullName() %><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="/Admin/Users/updateUserProfile.aspx"><i class="icon-user"></i>&nbsp;&nbsp;&nbsp;Profil</a></li>
                                <li><asp:LoginStatus runat="server" LogoutAction="Redirect" LogoutText="<i class='icon-off'></i>&nbsp;&nbsp;&nbsp;Odhásit" LogoutPageUrl="~/"/></li>
                            </ul>
                        </li>                            
                    </LoggedInTemplate>
                </asp:LoginView>                
                </li>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('li.<%= Roles.GetRolesForUser().Count() != 0 ? Roles.GetRolesForUser()[0].ToString() : "UnregisteredUser" %>').css("visibility", "visible");
</script>