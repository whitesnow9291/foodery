class WebhookEventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  respond_to :json

  def create
    case event_type
    when "charge.succeeded"
      @object = data_params[:object]
      @order = Order.find_by_id @object[:metadata][:order_id] rescue nil

      if @order && charge! == "succeeded"
        @order.checkout
        @order.save
      end
    end

    render nothing: true, status: 200
  end

  private

    def event_type
      params[:type]
    end

    def data_params
      params.fetch(:data, {}).deep_symbolize_keys
    end

    def charge!
      stripe = Stripe::Charge.retrieve(@object[:id])
      stripe.as_json.deep_symbolize_keys[:status]
    end
end
