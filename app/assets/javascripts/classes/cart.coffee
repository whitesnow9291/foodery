class @Cart
  constructor: (@form) ->
    return if @form.size() == 0

    @alert = @form.find '.process-alert'
    @submit_with_stripe = @form.find '.submit-checkout.with-stripe'
    @submit_without_stripe = @form.find '.submit-checkout.without-stripe'
    @btn_new_card = @form.find '.use-new-card button'
    @new_card_conitainer = $('.card-creation')
    @datePicker = @form.find('#delivery-date')
    avg_duration = parseInt(@datePicker.data('avg-duration'))
    @parseAvailableHours(@datePicker.data('open-time'), @datePicker.data('close-time'))
    moment.locale('en')
    moment.tz('EST').format()
    @datePicker.datetimepicker
      locale: document.documentElement.lang || 'en'
      timeZone: 'EST'
      sideBySide: true
      format: 'YYYY-MM-DD'
      minDate: moment.tz('EST').add(avg_duration, 'm').millisecond(0).second(0).minute(0).hour(0)
      # minDate: moment.tz('EST').add(avg_duration, 'm').millisecond(0).second(0).minute(0).hour(0)
      # defaultDate: moment.tz('EST').add(avg_duration, 'm')
    @pickedDate = @datePicker.data('DateTimePicker').date()
    @datePicker.on 'dp.change', (e) =>
      @pickedDate = e.date
      @checkAvailableHours()
    @eventHandler()

  checkAvailableHours: () ->
    return true
    avg_duration = parseInt(@datePicker.data('avg-duration'))
    if @pickedDate == moment.tz('EST').add(avg_duration, 'm')
      @order_time = @form.find('#order_time')
      #@order_time.html("").html("<%= append_min_time%>")
      return true
    else
      @order_time = @form.find('#order_time')
      #@order_time.html("").html("<%= append_time%>")
      return true

    #if @from.hours() <= @pickedDate.hours() && @pickedDate.hours() <= @to.hours()
    #  return true
    #else
    #  return false

  parseAvailableHours: (from, to) ->
    @from = moment from
    @to = moment to

  eventHandler: ->
    @form.find('.cc-num').payment('formatCardNumber')
    @form.find('.cc-cvc').payment('formatCardCVC')
    @form.find('.cc-exp').payment('formatCardExpiry')

    @btn_new_card.click (e) =>
      e.preventDefault()
      @new_card_conitainer.toggleClass 'hidden'

    @submit_with_stripe.click (e) =>
      e.preventDefault()
      if !@checkAvailableHours()
        notify = new Notify("Please use avaiable hours from #{@from.format('HH:mm')} to #{@to.format('HH:mm')}", 'danger')
        notify.show()
        return
      Stripe.card.createToken(
        number: @form.find('.cc-num').val()
        cvc: @form.find('.cc-cvc').val()
        exp: @form.find('.cc-exp').val()
      @stripeResponseHandler)
      @progress true

    @submit_without_stripe.click (e) =>
      e.preventDefault()
      if !@checkAvailableHours()
        notify = new Notify("Please use avaiable hours from #{@from.format('HH:mm')} to #{@to.format('HH:mm')}", 'danger')
        notify.show()
        return
      @progress true
      url = @form.prop 'action'
      data = @form.serialize()
      @changeFieldsState @form, true
      $.ajax
        url: url
        method: 'POST'
        data: data
        success: @successHandler
        error: (rsp) =>
          notify = @form.find '.process-alert'
          notify.show()
          notify.find('.text-msg').text 'Something goes wrong please comeback later'
          @progress false
          @changeFieldsState @form, false

  stripeResponseHandler: (status, rsp) =>
    if status == 200
      data = @form.serializeArray()
      data.push
        name: "order[card_token]"
        value: rsp.id
      url = @form.prop 'action'
      $.ajax
        url: url
        method: 'POST'
        data: $.param data
        success: @successHandler
        error: (rsp) =>
          notify = @form.find '.process-alert'
          notify.show()
          notify.find('.text-msg').text 'Something goes wrong please comeback later'
          @progress false
          @changeFieldsState @form, false
    else
      @alert.show()
      @alert.find('.alert').text rsp.error.message
      @progress false
      @changeFieldsState @form, false

  successHandler: (data) =>
    @progress false
    @changeFieldsState @form, false
    if !!data.error == false
      window.location = data.success_url
    else
      @notify data.error_html

  errorHandler: (data) =>

  changeFieldsState: (container, state) ->
    container.find('input[type=text], button[type=submit], textarea, button').prop 'disabled', state

  notify: (html) ->
    notify = @form.find '.process-alert'
    notify.html html
    notify.show()

  progress: (state) ->
    @cardProgress = @form.find('.process-progressBar')
    @fader = @form.find('.fader')
    if state
      @cardProgress.show()
      @fader.show()
    else
      @cardProgress.hide()
      @fader.hide()
