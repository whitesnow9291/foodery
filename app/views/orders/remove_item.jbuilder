if @order
  json.html render partial: 'orders/checkout.html.erb', locals: { order: @order, show_checkout: @show_checkout, checkout_page: @checkout_page }
  json.order_amount number_to_currency(@order.total_price_with_tax, unit: "$", separator: ".", format: "%u%n")
  json.order_count @order ? @order.order_items.count.to_s : '0'
else
  json.html ''
  json.order_amount number_to_currency(0, unit: "$", separator: ".", format: "%u%n")
  json.order_count '0'
  json.url "#{restaurant_path @menu_item.menu.restaurant}"
end
