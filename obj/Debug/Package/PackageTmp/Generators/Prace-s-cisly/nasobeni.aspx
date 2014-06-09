<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="nasobeni.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.nasobeni" %>
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
                  <h1>Násobení <small class="pull-right">Generátor příkladů</small></h1>
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