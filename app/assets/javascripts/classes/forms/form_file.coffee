class @FormFile
  constructor: (@elem) ->
   @eventHandler()

  eventHandler: ->
    @elem.on 'change', '.btn-file :file', ->
      input = $(this)
      label = input.val().replace(/\\/g, '/').replace(/.*\//, '')
      input = $(this).parents('.input-group').find ':text'
      input.val label

    @elem.on 'fileselect', '.btn-file :file', (event, label) ->
      input = $(this).parents('.input-group').find ':text'
      input.val label
