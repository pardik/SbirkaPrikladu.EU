<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="kraceni.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.kraceni" %>
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
                  <h1>Krácení <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <object class="geogebraApplet" type="application/x-java-applet" width="670" height="500">
                    <param name="code" value="geogebra.GeoGebraApplet" />
                    <param name="archive" value="geogebra.jar" />
                    <param name="codebase" value="http://www.geogebra.org/webstart/3.2/unsigned/" />
                    <param name="ggbBase64" value="UEsDBBQACAgIAFiAPkIAAAAAAAAAAAAAAAAMAAAAZ2VvZ2VicmEueG1szVjdbutEEL7mPMXKF4gfncSOk/6IuEfQI1BFoYiUI3SAi7U9dpba3rC7TpMi7nkRJC54CiRehCdhdtf/6a/aI5pcOJ4Z73wz38zsOvNXmzwjaxCS8SJwvJHrECgiHrMiDZxSJS8PnFdHL+Yp8BRCQUnCRU5V4PijiaPlJTt68d5cLvkloZkxecPgMnASmklwiFwJoLFcAqienJYbljEqtmfhzxAp2SrsIifFqkQvSpQoi/L4lMn6dmwcrjKmXrM1i0GQjEeBszdD6PjrDQjFIpoFztS1kkngTAZKFPlau+SCXfFCafN28YyGkGECFmqbASFrrfWtKkFjQiS7AkzWRMvmY5ODOZRRxmJGCx2ngYhGhFyyWC3R1p8doDtg6RLjmB0e2OUizkW82EoFOdm8BcE1VH80m3a+ew7ZWpXvH472J53vDBOM0SCW6Ww07T2FD92oMq5hvQClMEpJ6AZaAlLB4t7NifyMZ61oxVmhjulKlcLUiF+JTLICB5MqdJCfFmkGlcxDCpcQXYR8s7CZ8+3S59uVecQACtNjnnFBBOZgOkWD6hraq7HRSBsr19i4xqJaQy/a6L3DibEw19BeLb+ssNCqyL06as+t3TBJtAAX16XdBG8qI3AcUhZMndY3WFIXbaj6ga/LPMSe6hZVs6b3VGvOx4Oam1+AKCCzhVUgtyUvpS1f68sAiSFiOd5aRZUSqun6DgFYaQypgBq47UibMKN1u8W7I5aKCqQffSicKVbVQq4haoQSxZExUkzpSPVcUNiTgXP+pUNiqrRM91YGOWDjKVMvRZmDYFGTOepot+inrIB47qhqVzOXuBkxw3y3zKD+hprCabRaUvw18urJsMV5043WrPYVj2vXld/MDKacFQYNMpjTTQWM0FDyrFSwiDDHxSmPTKLqYVcPDNfVsxgfmrm+/rXVA8fIEraBth9vGGFNiaslVlIBUmquqwzWZd6QhANopcN0da2tAOIKAPmIpO1DZIXxm6bvlKClZoekkPMMaNGkOxyS1KnIHks2CzskYbnEzGJF67PK+O+/2P05dG/l8CxJJCid8Ml+lW3vWorr6q8mWk1HByoOx6byC4r9sGZqmK2I5zktYlLQHLP1Lf7kuUkR0zsfoS7i0GRTTxe4jbFUtSqyy1WL3Nkh0TD50zoZ9679p8MePwx7PMQ++x+xw8OwwxD7/hNiP5EnhYIUxAB+RMYk3kGe3I582K7Jfdu1P1Q7Vo/vyEHL9WbNBs+VUp9Za884plCIgZB/f/+TJA4Z3xlj+rxj7LP9xfHrIc+2SHepXj6sSJc72+ejivT2nLN3tA2ET78NeP7eE+4DVxe4RwvEtqY7e8FuNSvYKL+q6Pd/Kbn6hPyYCBr9Wt18TD6IcG8GbPXlh3hnxb911PE16sBer+sN7dDpe7+dkg5vN3GSvqMmwSaQp/Qcvu+fLauXM4nFnbTvn+Z9A4mU9Vm6PaN+o19biKb65RTfq7zDzscwvzfypnhmumpa4m7SvIq0z5EsnZJzlP1gJvJPDQ8PYMF7LAvXHI8ms9kzZcEfHeARt/1Maha8vb70IYxMem309kLQf/5QUHFwDwomz7kR7p/r6186TN59z+R5ujPKx913NPNPR/Uv0NF/UEsHCBwZvizFBAAANxIAAFBLAQIUABQACAgIAFiAPkIcGb4sxQQAADcSAAAMAAAAAAAAAAAAAAAAAAAAAABnZW9nZWJyYS54bWxQSwUGAAAAAAEAAQA6AAAA/wQAAAAA"/>
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