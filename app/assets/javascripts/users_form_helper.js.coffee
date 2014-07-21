window.helpers ||= {}

helpers.usersFormHelper =
  init: ->
    $("#user_will_invite").trigger "change"

$(document).on "change", "form #user_will_invite", (e) ->
  if e.target.checked
    $(".password-fields").slideUp()
  else
    $(".password-fields").slideDown()
