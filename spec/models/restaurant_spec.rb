# == Schema Information
#
# Table name: restaurants
#
#  id                      :integer          not null, primary key
#  name                    :string
#  food_type               :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  image_file_name         :string
#  image_content_type      :string
#  image_file_size         :integer
#  image_updated_at        :datetime
#  address                 :string
#  latitude                :float
#  longitude               :float
#  phone                   :string
#  radius                  :integer          default(0)
#  min_order               :decimal(, )      default(0.0), not null
#  delivery_fee            :decimal(, )      default(15.0)
#  avg_delivery_time       :integer          default(30)
#  fee                     :decimal(8, 2)    default(0.05)
#  available               :boolean          default(FALSE)
#  user_id                 :integer
#  pdf_file_1_file_name    :string
#  pdf_file_1_content_type :string
#  pdf_file_1_file_size    :integer
#  pdf_file_1_updated_at   :datetime
#  pdf_file_2_file_name    :string
#  pdf_file_2_content_type :string
#  pdf_file_2_file_size    :integer
#  pdf_file_2_updated_at   :datetime
#  pdf_file_3_file_name    :string
#  pdf_file_3_content_type :string
#  pdf_file_3_file_size    :integer
#  pdf_file_3_updated_at   :datetime
#  pdf_file_4_file_name    :string
#  pdf_file_4_content_type :string
#  pdf_file_4_file_size    :integer
#  pdf_file_4_updated_at   :datetime
#  hours_open              :time             default(2000-01-01 15:00:00 UTC)
#  hours_close             :time             default(2000-01-01 23:00:00 UTC)
#

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
