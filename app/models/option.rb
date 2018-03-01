# == Schema Information
#
# Table name: options
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  price           :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  option_group_id :integer
#

class Option < ActiveRecord::Base
  belongs_to :option_group
  has_one :option_item

  translates :name
end
