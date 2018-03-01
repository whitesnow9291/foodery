class AddTranslationsToOptions < ActiveRecord::Migration
  def up
  	remove_column :options, :description
    Option.create_translation_table! name: :string
    OptionGroup.create_translation_table! name: :string
  end

  def down
    Option.drop_translation_table!
    OptionGroup.drop_translation_table!
  end
end
