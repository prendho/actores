searching = null

$(document).on "keyup", ".search-actores input[type=search]", ->
  if searching != @value
    searching = @value
    $(this).parent().submit()

ajaxRequests = 0

$(document).on "ajax:send", ".search-actores", (e) ->
  if ajaxRequests is 0
    new Spinner().spin $("#spinner-loading")[0]
  ajaxRequests += 1

$(document).on "ajax:complete", ".search-actores", (e) ->
  ajaxRequests -= 1
  if ajaxRequests is 0
    $("#spinner-loading").html("")
