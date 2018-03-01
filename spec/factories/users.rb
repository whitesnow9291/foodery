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
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    password 'test@test'
  end
end

