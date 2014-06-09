// ********************************************************** //
// JS Script to expand example enter rows in example gridviews //
// ********************************************************** //

var gwEnterRowHeight = $('.gwEnterRow').height();   //save row height before expand, then collapse to this value
var timer;
var gwCurRow;

$('.gwRow').mouseenter(function () { gwCurRow = $(this); clearTimeout(timer); timer = setTimeout(expandEnterRow, 500); });  // mouse over for 200ms, then expand row
$('.gwRow').mouseleave(collapseEnterRow);

function expandEnterRow() {    
    var pomH = gwCurRow.nextUntil('.gwRow').children().find('.gwEnterRowContent').height();
    var gwEnterRow = gwCurRow.nextUntil('.gwRow').children().find('.gwEnterRow');
    if (pomH > gwEnterRow.height()) { pomH += 20; } else { pomH = gwEnterRow.height(); }
    gwEnterRow.animate({ height: pomH + 'px', opacity: '1' }, 200); 
}

function collapseEnterRow() {
    clearTimeout(timer);
    $(this).nextUntil('.gwRow').children().find('.gwEnterRow').animate({ height: gwEnterRowHeight + 'px', opacity: '.3' }, 200);
}