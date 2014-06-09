<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="smisena-cisla-2.aspx.cs" Inherits="SbirkaPrikladuEU.Generators.Prace_s_cisly.smisena_cisla_2" %>
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
                  <h1>Smíšená čísla 2 <small class="pull-right">Generátor příkladů</small></h1>
                </div>
                <object class="geogebraApplet" type="application/x-java-applet" width="670" height="500">
                    <param name="code" value="geogebra.GeoGebraApplet" />
                    <param name="archive" value="geogebra.jar" />
                    <param name="codebase" value="http://www.geogebra.org/webstart/3.2/unsigned/" />
                    <param name="ggbBase64" value="UEsDBBQACAgIAB2CPkIAAAAAAAAAAAAAAAAMAAAAZ2VvZ2VicmEueG1szVjbjtxEEH0mX9HyA+IiZnyZmd2I8UYQhBSxsIhZIhTEQ9suezpru013e3ZmvwAe+AaUN5DIT7DkR/IlVF88191kNruEPNldXe6uOudUdc+MH8yrksxASMbr2At6vkegTnnG6iL2WpV/cug9OLo3LoAXkAhKci4qqmIv6oWetrfs6N57Yznl54SWxuUxg/PYy2kpwSOyEUAzOQVQG3bazlnJqFicJE8hVXI1YRd5VDct7qJEi7a0yo6Z7IZ9s2FTMvUFm7EMBCl5GnujIYaOb49BKJbSMvYGvrWEsRduTaIp0rNTLtgFr5V2Xy1e0gRKBGCiFiUQMtOzkZ3K0ZkQyS4AwQq1bdw3GIyhTUuWMVrrPE2I6ETIOcvUFH2j4SFuB6yYYh7D+4d2uZRzkU0WUkFF5k9AcIw6GGgSFnYUBUM9khgz7jj0zdT6yCwDswkohRFLQuewArMQLNsYPJKf83Jlajir1UPaqFYYviNnMonHHu4ldMCf1UUJzhYgHVNIzxI+n1gUIrv06aIxn5iAkuIhL7kgAqEfDNDBPRP7ND460qWXb3x84+HW0Isu54P7ofEwz8Q+LVestqG5zIMu68DvtmGSaIOGEWW6TN6wHHseaWumjrsByuNslar+4Ju2SrA+1gWyXDO4qzXH/S39jM9A1FBakdTIbctbaaVo9zKBZJCyCod2wkFCNV3fYwDWmkEhoAvcVpcFzMz660LcMUtFBdKPeyjsD3ZqFXIXoo5Qojk1ToopnamucYX1FXunX3kko0rbdJ2UUAEWkTJ6qdsKBEuXyFFPb4v7tC6QwO+50jM9hpt2sY33ihmcv0ZT2FmaKcW3XtBV+QJ7x3q2ZrWvedZt7fYtTZOpWG2iQQYrOneBEZpIXrYKJiliXB/z1ADVNa6u+H1Tt/jRKDw0FRx7ByP9krM5rMrxmm60VLiaopBqkFJT7QDsVL7kCHtJo7P0tdQagMztTz4i+eoj0mD6pubXFGiZ2eEo4bwEWi/RTrY5WhPkBkkWhB2OUC0Zs7Gi94lz/vuv6f4U+q+k8CTPJSiNdzQwYAf+8EqGO/G7htbRsRYq9sal8GuK5TBjahutlFcVrTNS0wrR+g5feWUgYvoQI9R35yoNtL5tjq3qplK7nFvktQWSboN/0IGxt/TfNPZ0J/bsZrFn27GHt4od5ni5kPri0m2AakMjRkpe/vo7yTzSf62Y4Y3EvOZ0e7lu6fHVKeYuRSAvf/mDJPukmO+b4mZTfVs53q58iptJsNjGIrpjCSqYq8BxVJCPyZeCmmPxFO0/ZqRP0p+u4kx/5m2u8T/Sg9jLY3oKP2ye+O4+8K2+IhLTXnuHpr9G+lS8sDzd6CiZ/kdHSXL3R0kw9N1ZMrqDs+TiDM95gbHN6M55crWoIieqDUF9UOCxnqLMsg+NtPDt/Z9brj6N7WMvqUW7Uruu2V2Hd/62hWh+h0ks7Xz1U9P8HBnhS3fVtjejK29oxN7GDKODg/0YCB0DpjyXSN8A6PC2QF9xQwqHw3cf6MB3SI/2Q3rgkLbYPqENe/FMAXlKzziR1eXzF8+gvvyT/PPb5XNZ8p6jYA8GBu+y1O8E6sh15HAb6f76jzTzt4X7S+foX1BLBwh32FvsugQAAAQSAABQSwECFAAUAAgICAAdgj5Cd9hb7LoEAAAEEgAADAAAAAAAAAAAAAAAAAAAAAAAZ2VvZ2VicmEueG1sUEsFBgAAAAABAAEAOgAAAPQEAAAAAA=="/>
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