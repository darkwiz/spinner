// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require_tree .
//= require bootstrap
$(function() {
    var max = 140;
	var len = $('#spin_content').val().length;
	len = max - len
	$(".help-block").text(""+ len +"");
});

$(function() {
	$('#spin_content').keyup(function () {
		var max = 140;
		var len = $(this).val().length;
		if (len <= max){
			len = max - len;
			$(".help-block").text(""+ len +"");
			$(".help-block").css( "color", "" );
		} else {
			len = max - len;
			$(".help-block").text(""+ len +"");
			$(".help-block").css( "color", "red" );
		}
		len--
	});
});


/*
$('#myModal').modal(show);

$('#InfroTextSubmit').click(function(){
    
    if ($('#title').val()==="") {
      // invalid
      $('#title').next('.help-inline').show();
      return false;
    }
    else {
      // submit the form here
      // $('#InfroText').submit();
      
      return true;
    }
      
});
*/