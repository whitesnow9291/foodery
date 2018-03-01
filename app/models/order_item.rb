# == Schema Information
#
# Table name: order_items
#
#  id           :integer          not null, primary key
#  order_id     :integer
#  menu_item_id :integer
#  total_price  :decimal(5, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class OrderItem < ActiveRecord::Base
  default_scope { order('created_at asc') }
  belongs_to :order
  belongs_to :menu_item
  has_many :option_items
  has_many :option_groups, through: :menu_item

  validates :order, :menu_item, presence: true

  def save_with_calculation!
    calculate_total_price
    save!
  end

  def get_unique_menu_item_with_options
    # this is used to return a list of all order_items that have the same menu_item_id and the exact same option_items
    order = self.order
    order_item_ids = (order.order_items.where(menu_item_id: self.menu_item_id).collect{|c| c.id if c.option_items.sort.collect{|c| c.option_id} == self.option_items.sort.collect{|c| c.option_id}} || nil)
    return order.order_items.where(id: order_item_ids)
  end

  private

  def calculate_total_price
    self.total_price = menu_item.price + option_items.sum(:total_price)
  end

end
