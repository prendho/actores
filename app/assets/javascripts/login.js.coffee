$(document).on "click", "#login-btn", ->
  # show login form
  $(".intro").slideUp()
  $(".intro-login-form").slideDown()
  false
