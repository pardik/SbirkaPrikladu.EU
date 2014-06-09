<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="insertNewExample.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Examples.insertNewExample" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
<a href="#" id="helpA00" style="width: 0; height: 0; margin: -60px 150px;" runat="server" ClientIDMode="Static" data-content="Byl spuštěn průvodce vložením nového příkladu. Průvodce Vám pomůže vložit první 3 příklady a poté už Vás nebude zdržovat." data-original-title="Automatická nápověda" class="helpWizzArea"></a>
<asp:UpdatePanel runat="server">
    <ContentTemplate>
    <asp:HiddenField ID="currentPageHF" Value="1" runat="server" />
    <div class="row" id="headerDiv" runat="server">
        <div class="span12">
            <div class="pgAll well">
                <div class="fR">
                    <asp:Button ID="backBT" Text="Zpět" CssClass="btn btn-large fL" Width="150" runat="server" OnClick="backBT_Click" />
                    <span class="fL">&nbsp;</span>
                    <div class="btn-group fR">                        
                        <asp:Button ID="continueBT" Text="Pokračovat" CssClass="btn btn-large btn-primary" Width="150" runat="server" OnClick="continueBT_Click" />
                        <a href="#" id="helpA03" style="width: 0; height: 0; margin: 20px -50px;" runat="server" ClientIDMode="Static" data-content="Až budete mít hotovo, pokračujte tímto tlačítkem dál." data-original-title="Kam dál?" class="helpWizzArea"></a>
                        <a href="#" id="helpE06" style="width: 0; height: 0; margin: 100px 100px;" runat="server" ClientIDMode="Static" data-content="Pokud je vše dle vašich představ, uložte nový příklad tímto tlačítkem." data-original-title="A je to" class="helpWizzArea"></a>
                        <asp:Button ID="finalBT" ClientIDMode="Static" Text="DOKONČIT" CssClass="btn btn-large btn-success" runat="server" Width="150" OnClick="insertExample" Enabled="false" />
                        <div id="navDDLBT" class="btn btn-large btn-primary dropdown-toggle" data-toggle="dropdown" runat="server"><span class="caret"></span></div>
                        <ul class="dropdown-menu fR">
                            <li><asp:LinkButton ID="LB1" runat="server" OnClick="gotoPageLB_Click"><i class="icon-list-alt"></i>&nbsp;&nbsp;&nbsp;Název a parametry příkladu</asp:LinkButton></li>
                            <li><asp:LinkButton ID="LB2" runat="server" OnClick="gotoPageLB_Click"><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Zadání příkladu</asp:LinkButton></li>
                            <li><asp:LinkButton ID="LB3" runat="server" OnClick="gotoPageLB_Click"><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Řešení příkladu</asp:LinkButton></li>
                            <li><asp:LinkButton ID="LB4" runat="server" OnClick="gotoPageLB_Click"><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Výsledek příkladu</asp:LinkButton></li>
                            <li><asp:LinkButton ID="LB5" runat="server" OnClick="gotoPageLB_Click"><i class="icon-check"></i>&nbsp;&nbsp;&nbsp;Sumarizace</asp:LinkButton></li>
                            <li><hr /></li>
                            <li><a href="/Admin/Examples/myExampleList.aspx"><i class="icon-off"></i>&nbsp;&nbsp;&nbsp;Zrušit</a></li>
                        </ul>
                    </div>                    
                </div>
                <h1 id="H1Tag" runat="server" />
                <a href="#" id="helpE01" style="width: 0; height: 0; margin: 10px 400px;" runat="server" ClientIDMode="Static" data-content="Pokud je něco v nepořádku dozvíte se to zde." data-original-title="Chybová hlášení" class="helpWizzArea"></a>
                <asp:Panel ID="summaryErrorPN" CssClass="alert alert-error" Width="50%" runat="server" Visible="false">
                    <button class="close" data-dismiss="alert">&times;</button>
                    <p id="summaryErrorsTag" runat="server" />                    
                </asp:Panel>
            </div>
        </div>        
    </div>
    
    <asp:Panel ID="PNL01" Visible="false" runat="server">
        <div class="row">
            <div class="span6">
                <div class="pgH well">
                    <asp:Panel runat="server">
                        <a href="#" id="helpA01" style="width: 0px; height: 0px; margin: 35px 200px;" runat="server" ClientIDMode="Static" data-content="Nejprve vyplňte název a ostatní parametry příkladu" data-original-title="Název a parametry" class="helpWizzArea"></a>
                        <h3>Název příkladu</h3>
                        <asp:TextBox ID="exampleNameTB" CssClass="span5" placeholder="Krátká charakteristika např. 'Rozklad mnohočlenů na součin'" runat="server" /><br /><br />
                        <h3>Stupeň školy</h3>
                        <asp:CheckBoxList ID="schoolGradeCHBL" RepeatDirection="Horizontal" CssClass="schoolGradeCHBL" runat="server" AutoPostBack="true" OnSelectedIndexChanged="schoolGradeCHBL_SelectedIndexChanged">
                            <asp:ListItem Text="1.stupeň ZŠ" Value="1" />
                            <asp:ListItem Text="2.stupeň ZŠ" Value="2" />
                            <asp:ListItem Text="Středoškolský" Value="3" Selected="True" />
                        </asp:CheckBoxList><br /><br />
                        <h3>Obtížnost příkladu</h3>
                        <asp:RadioButtonList ID="difficultyRBL" RepeatDirection="Horizontal" CssClass="difficultyRBL" runat="server">
                            <asp:ListItem Text="velmi lehký" Value="1" />
                            <asp:ListItem Text="lehký" Value="2" />
                            <asp:ListItem Text="střední" Value="3" Selected="True" />
                            <asp:ListItem Text="obtížný" Value="4" />
                            <asp:ListItem Text="velmi obtížný" Value="5" />
                        </asp:RadioButtonList><br /><br />
                        <h3>Štítky, kličová slova</h3>
                        <asp:TextBox ID="labelNamesTB" CssClass="span5" placeholder="Jednotlivá kličová slova oddělte čárkou" runat="server" /><br /><br />                        
                    </asp:Panel>
                </div>
            </div>

            <div class="span6">
                <div class="pg0020 well">
                    <a href="#" id="helpA02" style="width: 0px; height: 0px; margin: 50px 100px;" runat="server" ClientIDMode="Static" data-content="Poté zařaďte příklad alespoň do jedné skupiny příkladů." data-original-title="Kam příklad patří?" class="helpWizzArea"></a>
                    <asp:Button ID="expandAllGroupsBT" Text="Rozbalit všechny skupiny" CssClass="btn btn-mini fR" runat="server" OnClick="expandAllGroupsBT_Click" />                    
                    <asp:Button ID="collapseAllGroupsBT" Text="Skrýt všechny skupiny" CssClass="btn btn-mini fR" runat="server" OnClick="collapseAllGroupsBT_Click" Visible="false" />                    
                    <h3>Zařaďte příklad do skupiny</h3>
                    <asp:TreeView ID="exampleGroupsTV" ShowCheckBoxes="Leaf" runat="server" OnSelectedNodeChanged="selectedNodeChanged" />
                </div>
            </div>
        </div>
    </asp:Panel>
    
    <a href="#" id="helpB01" style="width: 0; height: 0; margin: 350px 350px;" runat="server" ClientIDMode="Static" data-content="Do této oblasti můžete zapisovat zadání, řešení, nebo výsledek příkladu." data-original-title="Pracovní oblast" class="helpWizzArea"></a>
    <a href="#" id="helpB02" style="width: 500px; height: 68px; margin: 25px 25px;" runat="server" ClientIDMode="Static" data-content="Pro úpravu vzhledu obsahu použijte tato tlačítka." data-original-title="Úprava obsahu" class="helpWizzArea"></a>
    <a href="#" id="helpB03" style="width: 30px; height: 30px; margin: 28px 438px;" runat="server" ClientIDMode="Static" data-content="Matematické vzorce se zadávají zde pomocí editoru matematických vzorců." data-original-title="Matematické vzorce" class="helpWizzArea"></a>
    
    <asp:Panel ID="PNL02" Visible="false" runat="server">
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Panel runat="server">
                        <CKEditor:CKEditorControl ID="enterCKE" Toolbar="Full" Height="500" runat="server"></CKEditor:CKEditorControl>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="PNL03" Visible="false" runat="server">
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Panel runat="server">            
                        <CKEditor:CKEditorControl ID="solutionCKE" Toolbar="Full" Height="500" runat="server"></CKEditor:CKEditorControl>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="PNL04" Visible="false" runat="server">
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Panel runat="server">            
                        <CKEditor:CKEditorControl ID="resultCKE" Toolbar="Full" Height="500" runat="server"></CKEditor:CKEditorControl>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel> 
    
    <asp:Panel ID="PNL05" Visible="false" runat="server">
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="1" OnClick="gotoPage" />
                    <h2><%= exampleNameTB.Text %>&nbsp;</h2><br />                    
                    <a href="#" id="helpE02" style="width: 0; height: 0; margin: 0px 400px;" runat="server" ClientIDMode="Static" data-content="Zkontrolujte si parametry příkladu a zařazení do skupin." data-original-title="Závěrečná kontrola" class="helpWizzArea"></a>
                    <table class=" table table-bordered summaryTable">
                        <tr>
                            <td>
                                <strong>Stupeň školy:&nbsp;</strong><asp:Label ID="summarySchoolGradeLB" runat="server" /><br /><br />
                                <strong>Obtížnost dle autora:&nbsp;</strong><%= difficultyRBL.SelectedItem.Text %><br /><br />
                                <strong>Klíčová slova:&nbsp;</strong><%= labelNamesTB.Text.Replace("  ", " ").Replace(" ,", ",").Replace(", ", ",")%>
                            </td>                                
                            <td><p id="summaryGroupsTag" runat="server"></p></td>
                        </tr>
                    </table>
                </div>
            </div>            
        </div>
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="2" OnClick="gotoPage" />
                    <a href="#" id="helpE03" style="width: 0; height: 0; margin: 0px 200px;" runat="server" ClientIDMode="Static" data-content="Náhled na zadání a závěrečná kontrola." data-original-title="Závěrečná kontrola" class="helpWizzArea"></a>
                    <h2>Zadání příkladu</h2><br />                    
                    <%= enterCKE.Text %>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="3" OnClick="gotoPage" />
                    <a href="#" id="helpE04" style="width: 0; height: 0; margin: 0px 200px;" runat="server" ClientIDMode="Static" data-content="Náhled na řešení a závěrečná kontrola." data-original-title="Závěrečná kontrola" class="helpWizzArea"></a>
                    <h2>Řešení příkladu</h2><br />                    
                    <%= solutionCKE.Text %>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="span12">
                <div class="pgH well">
                    <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="4" OnClick="gotoPage" />
                    <a href="#" id="helpE05" style="width: 0; height: 0; margin: 0px 200px;" runat="server" ClientIDMode="Static" data-content="Náhled na výsledek a závěrečná kontrola." data-original-title="Závěrečná kontrola" class="helpWizzArea"></a>
                    <h2>Výsledek příkladu</h2><br />                    
                    <%= resultCKE.Text %>
                </div>
            </div>
        </div>        
    </asp:Panel>
    <asp:Panel ID="successPN" Visible="false" runat="server">
        <div class="row">
            <div class="span12">
                <div class="pgH hero-unit">
                    <h1>Výborně</h1>
                    <p>&nbsp;</p>
                    <p>Váš příklad byl úspěšně přidán do SbírkyPříkladů.eu</p>
                    <p>Děkujeme Vám za rozšíření sbírky.</p>
                    <p>&nbsp;</p>
                    <a href="/Admin/Examples/myExampleList.aspx" class="btn btn-primary span1">OK</a>
                </div>
            </div>
        </div>
    </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
<script src="/Scripts/helpWizzard.js" type="text/javascript"></script>
</asp:Content>