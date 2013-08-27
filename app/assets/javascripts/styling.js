var myStylesheetPreview =
{   
	init: function(settings)
	{   
		myStylesheetPreview.config = {
			$checkbox: $( '.edit_style input:checkbox' ),
			$picker: $( '#colorpicker' ),
			$wellInput: $('#style_well_color'),
			$navbar: $('.navbar'),
			$backgroundInput: $('#style_background_color'),
			$items: $("input[name^='style[']"),
			$select: $( '#style_background_image' )
		};
		// allow overriding the default config
		$.extend( myStylesheetPreview.config, settings );

		myStylesheetPreview.config.$items.each(function(){
			$(this).focusin(  myStylesheetPreview.setupPicker  );
		});

		myStylesheetPreview.config.$wellInput.data('_target', $('.well'));
		myStylesheetPreview.config.$wellInput.focusin(myStylesheetPreview.backgroundColor);

		myStylesheetPreview.config.$checkbox.change(myStylesheetPreview.invertNavbar);

		myStylesheetPreview.config.$backgroundInput.data('_target', $('body'));
		myStylesheetPreview.config.$backgroundInput.focusin(myStylesheetPreview.backgroundColor);
		
		//var backgroundImageInput = form.find('select');
		myStylesheetPreview.config.$select.data('_target', $('body'));
		myStylesheetPreview.config.$select.change(myStylesheetPreview.backgroundImageChange);
	},

	setupPicker: function()
	{
		var f = $.farbtastic('#colorpicker');
    	var p = myStylesheetPreview.config.$picker.css('opacity', 0.5);
    	var selected;
    $(this)
      .each(function () { f.linkTo(this); p.css('opacity', 0.5); })
      p.children('div:first').on({
      	mouseenter: function() {
        p.css('opacity', 1);
      },
      mouseleave: function() {
        p.css('opacity', 0.5);
      }});
	},
	
	invertNavbar: function(event)
	{
		myStylesheetPreview.config.$navbar.toggleClass('navbar-inverse');
	},

	backgroundColor: function(event)
	{
		myStylesheetPreview.config.curr_elem = $(this);
		myStylesheetPreview.config.$picker.mousemove(myStylesheetPreview.changeColor);
		myStylesheetPreview.config.curr_elem.focusout(function(event){
			myStylesheetPreview.config.curr_elem.data('_target').css('background-color', myStylesheetPreview.config.curr_elem.val());
			myStylesheetPreview.config.$picker.off('mousemove', myStylesheetPreview.changeColor);
		});
	},

	changeColor: function(event)
	{
		var target = myStylesheetPreview.config.curr_elem.data('_target');
		target.css('background-color', myStylesheetPreview.config.curr_elem.val());
	},

	backgroundImageChange: function(event)
	{
		target = $(this).data('_target');
		var selected = $(this).find(':selected');
		var url = '/assets/backgrounds/';
		url += selected.text();
		url = 'url("'+url+'")';
		target.css('background-image', url);
		target.css('background-repeat', 'no-repeat');
		target.css('-moz-background-size', 'cover');
		target.css('-webkit-background-size', 'cover');
		target.css('-o-background-size', 'cover');
		target.css('background-size', 'cover');
	},
};

$(document).ready(myStylesheetPreview.init);