window.helpers ||= {}

helpers.loginHelper =
  login: ->
    $("input[type='submit']")
      .attr("value", "Entrando..")
      .addClass("disabled")
    window.location.href = "/"
