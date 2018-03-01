# == Schema Information
#
# Table name: option_groups
#
#  id           :integer          not null, primary key
#  menu_item_id :integer
#  name         :string
#  group_type   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe OptionGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
