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

/* Spin delete 

$(function() {
    $('.delete_post').on('ajax:success', function() { 
        $(this).closest('li').parents('.accordion').fadeOut();  
    });  
});

*/

/*

$( document ).ready(function() {
console.log( "dom loaded" );
});

*/