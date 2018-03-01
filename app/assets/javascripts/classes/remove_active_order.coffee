class @RemoveActiveOrder
  constructor: (container) ->
    @remove_btn = container.find '.btn-remove-activeOrder'
    @eventHandlers()

  eventHandlers: ->
    @remove_btn.click (e) =>
      e.preventDefault()
      url = @remove_btn.data 'url'
      $.ajax
        url: url
        method: 'POST'
        success: ->
          location.reload()
