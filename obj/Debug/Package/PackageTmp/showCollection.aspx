<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="showCollection.aspx.cs" Inherits="SbirkaPrikladuEU.showCollection" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/difficultyProgressBar.ascx" TagName="difficultyProgressBar" TagPrefix="uc" %>
<%@ Register Src="~/Class/printBT.ascx" TagName="printBT" TagPrefix="uc" %>
<%@ Register Src="~/Class/updatedExamplesInCollectionsAlert.ascx" TagName="updatedExamplesInCollectionsAlert" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div id="exampleHeader" class="row">
                <div id="emailLogoForPrint"></div>
                <div class="span9">
                    <div class="pgH well">
                        <div id="editBtDiv" class="btn-group fR" runat="server" visible="false" style="padding: 0 0 0 5px;">
                            <a href='/Admin/Collections/editCollection.aspx?id=<%= collectionId %>' class="btn btn-primary">Editovat</a><div class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                            <ul class="dropdown-menu">
                                <li><a href='/Admin/Collections/editCollection.aspx?id=<%= collectionId %>'><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Editovat sbírku</a></li>
                                <li><a href='/Admin/Collections/deleteCollection.aspx?id=<%= collectionId %>'><i class="icon-trash"></i>&nbsp;&nbsp;&nbsp;Smazat sbírku</a></li>
                            </ul>
                            <br /><br />
                        </div>
                        <p><strong class="fR clear">Vlastník sbírky: <%= SbirkaPrikladuEU.collectionManager.getCollectionOwnerName(collectionId) %></strong></p>
                        <div class="fR clear">
                            <div id="showSolutionBT" class="btn btn-primary" onclick="$('.solutions').collapse('show'); $(this).css('display','none'); $('#hideSolutionBT').css('display','inline');" title="Zobrazit řešení všech příkladů"><i class=" icon-eye-open icon-white"></i>&nbsp;Řešení</div>
                            <div id="hideSolutionBT" class="btn btn-primary" onclick="$('.solutions').collapse('hide'); $(this).css('display','none'); $('#showSolutionBT').css('display','inline');" title="Skrýt řešení všech příkladů"><i class=" icon-eye-close icon-white"></i>&nbsp;Řešení</div>
                            <div id="showResultBT" class="btn btn-primary" onclick="$('.results').collapse('show'); $(this).css('display','none'); $('#hideResultBT').css('display','inline');" title="Zobrazit výsledky všech příkladů"><i class=" icon-eye-open icon-white"></i>&nbsp;Výsledky</div>
                            <div id="hideResultBT" class="btn btn-primary" onclick="$('.results').collapse('hide'); $(this).css('display','none'); $('#showResultBT').css('display','inline');" title="Skrýt výsledky všech příkladů"><i class=" icon-eye-close icon-white"></i>&nbsp;Výsledky</div>
                            <uc:printBT whatIsPrinting="collection" runat="server" />
                        </div>
                        <h1 id="nameLB" runat="server"><%= SbirkaPrikladuEU.collectionManager.getCollectionName(collectionId) %></h1>
                        <a id="exampleLinkATag" href="javascript:void(0)">www.SbirkaPrikladu.eu/s/<%= collectionId %></a>
                        <br class="clear" />                
                    </div>
                </div>
            </div>    
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" />
            <div class="examplesInCollection">
                <asp:Repeater ID="examplesRPT" DataSourceID="SqlDataSource1" runat="server">
                    <ItemTemplate>
                        <div class="row">
                            <div class="span9">
                                <div class="pgH well">
                                    <a href='/p/<%# Eval("id") %>'><h2 class="label label-inverse"><%# Eval("position") %>.&nbsp;<%# Eval("name") %></h2></a><br />                            
                                    <uc:updatedExamplesInCollectionsAlert ID="updatedExamplesInCollectionsAlertUC" exampleId='<%# Eval("id") %>' collectionId='<%# Page.RouteData.Values["collectionId"].ToString() %>' runat="server" />
                                    <div class="btn-group fR">
                                        <a id='showSRBT<%# Eval("id") %>' title="Zobrazit řešení a výsledek tohoto příkladu" class="btn btn-mini " onclick="$('#solution<%# Eval("id") %>').collapse('show'); $('#result<%# Eval("id") %>').collapse('show'); $('#showSolutionBT<%# Eval("id") %>').hide(); $('#showResultBT<%# Eval("id") %>').hide(); $('#hideSolutionBT<%# Eval("id") %>').show(); $('#hideResultBT<%# Eval("id") %>').show(); $(this).css('display','none'); $('#hideSRBT<%# Eval("id") %>').css('display','inline');"><i class="icon-eye-open"></i></a>
                                        <a id='hideSRBT<%# Eval("id") %>' title="Skrýt řešení a výsledek tohoto příkladu" class="btn btn-mini hidenBT" onclick="$('#solution<%# Eval("id") %>').collapse('hide'); $('#result<%# Eval("id") %>').collapse('hide'); $('#showSolutionBT<%# Eval("id") %>').show(); $('#showResultBT<%# Eval("id") %>').show(); $('#hideSolutionBT<%# Eval("id") %>').hide(); $('#hideResultBT<%# Eval("id") %>').hide(); $(this).css('display','none'); $('#showSRBT<%# Eval("id") %>').css('display','inline'); $('#solution<%# Eval("id") %>').attr('class','solutions collapse'); $('#result<%# Eval("id") %>').attr('class','results collapse');"><i class="icon-eye-close"></i></a>
                                        <div class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <a href="#" id='showSolutionBT<%# Eval("id") %>' onclick='$("#solution<%# Eval("id") %>").collapse("show"); $(this).css("display","none"); $("#hideSolutionBT<%# Eval("id") %>").css("display","inline");'><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Zobrazit řešení tohoto příkladu</a>
                                                <a href="#" id='hideSolutionBT<%# Eval("id") %>' class=" hidenBT" onclick='$("#solution<%# Eval("id") %>").collapse("hide"); $(this).css("display","none"); $("#showSolutionBT<%# Eval("id") %>").css("display","inline");'><i class="icon-eye-close"></i>&nbsp;&nbsp;&nbsp;Skrýt řešení tohoto příkladu</a>
                                            </li>
                                            <li>
                                                <a href="#" id='showResultBT<%# Eval("id") %>' onclick='$("#result<%# Eval("id") %>").collapse("show"); $(this).css("display","none"); $("#hideResultBT<%# Eval("id") %>").css("display","inline");'><i class="icon-eye-open"></i>&nbsp;&nbsp;&nbsp;Zobrazit výsledek tohoto příkladu</a>
                                                <a href="#" id='hideResultBT<%# Eval("id") %>' class=" hidenBT" onclick='$("#result<%# Eval("id") %>").collapse("hide"); $(this).css("display","none"); $("#showResultBT<%# Eval("id") %>").css("display","inline");'><i class="icon-eye-close"></i>&nbsp;&nbsp;&nbsp;Skrýt výsledek tohoto příkladu</a>
                                            </li>
                                        </ul>
                                    </div>
                            
                                    <div class="enters">
                                        <h3 class="label fL">Zadání:</h3><br class="clear" />
                                        <%# Eval("enter") %>
                                    </div>
                                    <div id='solution<%# Eval("id") %>' class="solutions collapse">
                                        <hr />
                                        <h3 class="label fL">Řešení:</h3><br class="clear" />
                                        <%# Eval("solution") %>
                                    </div>
                                    <div id='result<%# Eval("id") %>' class="results collapse">
                                        <hr />
                                        <h3 class="label fL">Výsledek:</h3><br class="clear" />
                                        <%# Eval("result") %>
                                    </div>

                                    <div class="examplesPadding"></div>
                                </div>
                            </div>            
                        </div>                        
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>