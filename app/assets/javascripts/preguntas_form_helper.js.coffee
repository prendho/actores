window.helpers ||= {}

helpers.preguntasHelperForm =
  saveNow: ->
    $("#only_save").val true
    $("form").submit()

  formNotSaved: ->
    $("#form-not-saved").removeClass "hidden"

  initialize: ->
    $("#save-now").on "click", @saveNow
    $("form input, form textarea").on "change", @formNotSaved
