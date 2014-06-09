<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="obor-hodnot.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Linearni_funkce_a_rovnice.obor_hodnot" %>
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
                  <h1>Obor hodnot <small class="pull-right">Generátor příkladů</small></h1>
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