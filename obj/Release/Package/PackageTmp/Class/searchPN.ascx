<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="searchPN.ascx.cs" Inherits="SbirkaPrikladuEU.Class.searchPN" %>
<asp:Panel DefaultButton="searchBT" runat="server">
    <asp:TextBox ID="searchTB" placeholder="Hledat..." CssClass="search-query topSearchTB" runat="server" />
    <asp:LinkButton ID="searchBT" ClientIDMode="Static" CssClass="btn" rel="popover" data-placement="top" title="Hledání" data-content="Standardně hledá zadaný text ve SbírcePříkladů.EU" runat="server" OnClick="searchBT_Click"><i class="icon-search"></i></asp:LinkButton>
    <a id="searchByAuthorModalBT" href="#searchByAuthorModal" data-toggle="modal" class="btn" rel="popover" title="Hledání podle autora" data-content="Umožňuje zobrazit příklady jen od některých autorů, nebo u nich hledat zadaný text."><i class="icon-user"></i></a>
</asp:Panel>

<div id="searchByAuthorModal" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <div class="fR">
            <button type="button" class="btn btn-mini" onclick="searchByUserAddAll();"><i class="icon-plus"></i>&nbsp;&nbsp;vše</button>
            <button type="button" class="btn btn-mini" onclick="searchByUserRemoveAll();"><i class="icon-minus"></i>&nbsp;&nbsp;vše</button>
            &nbsp;&nbsp;&nbsp;
        </div>
        <h3>Kliknutím vyberte jména autorů jejichž příklady chete zobrazit</h3>
    </div>
    <div class="modal-body">
        <div class="alert selectedUserDiv">
            <div id="searchByUserModalUsersListUpper" class="searchByUserModalUsersListUpper" runat="server"></div>
            <div class="clear"></div>
        </div>
        
        <div id="searchByUserModalUsersListBottom" class="searchByUserModalUsersListBottom" runat="server"></div>
        <div class="clear"></div>        
    </div>
    <div class="modal-footer">
        <input id="searchByUserModalUserFilterTB" class="fL" type="text" placeholder="Zadejte hledané jméno tvůrce..." />
        <div class="btn" data-dismiss="modal">Zrušit</div>
        <asp:Button ID="searchByUserSubmitBT" ClientIDMode="Static" CssClass="btn btn-primary" Text="Hledat dle vybraných tvůrců" data-loading-text="&nbsp;&nbsp;&nbsp;Vyhledávám, čekejte...&nbsp;&nbsp;&nbsp;&nbsp;" runat="server" OnClick="searchByUserSubmitBT_Click" OnClientClick="$(this).button('loading'); searchByUserBTClick();" />        
    </div>
</div>

<asp:HiddenField ID="searchByUserUsersIdsHF" ClientIDMode="Static" runat="server" />

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
        if (itemsSelected > 0) $('#searchByUserSubmitBT').fadeTo('300', '1');
        else $('#searchByUserSubmitBT').fadeTo('300', '0');
    }

    function searchByUserModalUserListUpperRecomputeItemWidth() {   <%-- prepocitavani velikosti butonu horniho seznamu pokud je jich vybrano vice nez 4 --%>
        enableDisableSearchByAuthorSubmitModalBT();
        var itemsSelected = $('.searchByUserModalUsersListBottom > .userItem.selected').length;
        if (itemsSelected > 9) itemsSelected = 10;
        if (itemsSelected > 4 && itemsSelected < 11) {
            $('.searchByUserModalUsersListUpper > .userItem').css('width', (140 * 4 / itemsSelected) + "px").css('margin-left', (20 * 4 / itemsSelected) + "px").css('padding', "3px " + (10 * 4 / itemsSelected) + "px");
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

    function searchByUserBTClick() {    <%-- odpali se po kliknuti primary buton modalu hledat dle autoru --%>
        if ($('.searchByUserModalUsersListBottom > .userItem.selected').length > 0) {
            $('#searchByUserUsersIdsHF').val('');
            $('.searchByUserModalUsersListBottom > .userItem.selected').each(function () {
                $('#searchByUserUsersIdsHF').val($('#searchByUserUsersIdsHF').val() + $(this).attr('data-userid') + ',');
            });
        }
    }

    function searchByUserAddAll() {
        $('.searchByUserModalUsersListBottom > .userItem').addClass('selected').hide();
        $('.searchByUserModalUsersListUpper > .userItem').show().css('opacity','1');
        searchByUserModalUserListUpperRecomputeItemWidth();
        $('#searchByUserModalUserFilterTB').focus();

    }

    function searchByUserRemoveAll() {
        $('.searchByUserModalUsersListBottom > .userItem').show().removeClass('selected').css('opacity', '1');
        $('.searchByUserModalUsersListUpper > .userItem').hide();
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

