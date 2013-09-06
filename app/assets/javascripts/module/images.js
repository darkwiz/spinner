var DisplayImage =
{
	
	init: function(settings)
	{
		DisplayImage.config = {
			$modal: undefined
		};

		$.extend( DisplayImage.config, settings );

		DisplayImage.prepareModal();
		$('body').on('click', '.image', DisplayImage.showFullSize);
	},

	prepareModal: function()
	{
		$('body').append('<div class="image-modal modal hide fade">');
		DisplayImage.config.$modal = $('.image-modal');
		DisplayImage.config.$modal.hide(0);

		DisplayImage.config.$modal.append('<img class="modal-image">');
		DisplayImage.config.$modal.data('pic', DisplayImage.config.$modal.children('img'));
		DisplayImage.config.$modal.data('pic').addClass('img-polaroid');
		DisplayImage.config.$modal.data('pic').css('margin', '5%');
		DisplayImage.config.$modal.data('pic').css('width', '90%');
		DisplayImage.config.$modal.data('pic').css('height', '90%');
	},

	showFullSize: function(event)
	{
		event.preventDefault();
		link = $(this).data('big');
		if(DisplayImage.config.$modal == undefined)
		{
			DisplayImage.prepareModal();
		}
		DisplayImage.config.$modal.data('pic').attr('src', link);
		DisplayImage.config.$modal.modal('show');
	},

};

$(document).ready(DisplayImage.init)