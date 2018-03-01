class @RestaurantFilter
  constructor: (@container, table) ->
    @table = $(table)
    @eventHandlers()

  eventHandlers: ->
    @container.on 'click', 'li a', (e) =>
      e.preventDefault()
      url = @container.data 'url'
      item = $(e.currentTarget)
      restaurant = item.data 'restaurant'
      $.ajax
        method: 'GET'
        url: url
        data:
          restaurant: restaurant
        success: @success

  success: (data) =>
    @container.html data.filter_html
    @table.html data.table_html
