$(document).on 'turbolinks:load', ->
  $.fn.editable.defaults.mode = 'inline'
  @loc = new Location $('#set-location'), $('#current-location-header')
  @order = new Order $('.menu-item-checkout button'), '.product-item button.remove-product-btn', '.my-order-box'
  @checkout = new Checkout $('.nav-orders-checkout'), $('.my-order-box')
  @cart = new Cart $('#checkout-form')
  @tag = new Tag $('.tags_select'), $('#restaurantList')
  @loader = new Loader

  if window.clickBack
    $('#cart-modal').hide();
    $('.modal-backdrop').remove();
    $('body').removeClass('modal-open');
    window.clickBack = false

  if ($(window).width() <= 991)
    placement = 'bottom'
  else
    placement = 'right'

  $("span[data-toggle='tooltip']").tooltip(
    placement: placement
  )

$(window).on 'popstate', (event) ->
  window.clickBack = true
