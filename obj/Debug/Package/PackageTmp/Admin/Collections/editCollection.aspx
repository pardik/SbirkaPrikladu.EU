<%@ Page Title="" Language="C#" MasterPageFile="~/withSideBar.Master" AutoEventWireup="true" CodeBehind="editCollection.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Collections.editCollection" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Class/groupMenu.ascx" TagName="groupMenu" TagPrefix="uc" %>
<%@ Register Src="~/Class/ratingStars.ascx" TagName="ratingStars" TagPrefix="uc" %>
<%@ Register Src="~/Class/difficultyProgressBar.ascx" TagName="difficultyProgressBar" TagPrefix="uc" %>
<%@ Register Src="~/Class/printBT.ascx" TagName="printBT" TagPrefix="uc" %>
<%@ Register Src="~/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<%@ Register Src="~/Class/updatedExamplesInCollectionsAlert.ascx" TagName="updatedExamplesInCollectionsAlert" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="sidePanel" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <uc:groupMenu ID="groupMenuUC" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:UpdatePanel ID="contentUpdatePanel" runat="server">
        <ContentTemplate>
        
            <div class="row">
                <div class="span9">
                    <div class="pgH well printHead">                          
                        <div class="fR clear">
                            <div id="showSolutionBT" class="btn btn-primary" onclick="$('.solutions').collapse('show'); $(this).css('display','none'); $('#hideSolutionBT').css('display','inline');" title="Zobrazit řešení všech příkladů"><i class=" icon-eye-open icon-white"></i>&nbsp;Řešení</div>
                            <div id="hideSolutionBT" class="btn btn-primary" onclick="$('.solutions').collapse('hide'); $(this).css('display','none'); $('#showSolutionBT').css('display','inline');" title="Skrýt řešení všech příkladů"><i class=" icon-eye-close icon-white"></i>&nbsp;Řešení</div>
                            <div id="showResultBT" class="btn btn-primary" onclick="$('.results').collapse('show'); $(this).css('display','none'); $('#hideResultBT').css('display','inline');" title="Zobrazit výsledky všech příkladů"><i class=" icon-eye-open icon-white"></i>&nbsp;Výsledky</div>
                            <div id="hideResultBT" class="btn btn-primary" onclick="$('.results').collapse('hide'); $(this).css('display','none'); $('#showResultBT').css('display','inline');" title="Skrýt výsledky všech příkladů"><i class=" icon-eye-close icon-white"></i>&nbsp;Výsledky</div>
                        </div>                
                        <p><strong class="fR clear"><br />Vlastník sbírky: <%= SbirkaPrikladuEU.collectionManager.getCollectionOwnerName(collectionId) %></strong></p>
                        <asp:TextBox ID="nameTB" runat="server" CssClass="editableH1" Width="600" AutoPostBack="true" OnTextChanged="changeCollectionName" />
                        <a href="#" id="helpA01" style="width: 0; height: 0; margin: 15px -100px;" runat="server" ClientIDMode="Static" data-content="Můžete jednoduše změnit název sbírky zde?" data-original-title="Víte, že?" class="helpWizzArea"></a>
                        <br class="clear" />                
                    </div>
                </div>
            </div>    
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" />
            <div class="examplesInCollection">
                <a href="#" id="helpA02" style="width: 0; height: 0; margin: 35px 36px;" runat="server" ClientIDMode="Static" data-content="Změnou čísla v tomto poli změníte pořadí příkladu ve sbírce?" data-original-title="a víte, že?" class="helpWizzArea"></a>
                <asp:Repeater ID="examplesRPT" DataSourceID="SqlDataSource1" runat="server" OnItemCreated="examplesRepeaterItemCreated">
                    <ItemTemplate>
                        <div class="row">
                            <div class="span9">
                                <div class="pgH well">                            
                                    <h2 class="label label-inverse">
                                        <uc:mpTextBox ID="positionTB" CssClass="collPossTB fL" Text='<%# Eval("position") %>' dataKey='<%# Eval("id") %>' autoPostBack="true" filterNumbersOnly="true" runat="server" OnTextChanged="changeExamplePosition" />                                
                                        <a href='/p/<%# Eval("id") %>'>&nbsp;<%# Eval("name") %></a>
                                    </h2><br />
                                    
                                    <div class="btn-group fR">                                
                                        <a id='showSRBT<%# Eval("id") %>' title="Zobrazit řešení a výsledek tohoto příkladu" class="btn btn-mini " onclick="$('#solution<%# Eval("id") %>').collapse('show'); $('#result<%# Eval("id") %>').collapse('show'); $('#showSolutionBT<%# Eval("id") %>').hide(); $('#showResultBT<%# Eval("id") %>').hide(); $('#hideSolutionBT<%# Eval("id") %>').show(); $('#hideResultBT<%# Eval("id") %>').show(); $(this).css('display','none'); $('#hideSRBT<%# Eval("id") %>').css('display','inline');"><i class="icon-eye-open"></i></a>
                                        <a id='hideSRBT<%# Eval("id") %>' title="Skrýt řešení a výsledek tohoto příkladu" class="btn btn-mini hidenBT" onclick="$('#solution<%# Eval("id") %>').collapse('hide'); $('#result<%# Eval("id") %>').collapse('hide'); $('#showSolutionBT<%# Eval("id") %>').show(); $('#showResultBT<%# Eval("id") %>').show(); $('#hideSolutionBT<%# Eval("id") %>').hide(); $('#hideResultBT<%# Eval("id") %>').hide(); $(this).css('display','none'); $('#showSRBT<%# Eval("id") %>').css('display','inline'); $('#solution<%# Eval("id") %>').attr('class','solutions collapse'); $('#result<%# Eval("id") %>').attr('class','results collapse');"><i class="icon-eye-close"></i></a>
                                        <asp:LinkButton ID="deleteExampleFromCollectionBT" CommandArgument='<%# Eval("id") %>' ToolTip="Vymazat příklad ze sbírky" CssClass="btn btn-mini" runat="server" OnClick="deleteExampleFromCollection"><i class="icon-remove"></i></asp:LinkButton>
                                        <asp:ConfirmButtonExtender TargetControlID="deleteExampleFromCollectionBT" ConfirmText="Opravdu smazat příklad z této sbírky?" runat="server" />                                
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
                                            <li><asp:LinkButton ID="deleteExampleFromCollectionContentBT" CommandArgument='<%# Eval("id") %>' runat="server" OnClick="deleteExampleFromCollection"><i class="icon-remove"></i>&nbsp;&nbsp;&nbsp;Vymazat příklad ze sbírky</asp:LinkButton></li>
                                            <asp:ConfirmButtonExtender TargetControlID="deleteExampleFromCollectionContentBT" ConfirmText="Opravdu smazat příklad z této sbírky?" runat="server" />                                
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
                                </div>
                            </div>            
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ContentTemplate>        
    </asp:UpdatePanel>
    <script src="/Scripts/helpWizzard.js"></script>
</asp:Content>