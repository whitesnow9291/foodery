Function::new = ->
  Fake = undefined
  args = undefined
  constructor = undefined
  args = arguments
  constructor = this

  Fake = ->
    constructor.apply this, args

  Fake.prototype = constructor.prototype
  new Fake

class @Loader
  constructor: (container) ->
    container = container || 'html'
    @container = $(container)
    @load()

  load: ->
    @loadElements()
    @loadForms()
    @loadActions()

  loadElements: ->
    @container.find('*[js-class]').each (i, el) ->
      el = $(el)
      klass_name = el.attr 'js-class'
      args = []
      args.push el
      klass = window[klass_name]
      extra = el.attr 'js-args'
      if !!extra
        Array.prototype.push.apply args, extra.split(',')
      instance = klass.new.apply(klass, args)

  loadForms: ->
    @container.find('*[js-form]').each (i, el) ->
      el = $(el)
      klass_name = el.attr 'js-form'
      args = []
      args.push el
      klass = window[klass_name]
      method = el.attr('js-method') || 'POST'
      args.push method
      extra = el.attr 'js-args'

      if !!extra
        Array.prototype.push.apply args, extra.split(',')
      instance = klass.new.apply(klass, args)
  loadActions: ->
    ActionLoader.new @container


class @FormHandlerBase
  constructor: (@form, @method) ->
    @url = @form.attr 'action'
    @form.submit (e, data) =>
      e.preventDefault()
      $.ajax
        url: @url
        method: @method
        data: @form.serialize()
        success: (data) =>
          if !!data.errors_html
              @form.find('.form-errors').html data.errors_html
          @success data
        fail: (data) =>
          @fail data

class @ActionLoader
  constructor: (@container) ->
    items = @container.find('*[js-ajax]')
    items.each (i, el) =>
      item = $(el)
      url = item.attr 'js-url'
      method = item.attr('js-method') || 'POST'
      event = item.attr('js-event') || 'click'
      item.on event, (e) =>
        if event == 'click'
          e.preventDefault()
        $.ajax
          url: url
          method: method
          success: @successHandler
          fail: @failHandler

  successHandler: (data) =>
    if !!data.content_replacer
      @contentReplacer data.content_replacer
    if !!data.redirect
      @redirect data.redirect
    console.log data

  failHandler: (data) =>
    console.log data

  contentReplacer: (data) ->
    $.each data, (i, el) ->
      container = $(el.selector)
      container.replaceWith el.content

  redirect: (data) ->
    if !!Turbolinks
      Turbolinks.visit data.location
    else
      window.location = data.location
