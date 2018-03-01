class @Tag
  constructor: (@links_container, @content_container) ->
    @eventsHandler()

  eventsHandler: ->
    @links_container.on 'click', 'option', (e) =>
      e.preventDefault()
      tag = $(e.currentTarget).val() || ""
      $.ajax
        method: 'GET'
        url: "?tag=#{tag}"
        success: (data) =>
          @content_container.html data.html
          @links_container.html data.tags_html
