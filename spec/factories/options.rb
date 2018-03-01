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

FactoryGirl.define do
  factory :option do
    image { File.new("#{Rails.root}/spec/fixtures/images/edamame.jpg") }
  end
end
