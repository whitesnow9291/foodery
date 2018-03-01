if @err.blank?
  is_modal = @with_option && @order.blank?
  json.is_modal is_modal
  modal_selector = 'menuItem-withOption-modal'

  if is_modal
    json.modal_selector "##{modal_selector}"
    modal_body = render partial: 'checkout_with_option.html.erb', locals: { menu_item: @menu_item }
    modal_header = render_to_string partial: 'checkout_header.html.erb', locals: { menu_item: @menu_item }

    json.modal_html render partial: 'shared/modal.html.slim', locals: { modal_name: modal_selector, modal_header: modal_header, modal_body: modal_body }
  else
    json.modal_selector "##{modal_selector}"
    json.html render partial: 'orders/checkout.html.erb', locals: { order: @order, show_checkout: true, checkout_page: false }
    json.mobile_html render partial: 'orders/checkout_mobile.html.erb', locals: { order: @order, show_checkout: true, checkout_page: false }
  end
else
  if @err == OrderCreator::DIFF_RESTAURANT_ERROR
    modal_body = render_to_string partial: 'diff_restaurant_error.html.slim', locals: { order: active_order }
    modal_selector = 'remove-activeOrder-modal'

    json.error @err.to_s
    json.modal_selector "##{modal_selector}"
    json.modal_html render partial: 'shared/modal.html.slim', locals: { modal_name: modal_selector, modal_header: 'Order', modal_body: modal_body }
  end
end
