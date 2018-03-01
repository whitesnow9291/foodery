class @Order
  constructor: (@add_btn, @remove_btn_selector, @checkout_container_selector) ->
    @eventHandlers()

  eventHandlers: ->
    @add_btn.click (e) =>
      console.log(e)
      e.preventDefault()
      btn = $(e.currentTarget)
      url = btn.data 'url'
      e.currentTarget.disabled = true
      $.ajax
        method: 'POST'
        url: url
        success: (data) => @success_handler(data, e.currentTarget)

    $(document).off('click', "#{@checkout_container_selector} #{@remove_btn_selector}");
    $(document).on 'click', "#{@checkout_container_selector} #{@remove_btn_selector}", (e) =>
      e.preventDefault()
      btn = $(e.currentTarget)
      url = btn.data 'url'
      $.ajax
        method: 'POST'
        url: url
        success: (data) =>
          if data.html == ''
            $(@checkout_container_selector).trigger 'order-empty', data.url
            $('#bag-order-notification').hide();
            $('#cart-modal').modal('hide');
            $('#mobile-order').hide();

          $(@checkout_container_selector).html data.html
          $('#mobile-order-amount').html data.order_amount
          $('#bag-order-count').html data.order_count

  success_handler: (data, btn = {}) ->
    console.log(data)
    btn.disabled = false
    container = $('.modal-container')
    if !!data.error
      container.html data.modal_html
      $(data.modal_selector).modal 'show'
      new Loader(container)
      return

    if data.is_modal
      container.html data.modal_html
      $(data.modal_selector).modal 'show'
      new Loader(container)
    else
      $('.my-order-box').html data.html
      $('#mobile-order').html data.mobile_html
      $('#bag-order-notification').show()
      if !!data.modal_selector
        $(data.modal_selector).modal 'hide'
