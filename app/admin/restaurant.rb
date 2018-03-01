ActiveAdmin.register Restaurant do

  index do
    id_column
    column :name
    column :food_type
    column :address
    column(:hours) { |r| "from #{r.hours_open.utc.to_formatted_s(:time)} to #{r.hours_close.utc.to_formatted_s(:time)}" }
    column :phone
    column :radius
    column :min_order
    column :delivery_fee
    column :avg_delivery_time
    column :fee
    column :created_at
    column :available
    actions
  end

  show do
    attributes_table do
      row :name
      row :food_type
      row :created_at
      row :updated_at
      row :image do |r|
        image_tag r.image.url
      end
      row :address
      row :latitude
      row :longitude
      row :phone
      row :hours_open
      row :hours_close
      row :schedule_info
      row :radius
      row :min_order
      row :delivery_fee
      row :avg_delivery_time
      row :fee
      row :available
      row :user
      row :pdf_file_1 do |r|
        link_to 'PDF 1', r.pdf_file_1.url, target: 'blank' if r.pdf_file_1.exists?
      end

      row :pdf_file_2 do |r|
        link_to 'PDF 2', r.pdf_file_2.url, target: 'blank' if r.pdf_file_2.exists?
      end

      row :pdf_file_3 do |r|
        link_to 'PDF 3', r.pdf_file_3.url, target: 'blank' if r.pdf_file_3.exists?
      end

      row :pdf_file_4 do |r|
        link_to 'PDF 4', r.pdf_file_4.url, target: 'blank' if r.pdf_file_4.exists?
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :food_type
      f.input :tags, as: :select, multiple: :true, collection: ActsAsTaggableOn::Tag.all
      f.input :address
      f.input :hours_open
      f.input :hours_close
      f.input :schedule_info
      f.input :phone
      f.input :radius
      f.input :min_order
      f.input :delivery_fee
      f.input :avg_delivery_time
      f.input :fee
      if f.object.new_record? || f.object.image.blank?
        f.input :image, as: :file
      else
        f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
      end
      f.input :available
    end
    f.actions
  end

  before_create do |restaurant|
    loc = Geocoder.search "#{restaurant.address}, Canada"
    restaurant.address = loc.first.formatted_address
  end

  before_update do |restaurant|
    loc = Geocoder.search "#{restaurant.address}, Canada"
    restaurant.address = loc.first.formatted_address
  end

  controller do
    def update options={}, &block
      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :edit }
      end
    end
  end

  permit_params :name, :food_type, :address, :hours_open, :hours_close, :schedule_info, :phone, :image, :radius, :min_order, :delivery_fee, :avg_delivery_time, :fee,  :available, tag_ids: []

 end