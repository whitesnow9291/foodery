class OrdersController < ApplicationController
  before_action :check_location, except: [:show]
  before_action :check_params, only: [:process_order]

  def index
    @orders = Order.inactive.where(user_id: current_user.id)
      .order(created_at: :desc)
  end

  def upcoming
    @orders = current_user.orders.inactive.upcoming
    render :index
  end

  def past
    @orders = current_user.orders.inactive.past
    render :index
  end

  def show
    @order = Order.find params[:id]
  end

  def add_item
    @menu_item = MenuItem.find params[:id]
    @with_option = @menu_item.options.count > 0
    item_count = (params[:count] || 1).to_i
    return if @with_option && params[:options].nil?
    return if item_count < 1

    item_count.times do
      order_creator = OrderCreator.new session, @menu_item, params[:options]
      @order, @err = order_creator.perform
    end
  end

  def remove_item
    @removeable_item = OptionItem.where(id: params[:option_item]) if params[:option_item]
    @removeable_item = OrderItem.where(id: params[:order_item]) unless params[:option_item]
    @menu_item = MenuItem.find params[:id]
    @checkout_page = params[:checkout_page] == 'true'
    @show_checkout = params[:show_checkout] == 'true'
    @grouped = params[:grouped]
    order_item_remover = OrderItemRemover.new active_order, @menu_item, @grouped, @removeable_item
    @order = order_item_remover.process
  end

  def checkout
    redirect_to restaurants_path unless current_user && active_order && active_order.can_checkout?
  end

  def process_order
    address = [process_params[:delivery_address_1], process_params[:delivery_address_2]].join "\n"
    postal_code = session[:postal_code]
    active_order.update! first_name: process_params[:first_name], last_name: process_params[:last_name], delivery_address: address,
      postal_code: postal_code, phone: process_params[:phone], delivery_instructions: process_params[:delivery_instructions],
      delivery_time: Time.zone.parse("#{process_params[:date]} #{process_params[:time]}")
     #delivery_time: Time.zone.strftime("#{process_params[:date]} #{process_params[:time]}", '%Y-%m-%d %H:%M:%S')
    order_processor = OrderProcessor.new current_user, active_order

    @order, @err = order_processor.process *@processor_args
    session[:order_id] = @order.id
  end

  def success
    @order = Order.checkout.find session[:order_id]
  end

  def remove_active_order
    active_order.destroy
    session[:order_id] = nil
    head :ok
  end

  private

  def process_params
    params.require(:order).permit(:email, :card_token, :first_name, :last_name, :postal_code,
                                  :phone, :delivery_time, :delivery_instructions, :delivery_address_1, :delivery_address_2, :date, :time)
  end

  def check_params
    raise 'No active order' unless active_order
    if current_user && current_user.last4 && process_params[:card_token].blank?
      @processor_args = [:with_user]
      return
    end

    if current_user && !current_user.stripe_customer_id && !process_params[:card_token].blank?
      @processor_args = [:with_user_and_card, process_params[:card_token]]
      return
    end

    if current_user && current_user.stripe_customer_id && !process_params[:card_token].blank?
      @processor_args = [:with_user_and_card_update, process_params[:card_token]]
      return
    end

    if !process_params[:card_token].blank?
      @processor_args = [:without_user, process_params[:card_token]]
      return
    end

    # now, only signed in users are allowed to pay
    # if !process_params[:card_token].blank?
    #   @processor_args = [:without_user, process_params[:card_token]]
    #   return
    # end

    raise 'No charge type set'
  end

end
