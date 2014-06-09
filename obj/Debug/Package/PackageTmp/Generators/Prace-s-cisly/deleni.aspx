<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="deleni.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.deleni" %>
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
                  <h1>Dělení <small class="pull-right">Generátor příkladů</small></h1>
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