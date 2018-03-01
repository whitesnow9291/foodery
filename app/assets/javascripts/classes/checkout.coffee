class @Checkout
  constructor: (@checkout_page, @checkout_container) ->
    @eventsHandler()

  eventsHandler: ->
    @checkout_container.on 'order-empty', (e, url) =>
      if @checkout_page.length > 0
        window.location = url
