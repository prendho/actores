initializeChosen = ->
  $(".chosen").chosen
    allow_single_deselect: true

jQuery initializeChosen
$(document).on "page:load", initializeChosen
