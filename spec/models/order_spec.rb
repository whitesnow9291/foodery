# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  status                :string
#  delivery_address      :string
#  latitude              :float
#  longitude             :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  first_name            :string
#  last_name             :string
#  phone                 :string
#  postal_code           :string
#  delivery_time         :datetime
#  delivery_instructions :text
#  total_price           :decimal(5, 2)
#  restaurant_id         :integer
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
