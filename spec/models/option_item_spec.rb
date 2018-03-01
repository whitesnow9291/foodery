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

require 'rails_helper'

RSpec.describe OptionItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
