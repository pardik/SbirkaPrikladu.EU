<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="procenta.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.procenta" %>
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
                  <h1>Procenta <small class="pull-right">Generátor příkladů</small></h1>
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