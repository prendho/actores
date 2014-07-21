class FlashesHelper
  constructor: ->
    for flash in $(".flashes .flash")
      $flash = $(flash)
      alertify.log $flash.text()

initializeFlashesHelper = -> new FlashesHelper

jQuery initializeFlashesHelper
$(document).on "page:load", initializeFlashesHelper
