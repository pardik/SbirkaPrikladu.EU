<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="groupMenu.ascx.cs" Inherits="SbirkaPrikladuEU.Class.groupMenu" %>
<asp:HiddenField ID="selectedNodeIdHF" runat="server" />
<ul id="exampleMenuTab" class="nav nav-pills">
  <li>
    <a href="#prikladyTab" onclick="$('.sideBar').css('max-width','');recomputeFooterPosition();">Příklady</a>
  </li>
  <li>
      <%--<a href="#generatoryTab" onclick="$('.sideBar').css('max-width','280px');recomputeFooterPosition();">Generátory</a>--%>
      <a href="#generatoryTab" onclick="$('.sideBar').css('max-width','280px');recomputeFooterPosition();" data-toggle="popover" title="Novinka" data-content="Vyzkoušejte nové generátory příkladů.">Generátory</a>
      <script>
          /*$('[href="#generatoryTab"]').popover({ animation: true, trigger: 'hover' });*/
          function showTryGenerators() {
              setTimeout(function () { $('[href="#generatoryTab"]').popover('show'); }, 1000);
              setTimeout(function () { $('[href="#generatoryTab"]').popover('hide'); }, 5000);
          }
      </script>
  </li>
</ul>
<div class="tab-content" style="overflow:hidden;">
    <div id="prikladyTab" class="tab-pane">
        <asp:TreeView ID="exampleGroupsTV" runat="server" OnSelectedNodeChanged="selectedNodeChanged" style="margin-top: -25px;" />        
    </div>
    <div id="generatoryTab" class="tab-pane">
        <asp:TreeView id="generatorsTV" runat="server" style="margin-top: -25px;">
            <Nodes>
                <asp:TreeNode Text="Práce s čísly" NavigateUrl="javascript:void(0);">
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
                <asp:TreeNode Text="Odmocniny" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Částečné odmocnění" NavigateUrl="/Generators/Odmocniny/castecne-odmocneni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Násobení" NavigateUrl="/Generators/Odmocniny/nasobeni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sčítání" NavigateUrl="/Generators/Odmocniny/scitani.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Umocnění" NavigateUrl="/Generators/Odmocniny/umocneni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Usměrnění 1" NavigateUrl="/Generators/Odmocniny/usmerneni01.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Usměrnění 2" NavigateUrl="/Generators/Odmocniny/usmerneni02.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Lineární funkce a rovnice" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Najdi funkci" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/najdi-funkci.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Obor hodnot" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/obor-hodnot.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Průsečíky" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/pruseciky.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sestroj graf 1" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/sestroj-graf-1.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sestroj graf 2" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/sestroj-graf-2.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Soustava tří rovnic" NavigateUrl="/Generators/Linearni-funkce-a-rovnice/soustava-tri-rovnic.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Kvadratické funkce a rovnice" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Graf tabulkou" NavigateUrl="/Generators/Kvadraticka-funkce/graf-tabulkou.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Graf transformací" NavigateUrl="/Generators/Kvadraticka-funkce/graf-transformaci.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Kvadratická nerovnice" NavigateUrl="/Generators/Kvadraticka-funkce/kvadraticka-nerovnice.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Kvadratická rovnice" NavigateUrl="/Generators/Kvadraticka-funkce/kvadraticka-rovnice.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Obor hodnot" NavigateUrl="/Generators/Kvadraticka-funkce/obor-hodnot.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Průsečíky" NavigateUrl="/Generators/Kvadraticka-funkce/pruseciky.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sestav rovnici 1" NavigateUrl="/Generators/Kvadraticka-funkce/sestav-rovnici01.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Sestav rovnici 2" NavigateUrl="/Generators/Kvadraticka-funkce/sestav-rovnici02.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Goniometrické funkce" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Obecný trojúhelník" NavigateUrl="/Generators/Goniometricke-funkce/obecny-trojuhelnik.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Převod na radiany" NavigateUrl="/Generators/Goniometricke-funkce/prevod-na-radiany.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Převod na stupně" NavigateUrl="/Generators/Goniometricke-funkce/prevod-na-stupne.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Základní úhel" NavigateUrl="/Generators/Goniometricke-funkce/zakladni-uhel.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Logaritmy" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Logaritmy 1" NavigateUrl="/Generators/Logaritmy/logaritmy01.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Logaritmy 2" NavigateUrl="/Generators/Logaritmy/logaritmy02.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Posloupnosti" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Aritmetická posloupnost 1" NavigateUrl="/Generators/Posloupnosti/aritmeticka-posloupnost01.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Aritmetická posloupnost 2" NavigateUrl="/Generators/Posloupnosti/aritmeticka-posloupnost02.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Aritmetická posloupnost 3" NavigateUrl="/Generators/Posloupnosti/aritmeticka-posloupnost03.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Geometrická posloupnost" NavigateUrl="/Generators/Posloupnosti/geometricka-posloupnost.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode Text="Shodná zobrazení" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Najdi shodné zobrazení" NavigateUrl="/Generators/Shodna-zobrazeni/najdi-shodne-zobrazeni.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Posunutí" NavigateUrl="/Generators/Shodna-zobrazeni/posunuti.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Rotace" NavigateUrl="/Generators/Shodna-zobrazeni/rotace.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Shodné zobrazení v soustavě" NavigateUrl="/Generators/Shodna-zobrazeni/shodne-zobrazeni-v-soustave.aspx"></asp:TreeNode>
                    <%--<asp:TreeNode Text="Souměrnosti" NavigateUrl="/Generators/Shodna-zobrazeni/soumernosti.aspx"></asp:TreeNode>--%>
                </asp:TreeNode>
                <asp:TreeNode Text="Mnohoúhelníky" NavigateUrl="javascript:void(0);">
                    <asp:TreeNode Text="Obsah nepravidelného" NavigateUrl="/Generators/Mnohouhelniky/obsah-nepravidelneho.aspx"></asp:TreeNode>
                    <asp:TreeNode Text="Obsah pravidelného" NavigateUrl="/Generators/Mnohouhelniky/obsah-pravidelneho.aspx"></asp:TreeNode>
                </asp:TreeNode>
                <%--<asp:TreeNode Text="Analytická geometrie" NavigateUrl="javascript:void(0);">                    
                </asp:TreeNode> --%>               
            </Nodes>
        </asp:TreeView>        
    </div>
</div>

<script type="text/javascript">
    $('li.<%= Roles.GetRolesForUser().Count() != 0 ? Roles.GetRolesForUser()[0].ToString() : "UnregisteredUser" %>').css("visibility", "visible");
</script>