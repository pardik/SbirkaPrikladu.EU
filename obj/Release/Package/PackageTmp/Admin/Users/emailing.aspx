<%@ Page Title="" Language="C#" MasterPageFile="~/withoutSideBar.Master" AutoEventWireup="true" CodeBehind="emailing.aspx.cs" Inherits="SbirkaPrikladuEU.Admin.Users.emailing" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainPanel" runat="server">
    <asp:HiddenField ID="emailAddrHF" runat="server" />
    <div id="emailing" class="well">
        <h3>Předmět zprávy</h3>
        <asp:TextBox ID="subjectTB" CssClass="span11" runat="server" />
        <h3>Text zprávy</h3>
        <CKEditor:CKEditorControl ID="emailTextCKE" runat="server"></CKEditor:CKEditorControl>
        <br />
        <h3>Kliknutím vyberte jména adresátů</h3>
        <div class="alert selectedUserDiv">
            <div id="searchByUserModalUsersListUpper" class="searchByUserModalUsersListUpper" runat="server"></div>
            <div class="clear"></div>
        </div>
        
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <input id="searchByUserModalUserFilterTB" class="fL" type="text" placeholder="Zadejte hledané jméno, nebo e-mail adresáta" />&nbsp;&nbsp;&nbsp;
                <asp:Button ID="primarySubmitBT" ClientIDMode="Static" CssClass="btn btn-primary" Text="Odeslat email" data-loading-text="&nbsp;&nbsp;&nbsp;Odesílám, čekejte...&nbsp;&nbsp;&nbsp;&nbsp;" runat="server" OnClick="primarySubmitBT_Click" OnClientClick="$(this).button('loading'); sendEmailBTClick();" />
           
                <div class="rolesBtnsDiv">
                    <div class="fL">
                        <button type="button" class="btn btn-mini" onclick="insertRoleToList('RegistredUser');"><i class="icon-plus"></i>&nbsp;&nbsp;Registrovaní uživatelé</button><br />
                        <button type="button" class="btn btn-mini" onclick="removeRoleFromList('RegistredUser');"><i class="icon-minus"></i>&nbsp;&nbsp;Registrovaní uživatelé</button>
                    </div>
                    <div class="fL">
                        <button type="button" class="btn btn-mini" onclick="insertRoleToList('Author');"><i class="icon-plus"></i>&nbsp;&nbsp;Tvůrci</button><br />
                        <button type="button" class="btn btn-mini" onclick="removeRoleFromList('Author');"><i class="icon-minus"></i>&nbsp;&nbsp;Tvůrci</button>
                    </div>
                    <div class="fL">
                        <button type="button" class="btn btn-mini" onclick="insertRoleToList('Moderator');"><i class="icon-plus"></i>&nbsp;&nbsp;Moderátoři</button><br />
                        <button type="button" class="btn btn-mini" onclick="removeRoleFromList('Moderator');"><i class="icon-minus"></i>&nbsp;&nbsp;Moderátoři</button>
                    </div>
                    <div class="fL">
                        <button type="button" class="btn btn-mini" onclick="insertRoleToList('Administrator');"><i class="icon-plus"></i>&nbsp;&nbsp;Administrátoři</button><br />
                        <button type="button" class="btn btn-mini" onclick="removeRoleFromList('Administrator');"><i class="icon-minus"></i>&nbsp;&nbsp;Administrátoři</button>
                    </div>
                    <div class="fL">
                        <button type="button" class="btn btn-mini" onclick="insertRoleToList('All');"><i class="icon-plus"></i>&nbsp;&nbsp;všichni</button><br />
                        <button type="button" class="btn btn-mini" onclick="removeRoleFromList('All');"><i class="icon-minus"></i>&nbsp;&nbsp;všichni</button>
                    </div>            
                </div>

                <div class="modal hide fade">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3 ID="messageWasSendH3" runat="server">Zpráva byla odeslána</h3>
                    </div>
                    <div class="modal-body">
                        <p id="messageWasSendP" runat="server">Vaše zpráva byla úspěšně odeslána vybraným úživatelům.</p>
                    </div>
                    <div class="modal-footer">
                        <div id="errModalBT" runat="server" class="btn btn-primary span2 fR" visible="false" data-dismiss="modal">OK</div>
                        <a id="successModalBT" href="/Admin/Users/emailing.aspx" class="btn btn-primary span2 fR" runat="server">OK</a>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br class="clear" />
        <br class="clear" />

        <div id="searchByUserModalUsersListBottom" class="searchByUserModalUsersListBottom" runat="server"></div>        
        <div class="clear"></div>
        
    </div>

