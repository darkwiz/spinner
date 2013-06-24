$ ->
  $('.span3').autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $('.span3').data("source")
        dataType: "json"
        data:
          name: request.term
        success: (data) ->
          response(data)