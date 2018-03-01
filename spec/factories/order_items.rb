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

FactoryGirl.define do
  factory :order_item do
    total_price 10.99
  end
end
