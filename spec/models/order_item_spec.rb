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

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
