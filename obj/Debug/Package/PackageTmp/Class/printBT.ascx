<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="printBT.ascx.cs" Inherits="SbirkaPrikladuEU.Class.printBT" %>
<%@ Register Src="/Class/mpTextBox.ascx" TagName="mpTextBox" TagPrefix="uc" %>
<style type="text/css">.modal-backdrop{background-color: rgba(0,0,0,.5);}</style>
<a id="printBT" class="btn btn-primary" data-toggle="modal" href="#printModalPN"><i class="icon-print icon-white"></i>&nbsp;Tisknout</a>

<asp:Panel ID="printModalPN" ClientIDMode="Static" class="modal hide fade" runat="server">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h3>Tisk</h3>
    </div>
    <div class="modal-body">        
        <div  id="collectionPrintTextDIV" runat="server"><h4>Tiskový náhled sbírky vidíte na pozadí</h4><br /><div class="alert alert-info">Sbírka bude vytisknuta jak byla zobrazena před stiskem tlačítka <code><i class="icon-print"></i>&nbsp;TISKNOUT</code>. Řešení a výsledky, které byly zobrazeny, budou vytisknuty, nezobrazené řešení a výsledky se tisknout nebudou.</div><h4>Nastavte další parametry pro tisk:</h4></div>
        <div  id="examplePrintTextDIV" runat="server"><h4>Tiskový náhled příkladu vidíte na pozadí</h4><br /><div class="alert alert-info">Příklad bude vytisknut jak byl zobrazen před stiskem tlačítka <code><i class="icon-print"></i>&nbsp;TISKNOUT</code>. Řešení a výsledky budou vytisknuty, pokud byly zobrazeny, nezobrazené řešení a výsledky se tisknout nebudou.</div><h4>Nastavte další parametry pro tisk:</h4></div>
        <br />
        <div class="form-horizontal">
        <div class="control-group" id="examplesSpacesDIV" runat="server">
            <div class=" control-label">Mezera mezi příklady:</div>
            <div class=" controls"><uc:mpTextBox ID="paddingExamplesTB" CssClass="input-xlarge" waterMarkText="Odsazení mezi jednotlivými příklady v pixelech" filterNumbersOnly="true" runat="server" /></div>
        </div>        
        <div class="control-group">
            <div class=" control-label">Tisknout záhlaví:</div>
            <div class="controls">
                <asp:DropDownList ID="headingPrintDDL" CssClass="input-xlarge" runat="server">
                    <asp:ListItem Text="Ano" Value="true" />
                    <asp:ListItem Text="Ne" Value="false" />
                </asp:DropDownList>
            </div>            
        </div>        
    </div>        
        <br />        
    </div>
    <div class="modal-footer">
        <a href="#" class="btn" data-dismiss="modal">Zrušit</a>
        <div id="exportToPdfBT" class="btn btn-primary" data-loading-text="<i class='icon-folder-open icon-white'></i>&nbsp;&nbsp;&nbsp;Čekejte...&nbsp;" onclick="$(this).button('loading'); setTimeout(function () { exportToPdf(); }, 500);"><i class="icon-folder-open icon-white"></i>&nbsp;Export PDF</div>
        <div id="printModalBT" class="btn btn-primary" data-dismiss="modal" onclick="setTimeout(function () { window.print(); }, 500);"><i class="icon-print icon-white"></i>&nbsp;Tisknout</div>
    </div>
</asp:Panel>

<script type="text/javascript">
    $('#printModalPN').on('show', function () {        
        $('body').addClass('print');
        $('#emailLogoForPrint').html('<img src="http://sbirkaprikladu.eu/App_Themes/Gray/imgs/emailLogo.jpg" alt="Logo" />');
        //$('#<%= paddingExamplesTB.textBoxPointer.ClientID %>').val('0');
        headerRecompute();
        paddingExamplesRecompute();        
    });

    $('#printModalPN').on('hide', function () {
        setTimeout(function () {
            $('body').removeClass('print');
            $('#emailLogoForPrint').html('');
            $('#exampleHeader h1').show();
            $('#exampleHeader p').show();
            $('#exampleHeader').removeAttr('style');
            $('.examplesPadding').removeAttr('style');            
        }, 600);
    });

    function paddingExamplesRecompute() {
        var paddingVal = 0;
        if ($('#<%= paddingExamplesTB.textBoxPointer.ClientID %>').val() != '') paddingVal = $('#<%= paddingExamplesTB.textBoxPointer.ClientID %>').val();
        $('.examplesPadding').css('padding-bottom', paddingVal + 'px');
    }

    function headerRecompute() {
        if ($('#<%= headingPrintDDL.ClientID %>').val() == 'true') {
            $('#exampleHeader h1').show();
            $('#exampleHeader p').show();
            $('#exampleHeader').removeAttr('style');
        }
        else {
            $('#exampleHeader h1').hide();
            $('#exampleHeader p').hide();
            $('#exampleHeader').height(0);
            $('#exampleHeader').css('padding', '0');
            $('#exampleHeader').css('margin', '0');
            $('#exampleHeader').css('border', '0');
            $('#exampleHeader').css('overflow', 'hidden');
        }
    }
 
    $('#<%= paddingExamplesTB.textBoxPointer.ClientID %>').keyup(function () {        
        paddingExamplesRecompute();
    });

    $('#<%= headingPrintDDL.ClientID %>').change(function () {
        headerRecompute();
    });

    var pdfIsExporting = false;
    function exportToPdf() {
        if (pdfIsExporting) return; //double click security - no export moretimes
        pdfIsExporting = true;
        $('#exampleLinkATag').attr('href', "http://" + $('#exampleLinkATag').html());
        var html = $('#mainPN').html();
        var pdfDownloadName = $('h1').html();
        $('#exampleLinkATag').attr('href', "javascript:void(0)");
        
        $.ajax({
            type: "POST",
            url: '/Class/printToPdf.ashx',
            data: { html: html, name: '' },
            dataType: "text",
            success: function (data) { window.location.href = "/Class/downloadFile.aspx?fileType=pdf&filePath=" + data + "&fileName=" + pdfDownloadName; $('#exportToPdfBT').button('reset'); $('#printModalPN').modal('hide'); pdfIsExporting = false; },
            error: function (xhr, ajaxOptions, thrownError) { $('#exportToPdfBT').button('reset'); pdfIsExporting = false; alert('Omlouváme se, ale tisk do PDF se nezdařil. Pokud potíže přetrvávají nahlaste to prosím na podpora@sbirkaprikladu.eu'); }
        });

    }
</script>