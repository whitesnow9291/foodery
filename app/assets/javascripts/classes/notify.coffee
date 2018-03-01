class @Notify
  constructor: (@msg, @type, @append_to) ->
    @append_to = $(@append_to || '.notify-message')
  show: ->
    alert = $ '<div/>',
      class: "alert alert-#{@type} alert-upload",
      role: 'alert',
      text: @msg
    unless @append_to
      $('.flash-messages').append alert
    else
      alert.append $('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>')
      @append_to.append alert
    return alert
