# == Schema Information
#
# Table name: option_items
#
#  id            :integer          not null, primary key
#  order_item_id :integer
#  option_id     :integer
#  name          :string
#  total_price   :decimal(5, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OptionItem < ActiveRecord::Base
  belongs_to :option
  belongs_to :order_item
  has_one :order, through: :order_item
end
