class AddTranslationTables < ActiveRecord::Migration
  def up
    Restaurant.create_translation_table! name: :string, food_type: :string
    Menu.create_translation_table! name: :string
    MenuItem.create_translation_table! name: :string, description: :string
  end

  def down
    Restaurant.drop_translation_table!
    Menu.drop_translation_table!
    MenuItem.drop_translation_table!
  end
end