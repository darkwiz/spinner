var DisplayImage =
{
	modal: undefined,

	init: function()
	{
		DisplayImage.prepareModal();
		$('body').on('click', '.image', DisplayImage.showFullSize);
	},

	prepareModal: function()
	{
		$('body').append('<div class="image-modal modal hide fade">');
		DisplayImage.modal = $('.image-modal');
		DisplayImage.modal.hide(0);

		DisplayImage.modal.append('<img class="modal-image">');
		DisplayImage.modal.prop('_img', DisplayImage.modal.children('img'));
		DisplayImage.modal.prop('_img').addClass('img-polaroid');
		DisplayImage.modal.prop('_img').css('margin', '5%');
		DisplayImage.modal.prop('_img').css('width', '90%');
		DisplayImage.modal.prop('_img').css('height', '90%');
	},

	showFullSize: function(event)
	{
		event.preventDefault();
		link = $(this).data('big');
		if(DisplayImage.modal == undefined)
		{
			DisplayImage.prepareModal();
		}
		DisplayImage.modal.prop('_img').attr('src', link);
		DisplayImage.modal.modal('show');
	},

};

$(document).ready(DisplayImage.init)