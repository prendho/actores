initializeTooltips = ->
  $(".ttip").tooltip()

jQuery initializeTooltips
$(document).on "page:load", initializeTooltips
