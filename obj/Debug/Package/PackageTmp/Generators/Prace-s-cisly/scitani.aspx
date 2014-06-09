<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="scitani.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.scitani" %>
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
                  <h1>Sčítání <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <object class="geogebraApplet" type="application/x-java-applet" width="670" height="500">
                    <param name="code" value="geogebra.GeoGebraApplet" />
                    <param name="archive" value="geogebra.jar" />
                    <param name="codebase" value="http://www.geogebra.org/webstart/3.2/unsigned/" />
                    <param name="ggbBase64" value="UEsDBBQACAgIAGCBPkIAAAAAAAAAAAAAAAAMAAAAZ2VvZ2VicmEueG1szVhLcuM2EF1nToHiIjWTKcv8iLJdI3kqmVSqXHHiVORMpfJZQGSLQkwSCgDKkk+QTU6QA2Qzp5iak+QkaQD86WPLGstOvDDJRhN4/fp1A1T/9TxLyQyEZDwfOF7HdQjkEY9ZngycQo0Pjp3Xp8/6CfAERoKSMRcZVQMn6PiOthfs9NknfTnh14SmxuUtg+uBM6apBIfIqQAaywmAWrLTYs5SRsXiYvQbREo2A3aSs3xa4CpKFGiLsvicyerx0Cw4TZn6ks1YDIKkPBo4vRCh491bEIpFNB04Xdda/IHjrwyiKdCjEy7YDc+Vdm8mT+kIUiRgqBYpEDLTo4EdGqMzIZLdAJLla1v/0HDQhyJKWcxoruM0ENGJkGsWqwn6BuExLgcsmWAc4cmxnS7iXMTDhVSQkflPIDhC9UKdhIV9CuyTRMy4YuiaofaTmQZmQ1AKEUtC59CQmQgWLz2cyS942pimnOXqDZ2qQph8B6XJBD5wcC2hAX+eJymUNg/TMYHoasTnQ8tCYKe+XEzNKwbQKHnDUy6IwHi6XXQoryN7NT4aae3lGh/XeJRz6Enrce/ENx7mOrJXmyuWW2hl5F4VtedWyzBJtEHTiDKtgzdZHjgOKXKmzqsHlMdVE6p+4dsiG2F9tAVSz+nta87+4Yp++lcgckitSHLMbcELaaVo1zJAYohYho92oKSE6nT9gACsNYZEQAXcVpclzIy6bSGumaWiAtOPayjsD3aogVxB1AglmiPjpJjSkeoaV1hfA+fya4fEVGmbrpMUMsAiUkYveZGBYFHNHHX0srhOUQLx3I53VILRTYabfrFKeJMaHL9FVNhaphOKdx2vKvMFNo92uGa2b3hcrV2um5ouk7HcwnFIRufmFqVPR5KnhYJhhCTn5zwyTFWdq6p+1xQuvhQGR6aEq1oeszk09XhLO6olriaopByk1LkuGaxkXicJm8lUR+lqrU0B4nJ98hmJmpfIFMM3Rd+SoE3NWpJGnKdA85rtaDVJLUUuJcmSsJYjlEvMLFb0viid379j90+he2cKL8ZjCUrzHXiGbM8NN2a4Un/Z0ap0tKBic6yVn1OshxlTq2xFPMtoHpOcZsjW93jLM0MR07sYoW65sVJPC9zGWKhqKLbTlZNsrZB4lfyTiox7S/+jsZOXJKxXayKA3SKAtRr3HjsEvwnhgAQbQhjvFsJ4NYTg6ZKwhj3ZDXuyir33H2Kf7IZ9sord3yP2rwQ1O9glzNVKBDE5JM/H2EGTF2shKHT37g5DuzR90Phv2dBaHfXh7XCt3zF5Ti/hx+X9vNztv9MHQKJ7p9vpHZvueYAJxMPbjc3kx3IIFYeTzRz6O3Lob+Nwt0PBo1DodQL8Cmn9BTWhvQcT2hIlNuZt9HZ3pLe7Tu9O2zkj//zxN3n+/t2ZPMsVJCB+vhXwry/W8+SH4aNmynzJSewu4+Zj1XzQYGJkdVi3R6uNRzybX99WSDfc7QTFHukEFe3/BOV5x+URqreHI9TNFdIuENuMrh2jYD4VeLbVvi0dYsXgQNk2UTaf/l5w9Yr88grv8V/5+JKYllCPD+zFIYfblR48UOl7pP1Jxas/yDdrd2MiwjIRltkhfPhTffhLQUn0PXgOt/DcqoGnJ3ovjAZHhlH/5H6M9kpG2z3+jiZZi3sHbfceyrlt4/fp4f/nFr6yLeP+e9Rb2pd9+03e8Zes3m179GH7Fw/zG2D5++jpv1BLBwjEZMYECwUAAFEVAABQSwECFAAUAAgICABggT5CxGTGBAsFAABRFQAADAAAAAAAAAAAAAAAAAAAAAAAZ2VvZ2VicmEueG1sUEsFBgAAAAABAAEAOgAAAEUFAAAAAA=="/>
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