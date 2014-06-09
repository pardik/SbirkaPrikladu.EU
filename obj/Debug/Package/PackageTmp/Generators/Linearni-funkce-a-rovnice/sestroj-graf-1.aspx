<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="sestroj-graf-1.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Linearni_funkce_a_rovnice.sestroj_graf_1" %>
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
                  <h1>Sestroj graf 1 <small class="pull-right">Generátor příkladů</small></h1>
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