<script>
    var searchByUserTimeout;    <%-- animace a oznacovani spodniho seznamu uzivatelu --%>
    $('.searchByUserModalUsersListBottom > .userItem').click(function () {
        clearTimeout(searchByUserTimeout);
        $(this).fadeTo(300, 0).addClass('selected');
        searchByUserTimeout = setTimeout(function () { $('.searchByUserModalUsersListBottom > .userItem.selected').hide(500); }, 2000);

        var userId = $(this).attr('data-userId');
        var pomTag = $('.searchByUserModalUsersListUpper').find('[data-userId="' + userId + '"]');

        searchByUserModalUserListUpperRecomputeItemWidth();
        $(pomTag).css('opacity', '1').show(300);
        $('#searchByUserModalUserFilterTB').focus();
    });

    var searchByUserTimeout2;   <%-- animace a oznacovani horniho seznamu uzivatelu --%>
    var searchByUserTimeout3;
    $('.searchByUserModalUsersListUpper > .userItem').click(function () {
        clearTimeout(searchByUserTimeout2);
        clearTimeout(searchByUserTimeout3);

        $(this).fadeTo(300, 0).addClass('toHide');
        searchByUserTimeout2 = setTimeout(function () { $('.searchByUserModalUsersListUpper > .userItem.toHide').removeClass('toHide').hide(500); }, 2000);

        var userId = $(this).attr('data-userId');
        var pomTag = $('.searchByUserModalUsersListBottom').find('[data-userId="' + userId + '"]');
        $(pomTag).removeClass('selected').show(300);
        setTimeout(function () { $(pomTag).fadeTo(300, 1); }, 300);
        searchByUserTimeout3 = setTimeout(function () { searchByUserModalUserListUpperRecomputeItemWidth(); }, 2500);
        enableDisableSearchByAuthorSubmitModalBT();
        $('#searchByUserModalUserFilterTB').focus();
    });

    function enableDisableSearchByAuthorSubmitModalBT() {
        var itemsSelected = $('.searchByUserModalUsersListBottom > .userItem.selected').length;
        if (itemsSelected > 0) $('#primarySubmitBT').fadeTo('300', '1');
        else $('#primarySubmitBT').fadeTo('300', '0');
    }

    function searchByUserModalUserListUpperRecomputeItemWidth() {   <%-- prepocitavani velikosti butonu horniho seznamu pokud je jich vybrano vice nez 4 --%>
        enableDisableSearchByAuthorSubmitModalBT();
        var itemsSelected = $('.searchByUserModalUsersListBottom > .userItem.selected').length;
        if (itemsSelected > 9) itemsSelected = 10;
        if (itemsSelected > 6 && itemsSelected < 11) {
            $('.searchByUserModalUsersListUpper > .userItem').css('width', (140 * 6 / itemsSelected) + "px").css('margin-left', (20 * 6 / itemsSelected) + "px").css('padding', "3px " + (10 * 6 / itemsSelected) + "px");
            $('.searchByUserModalUsersListUpper > .userItem > .icon-user').hide();
            if (itemsSelected > 6) $('.searchByUserModalUsersListUpper > .userItem').css('font-size', 'smaller');
            else $('.searchByUserModalUsersListUpper > .userItem').css('font-size', '');
        }
        if (itemsSelected <= 4) {
            $('.searchByUserModalUsersListUpper > .userItem').css('width', "").css('margin-left', "").css('padding', '');
            $('.searchByUserModalUsersListUpper > .userItem > .icon-user').show();
        }
    }

    $('#searchByUserModalUserFilterTB').keyup(function () {     <%-- zodrazovani a skryvani uzivatelu spodniho seznamu podle textu zadanaho do pole pro hledani autoru  --%>
            $('.searchByUserModalUsersListBottom > .userItem').hide();
            $('.searchByUserModalUsersListBottom > .userItem:containsNoCase("' + $(this).val() + '")').show();
            $('.searchByUserModalUsersListBottom > .userItem.selected').hide();
        });

        jQuery.expr[':'].containsNoCase = function (a, i, m) {      <%-- porovnavani textu v textboxu bez no lower upper case --%>
            return jQuery(a).text().toUpperCase()
                .indexOf(m[3].toUpperCase()) >= 0;
        };

        $('#searchByAuthorModal').on('show', function () { $('.sideBar').css('z-index', 'auto'); });    <%-- z-index modalu bocniho panelu musi byt auto jinak je modal pod oponou --%>
        $('#searchByAuthorModal').on('hiden', function () { $('.sideBar').css('z-index', '100'); });
        $('#searchByAuthorModal').on('shown', function () { $('#searchByUserModalUserFilterTB').focus(); });    <%-- focus stale na textboxu v modalu  --%>

    function sendEmailBTClick() {    <%-- odpali se po kliknuti primary butonu --%>
            if ($('.searchByUserModalUsersListBottom > .userItem.selected').length > 0) {
                $('#searchByUserUsersIdsHF').val('');
                $('.searchByUserModalUsersListBottom > .userItem.selected').each(function () {
                    $('#<%= emailAddrHF.ClientID %>').val($('#<%= emailAddrHF.ClientID %>').val() + $(this).find('.emailAddr').html() + ',');
                });
            }
        }

        function insertRoleToList(roleName) {
            if (roleName == "All") {
                $('.searchByUserModalUsersListBottom > .userItem').addClass('selected').hide();
                $('.searchByUserModalUsersListUpper > .userItem').show().css('opacity', '1');
            }
            else {
                $('.searchByUserModalUsersListBottom > .userItem[data-roleName="' + roleName + '"]').addClass('selected').hide();
                $('.searchByUserModalUsersListUpper > .userItem[data-roleName="' + roleName + '"]').show().css('opacity', '1');
            }
            searchByUserModalUserListUpperRecomputeItemWidth();
            $('#searchByUserModalUserFilterTB').focus();

        }

        function removeRoleFromList(roleName) {
            if (roleName == "All") {
                $('.searchByUserModalUsersListBottom > .userItem').show().removeClass('selected').css('opacity', '1');
                $('.searchByUserModalUsersListUpper > .userItem').hide();
            }
            else {
                $('.searchByUserModalUsersListBottom > .userItem[data-roleName="' + roleName + '"]').show().removeClass('selected').css('opacity', '1');
                $('.searchByUserModalUsersListUpper > .userItem[data-roleName="' + roleName + '"]').hide();
            }
            searchByUserModalUserListUpperRecomputeItemWidth();
            $('#searchByUserModalUserFilterTB').focus();
        }

        $(document).ready(function () {        <%-- nastavi seznam oznacenych autoru po kliku na ZPET, jelikož vše je javascript --%>
            var pomInterval = setInterval(function () {
                if ($('#searchByUserUsersIdsHF').val() != '') {
                    var ids = $('#searchByUserUsersIdsHF').val().split(',');
                    $(ids).each(function () {
                        $('.searchByUserModalUsersListUpper > [data-userid="' + this + '"]').show();
                        $('.searchByUserModalUsersListBottom > [data-userid="' + this + '"]').hide().addClass('selected');
                    });
                    searchByUserModalUserListUpperRecomputeItemWidth();
                    clearInterval(pomInterval);
                }
            }, 1000);

            enableDisableSearchByAuthorSubmitModalBT();
            $('#searchBT').mouseenter(function () { $(this).popover('show'); }).mouseleave(function () { $(this).popover('hide'); });
            $('#searchByAuthorModalBT').mouseenter(function () { $(this).popover('show'); }).mouseleave(function () { $(this).popover('hide'); });
        });

</script>
</asp:Content>
