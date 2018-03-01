ActiveAdmin.register Menu do

  form do |f|
    f.inputs do
      f.input :restaurant
      f.input :name
    end
    f.inputs 'Menu Items' do
      f.has_many :menu_items, allow_destroy: true, new_record: true do |f|
        f.input :name
        f.input :description
        f.input :price
        if f.object.new_record?
          f.input :image, as: :file
        else
          f.input :image, as: :file, :hint => f.template.image_tag(f.object.image.url(:thumb))
        end

        f.has_many :option_groups, allow_destroy: true, new_record: true do |f|
          f.input :name
          f.input :group_type, as: :select, collection: OptionGroup.group_types.keys

          f.has_many :options, allow_destroy: true, new_record: true do |f|
            f.input :name
            f.input :price
          end
        end
      end
    end
    f.actions
  end

  permit_params :id, :name, :restaurant_id, menu_items_attributes: [:id, :name, :description, :price, :image, :_destroy, :menu_id,
                                            option_groups_attributes: [:id, :name, :group_type, :menu_item_id, :_destroy, options_attributes: [:id, :name, :price, :image, :_destroy, :option_group_id]] ]
end
