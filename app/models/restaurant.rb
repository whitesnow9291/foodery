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
#  schedule_info           :string
#

class Restaurant < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :menus, dependent: :destroy
  has_many :menu_items, through: :menus

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates :name, :food_type, :address, :phone, :hours_open, :hours_close, presence: true
  # validates :fee, numericality: { only_float: true, greater_than: 0.0, less_than: 1.0 }
  validates_inclusion_of :fee, in: 0..1

  scope :available, ->{ where(available: true) }

  has_attached_file :image, :styles => { :medium => "512x", :thumb => "100x" }
  validates_attachment :image, presence: true, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png'] },  size: { in: 0..2.megabytes }

  has_attached_file :pdf_file_1
  validates_attachment :pdf_file_1, content_type: { content_type: 'application/pdf' },  size: { in: 0..15.megabytes }

  has_attached_file :pdf_file_2
  validates_attachment :pdf_file_2, content_type: { content_type: 'application/pdf' },  size: { in: 0..15.megabytes }

  has_attached_file :pdf_file_3
  validates_attachment :pdf_file_3, content_type: { content_type: 'application/pdf' },  size: { in: 0..15.megabytes }

  has_attached_file :pdf_file_4
  validates_attachment :pdf_file_4, content_type: { content_type: 'application/pdf' },  size: { in: 0..15.megabytes }

  translates :name, :food_type, :schedule_info

  def distance lat, lon
    return I18n.t 'distance.fail' unless lat && lon
    distance = Geocoder::Calculations.distance_between [self.latitude, self.longitude], [lat,lon], units: :km
    distance.to_i
  end

  def hours
    "#{hours_open.utc.to_formatted_s(:time)} - #{hours_close.utc.to_formatted_s(:time)}"
  end

  def address_short
    return "" if address.blank?
    address.split(',')[0]
  end
end
