ActiveAdmin.register Order do
  scope :inactive, -> { where.not(:status=> 'active') } , default: true

  after_save do |order|
    event = params[:order][:active_admin_requested_event]
    unless event.blank?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise "Forbiden event #{event} request on instance #{order.id}" unless safe_event
      order.send "#{safe_event}!"
    end
  end

  show do
    #attributes_table *default_attribute_table_rows << :tax_price, :total_price_with_tax
    attributes_table do
      row :id
      row :status
      row :delivery_address
      row :latitude
      row :longitude
      row :created_at
      row :updated_at
      row :first_name
      row :last_name
      row :phone
      row :postal_code
      row "Delivery Time" do |order|
        #abort(order.delivery_hours.inspect)
     		 order.delivery_day + ' ' + "#{order.delivery_time.hour}" + ":" + "#{order.delivery_time.min}"
     	 end
      # column :delivery_time
      row :delivery_instructions
      row :total_price
      row :total_to_restaurant
    end
    panel 'Details' do
      render partial: 'details', locals: { order: order }
    end
  end

  index do
    column :id
    column :status
    column :delivery_address
    column :latitude
    column :longitude
    column :created_at
    column :updated_at
    column :first_name
    column :last_name
    column :phone
    column :postal_code
    column "Delivery Time" do |order|
      #abort(order.delivery_hours.inspect)
   		 span "#{order.delivery_time.hour}" + ":" + "#{order.delivery_time.min}" + " on " + "#{order.delivery_day}", :style=>"width:150px;float:left;"
   	 end
    # column :delivery_time
    column :delivery_instructions
    column :total_price
    column :total_to_restaurant
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :phone
      f.input :status, input_html: { disabled: true }, label: 'Current state'
      f.input :active_admin_requested_event, label: 'Change state', as: :select, collection: f.object.aasm.events(permitted: true).map(&:name)
    end
    f.actions
  end

  permit_params :user_id, :status, :delivery_address, :first_name, :last_name, :phone, :postal_code, :delivery_time, :delivery_instructions, :active_admin_requested_event, :total_to_restaurant
end
