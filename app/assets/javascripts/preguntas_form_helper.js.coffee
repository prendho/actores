window.helpers ||= {}

helpers.preguntasHelperForm =
  saveNow: ->
    $("#only_save").val true
    $("form").submit()

  formNotSaved: ->
    $("#form-not-saved").removeClass "hidden"

  formSubmitted: ->
    $("#form-not-saved").addClass "hidden"

  initialize: ->
    allowOtherRespuestaHelper.initialize()
    checkboxesRespuestaHelper.initialize()
    $("#save-now").on "click", @saveNow
    $("form input, form textarea").on "change", @formNotSaved
    $("form").on "submit", @formSubmitted

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
    false

checkboxesRespuestaHelper =
  labelClicked: (e) ->
    value = e.target.textContent
    $checkbox = $("input[type=checkbox][value='#{value}']")
    if $checkbox.is(":checked")
      $checkbox[0].checked = false
    else
      $checkbox[0].checked = true
    $checkbox.trigger "change"
    false

  checkboxChanged: (e) ->
    name = $(e.target).attr("name")
    $input = $("input[name='#{name}'].multiple-option-hidden")
    value = $("input[name='#{name}']:checked").map (i, input) ->
      input.value
    $input.val value.toArray().join(",")

  select: ->
    for input in $(".multiple-option-hidden")
      $input = $(input)
      values = $input.val().split(",")
      for value in values
        if !!value
          $checkbox = $("input[type=checkbox][value='#{value}']")
          $checkbox[0].checked = true
          $checkbox.trigger "change"
    false

  initialize: ->
    @select()
    $(".multiple-option input[type=checkbox]").on "change", @checkboxChanged
    $(".multiple-option .pregunta-option label").on "click", @labelClicked
