<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="pruseciky.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Linearni_funkce_a_rovnice.pruseciky" %>
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
                  <h1>Průsečíky <small class="pull-right">Generátor příkladů</small></h1>
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