# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  status                :string
#  delivery_address      :string
#  latitude              :float
#  longitude             :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  first_name            :string
#  last_name             :string
#  phone                 :string
#  postal_code           :string
#  delivery_time         :datetime
#  delivery_instructions :text
#  total_price           :decimal(5, 2)
#  restaurant_id         :integer
#

class Order < ActiveRecord::Base
  include AASM
  default_scope { order(created_at: :desc) }
  scope :inactive, -> { where.not(:status=> 'active') }
  attr_accessor :active_admin_requested_event, :date, :time

  belongs_to :user
  belongs_to :restaurant

  has_many :order_items, dependent: :destroy
  has_many :option_items, through: :order_items

  validate :valid_delivery_time

  scope :upcoming, -> { where('delivery_time > ?', Time.now) }
  scope :past, -> { where('delivery_time < ?', Time.now) }

  aasm column: :status do
    state :active, initial: :true
    state :checkout
    state :confirmed
    state :delivered
    state :refunded

    event :checkout do
      transitions from: :active, to: :checkout
    end

    event :confirm do
      transitions from: :checkout, to: :confirmed
    end

    event :deliver do
      transitions from: :confirmed, to: :delivered
    end

    event :refund do
      transitions from: [:checkout, :confirmed], to: :declined
    end
  end

  def can_checkout?
    restaurant.min_order <= order_items.sum(:total_price)
  end

  def save_with_calculation!
    calculate_total_price
    save!
  end

  def delivery_day
    delivery_time.utc.strftime "%F"
  end

  def delivery_hours
    delivery_time.utc.strftime "%H:%M"
  end

  def human_status
    ""
  end

  def address_1
    if delivery_address
      result, _ = delivery_address.split("\n")
      result
    end
  end

  def address_2
    if delivery_address
      _, result = delivery_address.split("\n")
      result
    end
  end

  def total_price_with_tax
    total_price + total_price * 0.14975
  end

  def price_without_fee
    return 0
  end

  private

  def calculate_total_price
    self.total_price = order_items.sum(:total_price) + restaurant.delivery_fee
  end

  def valid_delivery_time
    return true unless delivery_time
    valid = delivery_time >= (Time.zone.now + restaurant.avg_delivery_time*60)
    self.errors.add(:delivery_time, "is too soon.") unless valid
  end
end
