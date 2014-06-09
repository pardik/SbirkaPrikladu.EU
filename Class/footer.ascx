<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="footer.ascx.cs" Inherits="SbirkaPrikladuEU.Class.footer" %>

    <div class="container footer">
        <div class="row">
            <div class="span3 offset2">
                <h4>SbírkaPříkladů.eu</h4>
                <a href="/about.aspx">O projektu</a><br />
                <a href="mailto:podpora@sbirkaprikladu.eu">Kontaktujte nás</a><br />
                <a href="/Admin/Users/registerUser.aspx">Registrujte se zdarma</a>
            </div>
            <div class="span3 hidden-phone">                
                <!-- AddThis Follow BEGIN -->
                <h4>Zůstaňte v kontaktu</h4>
                <div class="addthis_toolbox addthis_32x32_style">
                    <a class="addthis_button_facebook_follow" <%="addthis:userid"%>="SbirkaPrikladu"></a>
                    <a class="addthis_button_twitter_follow" <%="addthis:userid"%>="SbirkaPrikladu"></a>
                    <a class="addthis_button_google_follow" <%="addthis:userid"%>="u/0/b/106736930937451008177/106736930937451008177/posts"></a>
                </div>
                <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4febf6eb74f2a083"></script>
                <!-- AddThis Follow END -->
                <br />&copy; 2012 SbírkaPříkladů.eu
            </div>            
            <div class="span4 hidden-phone">
                <h4>&nbsp;</h4>                
                <a href="http://www.primmat.cz" target="_blank"><img src="/App_Themes/Gray/imgs/logoPrimMat.jpg" alt="" /></a>&nbsp;
                <a href="http://www.wiris.com" target="_blank"><img src="/App_Themes/Gray/imgs/wirisBanner.png" alt="" /></a>
            </div>
        </div>
    </div>

<script>
    function recomputeFooterPosition() {
        setTimeout(function () {
            var footer = $('.footer');
            var sideBar = $('.sideBar');
            var mainPN = $('#mainPN');

            if (footer.position().top < $(window).height() - footer.height()) footer.css('margin-top', $(window).height() - footer.position().top - footer.height() - 40);  //moving to bottom of window
            if (sideBar && sideBar.height() > mainPN.height() && $(window).height() < sideBar.position().top + sideBar.height() + footer.height() + 40) footer.css('margin-top', 20 + sideBar.height() - mainPN.height());  //moving down with sidebar
        }, 100);
    }
</script>