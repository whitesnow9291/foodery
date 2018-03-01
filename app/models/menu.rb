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

class Menu < ActiveRecord::Base
  belongs_to :restaurant
  has_many :menu_items, dependent: :destroy
  has_many :options, through: :menu_items

  accepts_nested_attributes_for :menu_items, allow_destroy: true
  accepts_nested_attributes_for :options, allow_destroy: true

  translates :name
end
