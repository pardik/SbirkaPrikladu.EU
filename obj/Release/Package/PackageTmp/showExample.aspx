<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="showExample.aspx.cs" Inherits="SbirkaPrikladuEU.showExample" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/difficultyProgressBar.ascx" TagName="difficultyProgressBar" TagPrefix="uc" %>
<%@ Register Src="~/Class/addExampleToCollectionBT.ascx" TagName="addExampleToCollectionBT" TagPrefix="uc" %>
<%@ Register Src="~/Class/printBT.ascx" TagName="printBT" TagPrefix="uc" %>
<%@ Register Src="~/Class/reportExampleBT.ascx" TagName="reportExampleBT" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">    
<div id="exampleHeader" class="row">
    <div id="emailLogoForPrint"></div>
    <div class="span9">
        <div class="pgH well">            
            <div class="fR">
                &nbsp;<uc:printBT whatIsPrinting="example" runat="server" /><uc:reportExampleBT runat="server" />
            </div>
            <div id="editBtDiv" class="btn-group fR" runat="server" visible="false" style="padding: 0 0 0 5px;">
                <a href='/Admin/Examples/editExample.aspx?id=<%= exampleId %>' class="btn btn-primary">Editovat</a><div class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                <ul class="dropdown-menu">
                    <li><a href='/Admin/Examples/editExample.aspx?id=<%= exampleId %>'><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat příklad</a></li>
                    <li><a href='/Admin/Examples/deleteExample.aspx?id=<%= exampleId %>'><i class="icon-trash"></i>&nbsp;&nbsp;&nbsp;Smazat příklad</a></li>
                </ul>                
            </div>
            <div class="fR"><uc:addExampleToCollectionBT ID="addExampleToCollectionUC" runat="server" /></div>
            <h1 id="nameLB" runat="server"></h1><br />            
            <table class="table">                
                <tr>
                    <td>
                        <strong>Příklad č.:&nbsp;</strong>
                        <asp:Label ID="exampleNrLB" runat="server" /><br />
                        <a id="exampleLinkATag" href="javascript:void(0)">www.SbirkaPrikladu.eu/p/<%= exampleId.ToString() %></a><br /><br />
                        <strong>Zařazen do skupin:</strong><br /><span id="exampleGroupsTag" runat="server"></span>
                    </td>
                    <td>
                        <strong>Stupeň školy:</strong><br />
                        <asp:Label ID="schoolGradeLB" runat="server" /><br /><br />
                        <strong>Autor:</strong><br />
                        <asp:Label ID="exampleAuthorLB" runat="server" />
                    </td>
                    <td>
                        <div class="noPrint">
                            <strong>Obtížnost dle autora:</strong><br />
                            <uc:difficultyProgressBar ID="difficultyProgressBarUC" runat="server" />                        
                            <strong>Obliba dle uživatelů:</strong><br class="clear" />
                            <uc:ratingStars ID="ratingStarsUC" runat="server" />
                        </div>
                    </td>                    
                </tr>
            </table>
        </div>
    </div>    
</div>

<div class="row enter">
    <div class="span9">
        <div class="pgH well">
            <ul class="pager fR" data-toggle="collapse" data-target="#<%= enterPN.ClientID %>"><li><a id="enterZ" class="span2" style="display:none;" onclick="$('#enterZ').hide();$('#enterS').show();">Zobrazit zadání</a><a id="enterS" class="span2" onclick="$('#enterS').hide();$('#enterZ').show();">Skrýt zadání</a></li></ul>
            <h3>Zadání příkladu</h3><br />
            <div id="enterPN" class="collapse in" runat="server" />
        </div>
    </div>
</div>
<div class="row solution noPrint">
    <div id="solutionDiv" class="span9"  runat="server">
        <div class="pgH well">        
            <ul class="pager fR" data-toggle="collapse" data-target="#mainPanel_solutionPN"><li><a id="solutionZ" class="span2" onclick="$('#solutionZ').hide();$('#solutionS').show();$('.solution').removeClass('noPrint');">Zobrazit řešení</a><a id="solutionS" class="span2" style="display:none;" onclick="$('#solutionS').hide();$('#solutionZ').show();$('.solution').addClass('noPrint');">Skrýt řešení</a></li></ul>
            <h3>Řešení příkladu</h3><br />
            <div id="solutionPN" class="collapse" runat="server" />
        </div>
    </div>
</div>
<div class="row result noPrint">
    <div class="span9">
        <div class="pgH well">
            <ul class="pager fR" data-toggle="collapse" data-target="#<%= resultPN.ClientID %>"><li><a id="resultZ" class="span2" onclick="$('#resultZ').hide();$('#resultS').show();$('.result').removeClass('noPrint');">Zobrazit výsledek</a><a id="resultS" class="span2" style="display:none;" onclick="$('#resultS').hide();$('#resultZ').show();$('.result').addClass('noPrint');">Skrýt výsledek</a></li></ul>
            <h3>Výsledek příkladu</h3><br />
            <div id="resultPN" class="collapse" runat="server" />
        </div>
    </div>
</div>        
    <script type="text/javascript">
        var solutionStatus = "hidden";
        var resultStatus = "hidden";
        $('#solutionPN').on('hidden', function () { solutionStatus = "hidden"; });
        $('#solutionPN').on('shown', function () { solutionStatus = "shown"; });
        $('#resultPN').on('hidden', function () { resultStatus = "hidden"; });
        $('#resultPN').on('shown', function () { resultStatus = "shown"; });
    </script>    
</asp:Content>
