<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="najdi-funkci.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Linearni_funkce_a_rovnice.najdi_funkci" %>
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
                  <h1>Najdi funkci <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <object class="geogebraApplet" type="application/x-java-applet" width="670" height="500">
                    <param name="code" value="geogebra.GeoGebraApplet" />
                    <param name="archive" value="geogebra.jar" />
                    <param name="codebase" value="http://www.geogebra.org/webstart/3.2/unsigned/" />
                    <param name="ggbBase64" value="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"/>
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