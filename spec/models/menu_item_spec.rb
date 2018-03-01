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

require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
