# == Schema Information
#
# Table name: menu_items
#
#  id                 :integer          not null, primary key
#  menu_id            :integer
#  name               :string
#  description        :text
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  price              :decimal(8, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :menu_item do
    image { File.new("#{Rails.root}/spec/fixtures/images/edamame.jpg") }
    price 10.99
  end
end
