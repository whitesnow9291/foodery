class Option < ActiveRecord::Base
  belongs_to :option_group
  has_attached_file :image, :styles => { :thumb => "200x" }
  validates_attachment :image, presence: true, content_type: { content_type: "image/jpeg" },  size: { in: 0..2.megabytes }

end

class RemoveImagesAndQtyFromOption < ActiveRecord::Migration
  def change
    Option.find_each { |o| o.image.destroy }
    remove_attachment :options, :image
    remove_column :option_items, :qty
  end
end
