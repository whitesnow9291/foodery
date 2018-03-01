class OrderCreator
  DIFF_RESTAURANT_ERROR = "Menu item belong to different restauraunt"

  def initialize session, menu_item, options
    @session, @menu_item, @options = session, menu_item, options
  end

  def perform
    Order.transaction do
      process_order_item
    end
    [order, nil]
  rescue OrderCreatorError => e
    [nil, e.message]
  end

  private

  def process_order_item
    raise OrderCreatorError.new DIFF_RESTAURANT_ERROR if order.restaurant && @menu_item.menu.restaurant != order.restaurant
    order_item = OrderItem.create! menu_item: @menu_item, order: order
    add_options order_item
    order_item.save_with_calculation!
    order.save_with_calculation!
  end

  def order
    @order ||= begin
      if @session[:order_id] && (order = Order.active.find_by id: @session[:order_id])
        order
      else
        order = Order.create! restaurant: @menu_item.menu.restaurant
        @session[:order_id] = order.id
        order
      end
    end
  end

  def add_options order_item
    return if @options.blank?
    @options.each do |item|
      option = @menu_item.options.find item[:id].to_i

      #here and in other places i make saving not from build association bcz we calculate prices from tail to head
      #each new price calculation dependent from previous in case of rails as far as i know association saving goes
      #from head to tail
      option_item = order_item.option_items.find_by option: option
      unless option_item
        option_item = OptionItem.create! order_item: order_item, option: option, name: option.name,
                      total_price: option.price
      end
    end
  end
end

class OrderCreatorError < StandardError; end
