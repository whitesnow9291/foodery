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

class MenuItem < ActiveRecord::Base
  belongs_to :menu
  has_many :option_groups, dependent: :destroy
  has_many :options, through: :option_groups, source: :options

  has_attached_file :image, :styles => { :medium => "512x", :thumb => "100x" }
  validates_attachment :image, content_type: { content_type: "image/jpeg" },  size: { in: 0..2.megabytes }

  accepts_nested_attributes_for :option_groups, :options, allow_destroy: true

  translates :name, :description
end
