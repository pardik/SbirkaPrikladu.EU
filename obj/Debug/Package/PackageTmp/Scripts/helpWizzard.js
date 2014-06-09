var timeouts = [];
function helpWizz(startAfter, elementId, duration, placementTopBottomLeftRight, moveToDown, moveToRight) {
    timeouts.push(setTimeout(function () {
        $(elementId).fadeIn();
        $(elementId).popover({ placement: placementTopBottomLeftRight });
        $(elementId).popover('show');
        $('.popover').animate({ top: '+=' + moveToDown, left: '+=' + moveToRight }, duration);
        tm2 = setTimeout(function () { $(elementId).fadeOut(); $(elementId).popover('hide'); }, duration);
    }, startAfter));
}
function clearAllTimeouts() {
    $('.helpWizzArea').hide();
    $('.popover').hide();
    for (var i = 0; i < timeouts.length; i++) clearTimeout(timeouts[i]);
}