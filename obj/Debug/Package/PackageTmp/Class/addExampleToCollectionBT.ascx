<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="addExampleToCollectionBT.ascx.cs" Inherits="SbirkaPrikladuEU.Class.addExampleToCollectionBT" %>
<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SbirkaPrikladuEU %>" />
        <asp:Panel id="insertToTheSamePN" class="btn-group fR" runat="server" visible="false">
            <asp:LinkButton ID="addToTheSameBT" CssClass="btn btn-primary" runat="server" OnClick="insertToCollection"><i class="icon-plus icon-white"></i>&nbsp;&nbsp;&nbsp;Do stejné sbírky</asp:LinkButton><div class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></div>            
            <ul class="dropdown-menu">
                <li><asp:LinkButton ID="addToTheSame2BT" runat="server" OnClick="insertToCollection"><i class="icon-plus"></i>&nbsp;&nbsp;&nbsp;Vložit do stejné sbírky</asp:LinkButton></li>
                <li><a data-toggle="modal" href="#selectCollectionModal"><i class="icon-plus"></i>&nbsp;&nbsp;&nbsp;Vložit do jiné sbírky</a></li>                
            </ul>
        </asp:Panel>
                        
        <asp:LinkButton ID="insertToCollectionBT" CssClass="btn btn-primary" data-toggle="modal" href="#selectCollectionModal" runat="server"><i class="icon-plus icon-white"></i>&nbsp;&nbsp;&nbsp;Vložit do sbírky</asp:LinkButton>
        
        <div class="modal hide fade" id="selectCollectionModal">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h3>Chcete vložit příklad do sbírky?</h3>
            </div>
            <div id="modalBodyOK" class="modal-body" runat="server">
                <p>Zvolte do které sbírky se příklad vloží:</p>
                <asp:DropDownList ID="collectionsDDL" CssClass="input-xxlarge" runat="server" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id" />                
                <br />
            </div>
            <div id="modalBodyNoCollections" class="modal-body" runat="server" visible="false">
                <div class="alert">                    
                    <h3>Je nám líto!</h3>
                    <p></p>
                    <p>Není možné vložit příklad do sbírky, protože nemáte založenu žádnou sbírku.</p>
                    <p>Nejprve si <a href="/Admin/Collections/myCollectionsList.aspx?a=createNew">založte sbírku</a> a teprve poté do ní vkládejte příklady.</p>
                </div>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn" data-dismiss="modal">Zrušit</a>
                <asp:Button ID="insertCollectionModalBT" Text="Vložit do zvolené sbírky" CssClass="btn btn-primary" data-dismiss="modal" UseSubmitBehavior="false" runat="server" OnClick="insertToCollection" />
            </div>
        </div>
    
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="insertCollectionModalBT" />
        <asp:AsyncPostBackTrigger ControlID="addToTheSameBT" />
        <asp:AsyncPostBackTrigger ControlID="addToTheSame2BT" />
    </Triggers>
</asp:UpdatePanel>