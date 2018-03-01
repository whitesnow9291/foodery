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

require 'rails_helper'

RSpec.describe Option, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
