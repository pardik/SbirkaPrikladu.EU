<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="timedInfo.ascx.cs" Inherits="SbirkaPrikladuEU.Class.timedInfo" %>
<div class="row">
    <div id="timedInfoPanel" class="span10 offset2">
        <div id="timedInfoPanelAlert" class="alert alert-info">
            <a class="close" data-dismiss="alert" href="#">&times;</a>            
            <div id="timedInfoPanelText"></div>        
        </div>
    </div>
</div>
<script type="text/javascript">    
    function showInfo(showHTML, alertClass) { showTimedInfo(showHTML, showHTML.length * 30, alertClass); }
    function showTimedInfo(showHTML, showedTime, alertClass) {        
        if (showedTime < 3000) showedTime = 3000;
        if (showedTime > 10000) showedTime = 10000;
        if ($('#timedInfoPanel').queue() != "") { $('#timedInfoPanel').clearQueue().delay(showedTime); }
        $('#timedInfoPanelText').html(showHTML);
        $('#timedInfoPanel').animate({ top: 59, opacity: 1 }, 1000).delay(showedTime).animate({ top: -500, opacity: 0 }, 1000);
        $('#timedInfoPanel').hover(function () { $(this).clearQueue(); }, function () { $(this).delay(1000).animate({ top: -500, opacity: 0 }, 1000); });
        if (alertClass != "") $('#timedInfoPanelAlert').attr("class", "alert " + alertClass);
    }
</script>