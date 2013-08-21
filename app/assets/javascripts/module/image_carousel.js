var myImageCarousel = {

  config : {
    images : ".carousel-image",
    carousel: undefined,
  },

  init : function(config){
  	if (config && typeof(config) == 'object') {
      $.extend(myImageCarousel.config, config);
    }
	myImageCarousel.$imagelist = $(myImageCarousel.config.images);
	myImageCarousel.$carousel  = myImageCarousel.config.carousel;
	myImageCarousel.$modal_carousel = $('#modal-carousel');
  	myImageCarousel.prepareCarousel();
  	for(i=0; i<myImageCarousel.$imagelist.length; i++)
		{
			var link = $(myImageCarousel.$imagelist[i]);
			link.click(myImageCarousel.displayCarousel);
		}
  },

  prepareCarousel: function(){
	myImageCarousel.$carousel = myImageCarousel.$modal_carousel.find('#myCarousel')
  			myImageCarousel.items = myImageCarousel.$carousel.find('.carousel-inner');
			myImageCarousel.$imagelist.each ( function(){
				myImageCarousel.items.append('<div class="item">')
			})
  },

  getImages: function(number) {
  		var containers = myImageCarousel.$carousel.find('.item');
  		var pics = myImageCarousel.$imagelist
		for(i=0; i<pics.length; i++)
		{
			var container = $(containers[i]);
			var pic = $(pics[i]);
			if(container.children('img').length == 0)
			{
				container.append('<img class="modal-image img-polaroid" >');
				var img = container.children('img');
				img.prop('src', pic.data('big'));
				if(number == i){container.addClass("active")}
			}
		}
   },

   displayCarousel: function(event)
	{  
		event.preventDefault();
		var number = parseInt($(event.target).data('num'));
		myImageCarousel.getImages(number);	
		myImageCarousel.$carousel.carousel(number);
		myImageCarousel.$modal_carousel.modal('show');	
	},
};

$( document ).ready( function () { myImageCarousel.init();});