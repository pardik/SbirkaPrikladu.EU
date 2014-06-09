<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="sestroj-graf-2.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Linearni_funkce_a_rovnice.sestroj_graf_2" %>
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
                  <h1>Sestroj graf 2 <small class="pull-right">Generátor příkladů</small></h1>
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