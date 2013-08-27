/*$(document).ready(function() {
    var f = $.farbtastic('#colorpicker'); //problem with hide-show
    var p = $('#colorpicker').css('opacity', 0.25);
    var selected;
    $("input[name^='style[']")
      .each(function () { f.linkTo(this); $(this).css('opacity', 0.75); })
      .focus(function() {
        if (selected) {
          $(selected).css('opacity', 0.75).removeClass('colorwell-selected');
        }
        f.linkTo(this);
        p.css('opacity', 1);
        $(selected = this).css('opacity', 1).addClass('colorwell-selected');
      });
  });*/