# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.count == 0
  user = User.create! name: 'test', email: 'admin@admin.com', password: 'admin@admin.com', password_confirmation: 'admin@admin.com'
  user.add_role :admin
  user = User.create! name: 'test',  email: 'test@test.com', password: 'test@test.com', password_confirmation: 'test@test.com'
  restaurateur = User.create! name: 'test',  email: 'test_restaurateurs@test.com', password: 'test_restaurateurs@test.com', password_confirmation: 'test_restaurateurs@test.com'
  restaurateur.add_role :restaurateur
end

# Tags
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Free Delivery'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Salads'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Italian'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Healthy'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Pasta'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Pizza'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Dessert'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Breakfast'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Sandwiches'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Mediterranean'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Vegan'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Vegetarian'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Gluten Free'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Asian'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Mexican'
ActsAsTaggableOn::Tag.find_or_create_by! name: 'Pastries'
