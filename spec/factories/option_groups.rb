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

FactoryGirl.define do
  factory :option_group do
    references ""
    string ""
    string ""
  end
end
