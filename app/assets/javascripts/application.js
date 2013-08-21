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

$(function() {
	$('button.respin').on("click",function (event) {
      event.stopPropagation();
  });
});

// Hide-Show Picture 

$(function() {
	$('.accordion-toggle .btn-link, .accordion-toggle ').click(function(event){
		var $button = $(this).find('.btn-link');
		$button.html(function(i,old){
			return old == '<i class="icon-picture"></i>Show Picture' ?  '<i class="icon-picture"></i>Hide picture' : '<i class="icon-picture"></i>Show Picture';
		});
	});
});


// Pretty Upload Picture 

$(function() {
	$( ".image_uploader" ).change(function() {
		$( "#upload-file-info" ).html($(this).val())
	});
});




/*

$( document ).ready(function() {
console.log( "dom loaded" );
});


$(document).ready(reset_counter);

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

----


$(function() {
$('').on('click', function(e) {
    e.preventDefault();
    var $this = $(this);
    var $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');
});
});


$(function() {
	$('#myCollapsible').on('hide', function () {
    // do something…
    alert('0pippo');
	});
});

$('#myModal').modal(show);

 $("button.pic").click(function () {
      $(this).children().toggle();
 });

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