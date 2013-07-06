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
//= require jquery.ui.effect-highlight
//= require jquery_ujs
//= require_tree .
//= require bootstrap

var reset_counter = function() {
    var max = 140;
	var len = $('#spin_content').val().length;
	len = max - len
	$(".help-block").text(""+ len +"");
};

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

/* Autocomplete con bootstrap-typeahead */

$(function() {
	var labels
       , mapped
	$('input#search').typeahead({
		source: function (query, process) {
		 $.getJSON(
				$('input#search').data("source"),
				{ name: query },
				function (data) {
					var users = [];
					map = {};
					$.each(data, function (i, user) {
						map[user.name] = user;
						users.push(user.name);
                    });
					return process(users);
				});
		},
		matcher: function (item) { 
			if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) != -1) {
				return true;
			}
		},
		sorter: function (items) {
			return items.sort();
		},
		highlighter: function (item) {
			var regex = new RegExp( '(' + this.query + ')', 'gi' );
			return item.replace( regex, "<strong>$1</strong>" );
		},
		updater: function (item) {
			window.location = window.location.origin + "/users/" + encodeURIComponent(map[item].id);
			return item;
		},
	});
});

/* Ferma la propagazione dell'evento click su i link dei dati utente verso l'accordion */


$(function() {
	$('a.other').click(function (event) {
      event.stopPropagation();
  });
});

$(document).ready(reset_counter);

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