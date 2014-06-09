<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="editExample.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Examples.editExample" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
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
                                <asp:Button ID="finalBT" ClientIDMode="Static" Text="DOKONČIT" CssClass="btn btn-large btn-success" runat="server" Width="150" OnClick="updateExample" Enabled="false" />
                                <div id="navDDLBT" class="btn btn-large btn-primary dropdown-toggle" data-toggle="dropdown" runat="server"><span class="caret"></span></div>
                                <ul class="dropdown-menu fR">
                                    <li>
                                        <asp:LinkButton ID="LB1" runat="server" OnClick="gotoPageLB_Click"><i class="icon-list-alt"></i>&nbsp;&nbsp;&nbsp;Název a parametry příkladu</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="LB2" runat="server" OnClick="gotoPageLB_Click"><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Zadání příkladu</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="LB3" runat="server" OnClick="gotoPageLB_Click"><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Řešení příkladu</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="LB4" runat="server" OnClick="gotoPageLB_Click"><i class="icon-edit"></i>&nbsp;&nbsp;&nbsp;Výsledek příkladu</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="LB5" runat="server" OnClick="gotoPageLB_Click"><i class="icon-check"></i>&nbsp;&nbsp;&nbsp;Sumarizace</asp:LinkButton></li>
                                    <li>
                                        <hr />
                                    </li>
                                    <li><a href="javascript:history.back();"><i class="icon-off"></i>&nbsp;&nbsp;&nbsp;Zrušit</a></li>
                                </ul>
                            </div>
                        </div>
                        <h1 id="H1Tag" runat="server" />
                        <asp:Panel ID="summaryErrorPN" CssClass="alert alert-error" Width="50%" runat="server" Visible="false">
                            <button class="close" data-dismiss="alert">×</button>
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
                                <h3>Název příkladu</h3>
                                <asp:TextBox ID="exampleNameTB" CssClass="span5" placeholder="Krátká charakteristika např. 'Rozklad mnohočlenů na součin'" runat="server" /><br />
                                <br />
                                <h3>Stupeň školy</h3>
                                <asp:CheckBoxList ID="schoolGradeCHBL" RepeatDirection="Horizontal" CssClass="schoolGradeCHBL" runat="server" AutoPostBack="true" OnSelectedIndexChanged="schoolGradeCHBL_SelectedIndexChanged">
                                    <asp:ListItem Text="1.stupeň ZŠ" Value="1" />
                                    <asp:ListItem Text="2.stupeň ZŠ" Value="2" />
                                    <asp:ListItem Text="Středoškolský" Value="3" />
                                </asp:CheckBoxList>
                                <br />
                                <br />
                                <h3>Obtížnost příkladu</h3>
                                <asp:RadioButtonList ID="difficultyRBL" RepeatDirection="Horizontal" CssClass="difficultyRBL" runat="server">
                                    <asp:ListItem Text="velmi lehký" Value="1" />
                                    <asp:ListItem Text="lehký" Value="2" />
                                    <asp:ListItem Text="střední" Value="3" />
                                    <asp:ListItem Text="obtížný" Value="4" />
                                    <asp:ListItem Text="velmi obtížný" Value="5" />
                                </asp:RadioButtonList><br />
                                <br />
                                <h3>Štítky, kličová slova</h3>
                                <asp:TextBox ID="labelNamesTB" CssClass="span5" placeholder="Jednotlivá kličová slova oddělte čárkou" runat="server" /><br />
                                <br />
                            </asp:Panel>
                        </div>
                    </div>

                    <div class="span6">
                        <div class="pg0020 well">
                            <asp:Button ID="expandAllGroupsBT" Text="Rozbalit všechny skupiny" CssClass="btn btn-mini fR" runat="server" OnClick="expandAllGroupsBT_Click" />
                            <asp:Button ID="collapseAllGroupsBT" Text="Skrýt všechny skupiny" CssClass="btn btn-mini fR" runat="server" OnClick="collapseAllGroupsBT_Click" Visible="false" />
                            <h3>Zařaďte příklad do skupiny</h3>
                            <asp:TreeView ID="exampleGroupsTV" ShowCheckBoxes="Leaf" runat="server" OnSelectedNodeChanged="selectedNodeChanged" />
                        </div>
                    </div>
                </div>
            </asp:Panel>

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
                                <div class="toR">
                                    <a href=".youTubeSolutionModal" role="button" class="btn btn-danger" style="position: absolute; margin: 10px -100px;" data-toggle="modal">Videořešení</a>
                                </div>
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
                            <h2><%= exampleNameTB.Text %>&nbsp;</h2>
                            <br />
                            <table class="table table-bordered summaryTable">
                                <tr>
                                    <td>
                                        <strong>Stupeň školy:&nbsp;</strong><asp:Label ID="summarySchoolGradeLB" runat="server" /><br />
                                        <br />
                                        <strong>Obtížnost dle autora:&nbsp;</strong><%= difficultyRBL.SelectedItem.Text %><br />
                                        <br />
                                        <strong>Klíčová slova:&nbsp;</strong><%= labelNamesTB.Text.Replace("  ", " ").Replace(" ,", ",").Replace(", ", ",")%>
                                    </td>
                                    <td>
                                        <p id="summaryGroupsTag" runat="server"></p>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="span12">
                        <div class="pgH well">
                            <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="2" OnClick="gotoPage" />
                            <h2>Zadání příkladu</h2>
                            <br />
                            <%= enterCKE.Text %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="span12">
                        <div class="pgH well">
                            <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="3" OnClick="gotoPage" />
                            <h2>Řešení příkladu</h2>
                            <br />
                            <%= solutionCKE.Text %>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="span12">
                        <div class="pgH well">
                            <asp:Button Text="Upravit" CssClass="btn fR" runat="server" dataKey="4" OnClick="gotoPage" />
                            <h2>Výsledek příkladu</h2>
                            <br />
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
                            <p>Váš příklad byl úspěšně aktualizován.</p>
                            <p>&nbsp;</p>
                            <a href="/Admin/Examples/myExampleList.aspx" class="btn btn-primary span1">OK</a>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel class="modal hide fade youTubeSolutionModal" DefaultButton="youTubeUrlBT" runat="server">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h3>Vložit videořešení z YouTube.com</h3>
                </div>
                <div class="modal-body">
                    <p>
                        Zadejte URL adresu videa z YouTube.com:<br />
                        <asp:TextBox ID="youTubeUrlTB" CssClass="span5" runat="server" />
                    </p>
                </div>
                <div class="modal-footer">
                    <div class="btn" data-dismiss="modal">Zavřít</div>
                    <asp:Button ID="youTubeUrlBT" Text="Vložit" CssClass="btn btn-danger" data-dismiss="modal" UseSubmitBehavior="false" runat="server" OnClick="youTubeurlBT_Click" />
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
