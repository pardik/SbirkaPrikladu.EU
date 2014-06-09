<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="soustava-tri-rovnic.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Linearni_funkce_a_rovnice.soustava_tri_rovnic" %>
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
                  <h1>Soustava tří rovnic <small class="pull-right">Generátor příkladů</small></h1>
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