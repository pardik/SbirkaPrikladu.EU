<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="smisena-cisla-1.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.smisena_cisla_1" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" tabTosHowNr="1" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
    <div class="row">        
        <div class="span9">
            <div class="pgH well geogebraAppletContainer">
                <div class="page-header">
                  <h1>Smíšená čísla 1 <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <object class="geogebraApplet" type="application/x-java-applet" width="670" height="500">
                    <param name="code" value="geogebra.GeoGebraApplet" />
                    <param name="archive" value="geogebra.jar" />
                    <param name="codebase" value="http://www.geogebra.org/webstart/3.2/unsigned/" />
                    <param name="ggbBase64" value="UEsDBBQACAgIAPqBPkIAAAAAAAAAAAAAAAAMAAAAZ2VvZ2VicmEueG1szVjNjuNEED6zT9HyAfEjEv/lT8SzgkVIKwYGMcMKLeLQtstOb2y3125nknkCeArEjQOvwAXEi+yTUP1jJ3FmZjM7w7KHyHZVubvqq6+qy5k/XucZWUFVM14EljOwLQJFxGNWpIHViOSTqfX45NE8BZ5CWFGS8CqnIrC8gWtJecNOHr03rxf8ktBMmTxjcBlYCc1qsEhdVkDjegEg9uS0WbOM0WpzFr6ASNRbhV7kaVE2uIuoGpRFeXzK6vZxqDYsMya+YCsWQ0UyHgXWeISu490zqASLaBZYvq0lbmC5PSWKPKld8Ipd8UJI8+3iGQ0hQwDOxSYDQlZS62lVgsaE1OwKECxXyuZDhcEcmihjMaOFjFO5iEaEXLJYLNDWG01xO2DpAuMYzaZ6uYjzKj7f1AJysn4OFUevHW/gOeNp9xtZZKNVnuMP/KntzPTPRXgxFvTEnw1mzsTvfqjZ3KhSG8PqHITAGGtC17CFP61YvPfwtP6cZ1tRyVkhntBSNJViiGdECqrAQkgrGeJnRZqBkTmYwAVEy5CvzzVunl76YlOqV5RDYfqEZ7wiFSbL99HAXEN9VTbS087KVja2sjBryEU7vSNRSM011FedXVZo10zkThu1Y7fbsJpIAS4uid0Fr3gRWBZpCiZO2wck1HIbqnzhmyYPsaJ2KdWt6TzUmvNhj3HzJVQFZJpWBea24U2tyav3Uo7EELEcH7XCQEJlur5HB7Q0hrSC1nFdjxowpbV3qXsgrgWtMP24h8COolVbl1sXpYc1iiNlJJiQkcquILAiA+viK4vEVEiZrKwMcsCyE4ovRZNDxaIOOWrJbXGfxjji2APH+CK7ElcNpo/3NjOov4FT2IvKBcW7dr2MbrDb7EarVvuax+3WZt9MtaWcFcYbktO1ukXm07DmWSPgPEKMi1MeKaDaVte2C9uWnRhfGrtTebcJrMlY3iRsDdtyvKF/dQwXCyRSAXUtU20AbFne5Qi7TymjtCXVSoDY7E8+Isn2JVJi+KrmdxioM3OQo5DzDGjRoR32c7RDyL0kaRAOcoRsiZn2Fa3PjPFffyyOT6F9awrPkqQGIfF2XQW2Y4+uzXBLftPQ2nTsuIq9sSN+QbEcVkz00Yp4ntMiJgXNEa3v8JbnCiImjz1CbXMSU0fyW8fYiFYV6eXMIq8tkKgPvteCcTT139T36MD3+G6+x33f3Xv5DmscR2o56rQbINtQiJ6SV7/8SmKLDF9LZngjMu8Y3Z+uPT7eHmJiQgTy6uffSXhMiMmxIe431bcV4/3KJ70bBdM+FrMHpqCAtXBMjlLyMfmyoupYvED5jzEZkuin63ImX7P21/gf04PY16f0An7YP/HNPPCtHBGJbK/eYKr6qydPxSudp6MQcg1CKlJE6f2XDRefkkBfjwLIPQTophK96cBJ3jZ86nujRkIm208qNUSP8aYdEPV5fu1coUAfTRTm/vj2QtolXq+cPkhxGIgQ9vhDSciDmpLwerfX1UE6vPum45rT3x2N3v10OLbJx+RuU9TiP5qiwoefohx3YsaoyQOMUVdLhL1C31b0YJS6vlv4plvo7vCcluyf3wSQF3TJyQuICx430eLvP8lVxnNYDkwTOaKH+O9yD3kQdrq+ypw76yM93P1mU/97mP+ETv4FUEsHCNNlfXjXBAAARRIAAFBLAQIUABQACAgIAPqBPkLTZX141wQAAEUSAAAMAAAAAAAAAAAAAAAAAAAAAABnZW9nZWJyYS54bWxQSwUGAAAAAAEAAQA6AAAAEQUAAAAA"/>
	                <param name="image" value="http://www.geogebra.org/webstart/loading.gif" />
	                <param name="boxborder" value="false"  />
	                <param name="centerimage" value="true"  />
	                <param name="java_arguments" value="-Xmx512m -Djnlp.packEnabled=true" />
	                <param name="cache_archive" value="geogebra.jar, geogebra_main.jar, geogebra_gui.jar, geogebra_cas.jar, geogebra_export.jar, geogebra_properties.jar" />
	                <param name="cache_version" value="3.2.47.0, 3.2.47.0, 3.2.47.0, 3.2.47.0, 3.2.47.0, 3.2.47.0" />
	                <param name="framePossible" value="false" />
	                <param name="showResetIcon" value="false" />
	                <param name="showAnimationButton" value="false" />
	                <param name="enableRightClick" value="false" />
	                <param name="errorDialogsActive" value="false" />
	                <param name="enableLabelDrags" value="false" />
	                <param name="showMenuBar" value="false" />
	                <param name="showToolBar" value="false" />
	                <param name="showToolBarHelp" value="false" />
	                <param name="showAlgebraInput" value="false" />
	                <param name="allowRescaling" value="false" />
                    Pro spuštění generátoru potřebujete Javu. Můžete si jí nainstalovat z <a href="http://www.java.com" target="_blank">www.java.com</a>
                </object>
            </div>
        </div>
    </div>
    <script>
        $('.geogebraApplet').width($('.geogebraAppletContainer').width() - 1);
    </script>
</asp:Content>