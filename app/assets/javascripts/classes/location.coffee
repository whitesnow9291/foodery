class @Location
  constructor: (@form, @inline) ->
    @handleEvents()

  handleEvents: ->
    url = @inline.data 'url'
    @inline.editable
      type: 'text',
      send: 'always',
      params: (params) ->
        { 'user[address]': params.value }
      url: url,
      success: @handleSuccess

    @form.submit (e) =>
      e.preventDefault()
      field = @form.find('.location-field')
      val = field.val()
      reg = /^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$/
      if !reg.test val
        field.tipso
          content: field.data('info')
          position: 'bottom'
          color: '#bcbcbc'
          background: '#fff'
        field.tipso 'show'
        return
      url = @form.prop 'action'
      $.ajax
        method: 'POST'
        url: url
        data: @form.serialize()
        success: (data) =>
          if !data.error
            window.location = data.location
          else
            field.tipso
              content: data.error
              position: 'bottom'
              color: '#bcbcbc'
              background: '#fff'
            field.tipso 'show'
