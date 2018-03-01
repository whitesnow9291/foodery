class AddTranslationsToScheduleInfo < ActiveRecord::Migration
  def up
  	Restaurant.add_translation_fields! schedule_info: :string
  end

  def down
  	remove_column :restaurant_translations, :schedule_info
  end
end
