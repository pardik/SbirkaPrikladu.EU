<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="groupMenu.ascx.cs" Inherits="SbirkaPrikladuEU.Class.groupMenu" %>
<asp:HiddenField ID="selectedNodeIdHF" runat="server" />
<ul id="exampleMenuTab" class="nav nav-pills" style="display:<%= (Roles.GetRolesForUser().Count() == 0 || Roles.GetRolesForUser()[0].ToString() != "Administrator") ? "none" : "block" %>">
  <li>
    <a href="#prikladyTab">Příklady</a>
  </li>
  <li><a href="#generatoryTab">Generátory</a></li>
</ul>
<div class="tab-content" style="overflow:hidden;">
    <div id="prikladyTab" class="tab-pane">        
        <asp:TreeView ID="exampleGroupsTV" runat="server" OnSelectedNodeChanged="selectedNodeChanged" style="margin-top: -25px;" />        
    </div>
    <div id="generatoryTab" class="tab-pane">
        <asp:TreeView id="generatorsTV" runat="server" style="margin-top: -25px;">
            <Nodes>
                <asp:TreeNode Text="Práce s čísly">
                    <asp:TreeNode Text="Dělení" NavigateUrl="/Generators/Prace-s-cisly/deleni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Krácení" NavigateUrl="/Generators/Prace-s-cisly/kraceni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Násobení" NavigateUrl="/Generators/Prace-s-cisly/nasobeni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Procenta" NavigateUrl="/Generators/Prace-s-cisly/procenta.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Rozšiřování" NavigateUrl="/Generators/Prace-s-cisly/rozsirovani.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sčítání" NavigateUrl="/Generators/Prace-s-cisly/scitani.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Složené zlomky" NavigateUrl="/Generators/Prace-s-cisly/slozene-zlomky.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Smíšená čísla 1" NavigateUrl="/Generators/Prace-s-cisly/smisena-cisla-1.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Smíšená čísla 2" NavigateUrl="/Generators/Prace-s-cisly/smisena-cisla-2.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Odmocniny">
                </asp:TreeNode>
                <asp:TreeNode Text="Lineární funkce a rovnice">
                    <asp:TreeNode Text="Najdi funkci" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/najdi-funkci.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Obor hodnot" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/obor-hodnot.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Průsečíky" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/pruseciky.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sestroj graf 1" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/sestroj-graf-1.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sestroj graf 2" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/sestroj-graf-2.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Soustava tří rovnic" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/soustava-tri-rovnic.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Kvadratické funkce a rovnice">
                </asp:TreeNode>
                <asp:TreeNode Text="Goniometrické funkce">
                </asp:TreeNode>
                <asp:TreeNode Text="Logaritmy">
                </asp:TreeNode>
                <asp:TreeNode Text="Posloupnosti">
                </asp:TreeNode>
                <asp:TreeNode Text="Shodná zobrazení">
                </asp:TreeNode>
                <asp:TreeNode Text="Mnohoúhelníky">
                </asp:TreeNode>
                <asp:TreeNode Text="Analytická geometrie">
                </asp:TreeNode>                
            </Nodes>
        </asp:TreeView>        
    </div>
</div>

<script type="text/javascript">
    $('li.<%= Roles.GetRolesForUser().Count() != 0 ? Roles.GetRolesForUser()[0].ToString() : "UnregisteredUser" %>').css("visibility", "visible");
</script>