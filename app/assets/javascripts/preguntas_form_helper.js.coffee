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
    allowOtherRespuestaHelper.initialize()

allowOtherRespuestaHelper =
  optionChanged: (e) ->
    name = $(e.target).attr("name")
    $textarea = $("textarea[name='#{name}']")
    if $(e.target).hasClass("other-option")
      $textarea.val("")
      $textarea.parent().slideDown()
    else
      $textarea.parent().slideUp ->
        $textarea.val(e.target.value)

  initialize: ->
    $(".allow-other input[type=radio]").on "change", @optionChanged
    for radio in $(".allow-other input[type=radio]:checked")
      $radio = $(radio)
      $radio.trigger("change") unless $radio.hasClass("other-option")
