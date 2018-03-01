class OrderItemRemover
  include ActiveModel::Validations
  validate :validation

  def initialize order, menu_item, grouped, removeable_item
    @order, @menu_item, @grouped, @removeable_item = order, menu_item, grouped, removeable_item
  end

  def process
    validate
    Order.transaction do
      process_remove_order_item
    end
  end

  private

  def process_remove_order_item
    if @removeable_item.class == OptionItem || OptionItem::ActiveRecord_Relation
      @removeable_item.destroy_all
    else
      @order_item =
        if @grouped.is_a?(Array)
          @order.order_items.find do |i|
            i.option_items.pluck(:option_id).sort.join('_') == @grouped.sort.join('_') &&
              i.menu_item_id == @menu_item.id
          end
        else
          @order.order_items.find do |i|
            i.option_items.blank? &&
              i.menu_item_id == @menu_item.id
          end
        end

      if @order_item
        @order_item.destroy
      end
    end

    @order.order_items.reload

    if @order.order_items.count == 0
      @order.destroy
      return nil
    end
    @order.save_with_calculation!
    return @order
  end

  def validation
    errors.add :order, 'Order is nil', strict: true unless @order
    errors.add :menu_item, 'Menu item is nil', strict: true unless @menu_item
  end
end
