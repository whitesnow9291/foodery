# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_customer_id     :string
#  last4                  :string
#  stripe_uid             :string
#  stripe_access_code     :string
#  stripe_publishable_key :string
#  name                   :string
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :orders
  has_many :restaurants, dependent: :destroy
  accepts_nested_attributes_for :restaurants, allow_destroy: true

  scope :admins, -> { Role.find_by(name: 'admin')&.users }

  validates :name, presence: true

  def last_order
    orders.order('created_at desc').limit 1
  end

  def remove_stripe_connect
    self.transaction do
      self.update! stripe_uid: nil, stripe_access_code: nil, stripe_publishable_key: nil
      restaurants.each do |restaurant|
        restaurant.update! available: false
      end
    end
  end

  def total_orders
    Order.inactive.where(restaurant: restaurants.pluck(:id)).count
  end

  def total_revenue
    Order.inactive.where(restaurant: restaurants.pluck(:id)).sum :total_price
  end

  def today_revenue
    Order.inactive.where(restaurant: restaurants.pluck(:id)).where('created_at >= ?', Time.now.beginning_of_day).sum :total_price
  end

end
