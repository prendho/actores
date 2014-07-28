class OptionInteractor
  # found on http://stackoverflow.com/questions/4957207/how-to-check-uncheck-radio-button-on-click
  constructor: (input) ->
    @$input = $(input)
    @$input.bind "mouseup", @mouseUp
    @$input.one "mouseout", @unbindMouseup

  mouseUp: =>
    @uncheckOption()
    @unbindMouseup()

  unbindMouseup: =>
    @$input.unbind "mouseup", @mouseUp

  uncheckOption: =>
    setTimeout =>
      @$input.removeAttr("checked")
      @$input.trigger "change"
    , 0

# allow deselect from radio
$(document).on "mousedown", ".pregunta-option input[type=radio]", (e) ->
  new OptionInteractor(e.target) if e.target.checked

# allow deselect from label
$(document).on "click", ".pregunta-option label", (e) ->
  id = e.target.getAttribute("for")
  $input = $("##{id}")
  if $input.is(":checked")
    setTimeout ->
      $input.removeAttr "checked"
      $input.trigger "change"
    , 0

# actually set option as deselected
$(document).on "change", ".pregunta-option input[type=radio]", (e) ->
  name = e.target.getAttribute("name")
  $input = $(".option-hidden[name='#{name}'], textarea[name='#{name}']")
  if e.target.checked
    unless $input.prop("tagName") == "TEXTAREA" # only set if it's not textarea
      $input.val e.target.value
  else
    $input.val ""
