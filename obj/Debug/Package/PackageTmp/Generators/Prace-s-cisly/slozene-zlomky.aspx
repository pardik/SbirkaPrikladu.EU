<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="slozene-zlomky.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.slozene_zlomky" %>
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
                  <h1>Složené zlomky <small class="pull-right">Generátor příkladů</small></h1>
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