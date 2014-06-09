<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="rozsirovani.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.rozsirovani" %>
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
                  <h1>Rozšiřování <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <object class="geogebraApplet" type="application/x-java-applet" width="670" height="500">
                    <param name="code" value="geogebra.GeoGebraApplet" />
                    <param name="archive" value="geogebra.jar" />
                    <param name="codebase" value="http://www.geogebra.org/webstart/3.2/unsigned/" />
                    <param name="ggbBase64" value="UEsDBBQACAgIACSBPkIAAAAAAAAAAAAAAAAMAAAAZ2VvZ2VicmEueG1szVjNcuNEED6zTzGlA8VPrSNZtpMUVrYgW0ulCITahC2Kn8NIaslDJI2ZGTm2Ke5ceACO3DjASwD7IjwJPTP6s5xkk1qnKvZBUnerp3++/mbs6bNlnpEFCMl4ETjewHUIFBGPWZEGTqmSpwfOs6Mn0xR4CqGgJOEipypw/MHQ0fKSHT15Zypn/IrQzJi8YnAVOAnNJDhEzgXQWM4A1IaclkuWMSpWZ+EPECnZKqyTk2Je4ipKlCiL8viUyfpxzyw4z5h6zhYsBkEyHgXOZIyh490rEIpFNAuckWslw8AZ9pQo8rV2xgVb80Jp89Z5RkPIsADnapUBIQut9a0qQWNCJFsDFmuoZdM9U4MplFHGYkYLnacJEY0IuWKxmqGtPz7A5YClM8xjfHhg3UWci/h8JRXkZPkNCK5D9QfjUec7ccjKqnz/cLA/7HzHWGDMBmMZjQejjbfwpRtVZmlYnINSmKUkdAltA1LB4o2HE/kJz1rRnLNCHdO5KoXBiF+JTLECB4sqdJIfF2kGlczDFs4gugz58txWzreuL1Zz84oJKEyPecYFEViD0QgNqmtor8ZGR9pYucbGNRaVD+200XuHQ2NhrqG92v6ywoZWZe7VWXtuvQyTRAvQuYZ2k7xBRuA4pCyYOq0fEFKXbar6hS/KPMSZ6oKq8entyud0r4e56SWIAjILrAJ7W/JSWvjatUwgMUQsx0erqEpCdbu+wgCsNIZUQB24nUhbMKN1u+DdEktFBbYf11DIKVbVhlyHqCOUKI6MkWJKZ6p5QeFMBs7FZw6JqdIyPVsZ5ICDpwxeijIHwaKmctTRy+I6ZRWI5w6qcTW8xA3F9Ovddgb1N2AK2Wg+o3g38GpmWCHfdLM13j7ncb10tW5miClnhYkGO5jTZRUYoaHkWangPMIaF6c8MoWqya4mDNfVXIwvjV1f36004RhZwpbQzuMNFNZAXM0QSQVIqXtdVbCGedMkJKC5TtPVWJsDxFUA5AOSti+ROeZvhr4DQduarSaFnGdAi6bcYb9JHURudMlWYatJCJeY2VjR+qwy/vtPdvceurf28CxJJChd8OF+VW3v2hbX6K8YrW5HJ1Qkxwb5BcV5WDDVr1bE85wWMSlojtV6ibc8NyVieucj1MU4dLOppwFucyxVrYqsu8rJGyck6hd/UhfjztjfXezx/WKP+7EfvlXssMQTidSnnQZjsFQIe1QEzgtBDSFdoOzbiOyR+HvyIXn3x5KrjwJ7ccjeVszahbPp73Zcd8B/E7DTXQF7C7lMntIL+HqTmaujjcTaJ+3pzezWeACR9U7UMvyXetMnel6ejgY+UlP78cz8TAbepCN0kX3W9oS5UzjB/eAEfTiNHgBOwwpOFjEv+fr17+z1bwrIOuM5XJJ/f/3nL4k+KmQhxKCB2eAeMBs+ZpjdHU/Xb4gGW77F0ugNHHQiTwoFKYgebswIb0EmuR0y/a0ruevWtXnA6FjtvLq3QzCt4BeS/375gyTXQamfY/q4c9zs9qfHz/t9tuyw3erZ/dhh1i+D/wDs4G+wA/kuwU3np4YJ3ovw0AWI29n7DSf83FHH16jvQRn+21LGNQeu4Xj8SHcm/Ck97O5M7n69NY1u3I5uHxT2QOfYcPfnWM+f7PAgu77ELgiMbUG3DrN73R9z5i+R6u+io/8BUEsHCChReKnjBAAAYBIAAFBLAQIUABQACAgIACSBPkIoUXip4wQAAGASAAAMAAAAAAAAAAAAAAAAAAAAAABnZW9nZWJyYS54bWxQSwUGAAAAAAEAAQA6AAAAHQUAAAAA"/>
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