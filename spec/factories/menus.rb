# == Schema Information
#
# Table name: menus
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :menu do
    
  end
end
