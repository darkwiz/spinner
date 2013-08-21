var mySpinCounter = {
  config : {
    max : 140,
    wrapper : "textarea[name='spin[content]']",
    counter_num : '.help-block',
  },

  init : function(config) {
    // provide for custom configuration via init()
    if (config && typeof(config) == 'object') {
      $.extend(mySpinCounter.config, config);
    }
    // create and/or cache some DOM elements
    // we'll want to use throughout the code

    mySpinCounter.max = mySpinCounter.config.max;
    mySpinCounter.$counter = $(mySpinCounter.config.counter_num);
    mySpinCounter.$wrapper = $(mySpinCounter.config.wrapper);

      // call other functions
      mySpinCounter.prepareToSpin(mySpinCounter.$wrapper);
      mySpinCounter.$wrapper.focusin(mySpinCounter.focusHandler);
      mySpinCounter.$wrapper.focusout(mySpinCounter.stopTyping);

    },

    prepareToSpin: function(textArea)
    {
      var text = textArea.val();
      var counter = mySpinCounter.$counter;
      var maxLength = mySpinCounter.max
      if(text.length > maxLength)
      {
        text = text.slice(0, maxLength);
        textArea.val(text)
      }
      var length = maxLength-text.length;
      counter.text(length);
    },

    focusHandler: function(event)
    {
      event.preventDefault();
      $(this).keyup(mySpinCounter.textCount);
      $(this).change(mySpinCounter.textCount);
    },

    textCount: function(event)
    {
      var text = $(this).val();
      mySpinCounter.$counter.each( function(){
        var counter = $(this); 
        if(text.length > mySpinCounter.max)
        {
          text = text.substr(0, mySpinCounter.max);
          $(this).val(text)
        }
        var length = mySpinCounter.max-text.length;
        mySpinCounter.$wrapper.val(text)
        counter.text(length);
      });

    },

    stopTyping: function(event)
    {
      event.preventDefault();
      $(this).unbind('keypress', mySpinCounter.textCount);

    }

  };


  $( document ).ready(function() { mySpinCounter.init(); });

