searching = null

$(document).on "keyup", ".search-actores", ->
  if searching != @value
    searching = @value
    $(this).parent().submit()
