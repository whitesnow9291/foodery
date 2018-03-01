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

class OptionGroup < ActiveRecord::Base
  has_many :options, dependent: :destroy
  belongs_to :menu_item

  enum group_type: {single: 'single', multi: 'multi'}

  accepts_nested_attributes_for :options, allow_destroy: true

  translates :name
end
