<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="SbirkaPrikladuEU.about" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
<div class="row">
    <div class="span9">
        <div class="well">
            <h1>O projektu SbírkaPříkladů.eu</h1>
            <p></p>        
            <p>V oblasti matematiky klademe důraz na pochopení vztahů a podání příkladů z maximálního počtu úhlů pohledů.</p>
            <p>Pro naplnění této vize využíváme i Operačního programu Vzdělávání pro konkurenceschopnost a realizujeme projekt SbírkaPříkladů.EU. V rámci tohoto projektu škola (za pomoci partnerů) vytváří a ověřuje webovou sbírku příkladů.</p>
            <p>Sbírka umožňuje vyhledávat, filtrovat příklady podle mnoha kategorií a dívat se na matematické problémy z mnoha pohledů. Pro dosažení rozmanitosti jsou úlohy vytvářeny mnoha učiteli ze základních a středních škol. Příklady i prostředí jsou vytvářeny pod svobodnými licencemi a mohou je tedy využívat všichni zájemci – potěší nás zpětná vazba.</p>
            <h3>Projekt realizuje:</h3> <p><strong><a href="http://www.primmat.cz/" target="_blank">PrimMat – Soukromá střední škola podnikatelská, s.r.o.</a></strong></p>
            <h3>Partnery projektu jsou:</h3>            
            <ul>            
            <li><a href="http://www.hladnov.cz" target="_blank">Gymnázium Hladnov a Jazyková škola s právem státní jazykové zkoušky</a></li>
            <li><a href="http://www.kvic.cz" target="_blank">Krajské zařízení pro další vzdělávání pedagogických pracovníků a informační centrum, Nový Jičín</a></li>
            <li><a href="http://www.oa-opava.cz" target="_blank">Obchodní akademie a Střední odborná škola logistická Opava</a></li>
            <li><a href="http://www.spsoafm.cz" target="_blank">Střední průmyslová škola, Obchodní akademie a Jazyková škola s právem státní jazykové zkoušky, Frýdek-Místek</a></li>
            <li><a href="http://info.skola.liskovec.cz" target="_blank">Základní škola a mateřská škola Frýdek-Místek, Lískovec</a></li>
            <li><a href="http://www.zsceladna.cz" target="_blank">Základní škola Čeladná</a></li>
            <li><a href="http://www.sestka-fm.cz" target="_blank">Základní škola Frýdek-Místek, Pionýrů 400</a></li>
            <li><a href="http://www.1zsfm.cz" target="_blank">Základní škola národního umělce Petra Bezruče, Frýdek-Místek</a></li>
            </ul>            
            <p>Budeme rádi, pokud se zapojí zájemci z dalších škol.</p>
            <p>Projekt je spolufinancován <a href="http://www.esfcr.cz" target="_blank">Evropským sociálním fondem</a> a státním rozpočtem České republiky.</p>
            <br />
            <div class="alert alert-info alert-block">
                <a class="close" data-dismiss="alert" href="#">&times;</a>
                <h3>SbírkaPříkladů.eu Beta</h3>
                <p>Současná verze projektu SbírkaPříkladů.eu RC1</p>
                <p>Projekt se v současné době nachází ve stádiu testování. Některé celky nemusí fungovat zcela korektně, případně nejsou vůbec zprovozněny. Chyby již zprovozněných celků nahlaste, prosím, na adresu <a href="mailto:podpora@sbirkaprikladu.eu">podpora@sbirkaprikladu.eu</a></p>
                
            </div>
        </div>
    </div>
</div>
</asp:Content>
