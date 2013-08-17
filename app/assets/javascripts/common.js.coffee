###
 Autocomplete with jquery-ui, sostituito con typeahead
 necessita di: 1- gem 'jquery-ui-rails'
               2- //= require jquery.ui.all


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



CoffeScript Version of create spin form with ajax
$ ->
  $('#new_spin_ajax').submit ->
    valuesToSubmit = $(this).serialize()
    $.ajax
        beforeSend  : (xhr) ->
         xhr.setRequestHeader("Accept", "application/javascript")
        url: $(this).attr('action') 
        data: valuesToSubmit
        type: 'POST'
        dataType: "html" 
    .done (data) ->
       eval(data)
    .fail ->
        alert("Huston abbiamo un problema")
    return false
      
###