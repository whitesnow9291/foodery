class SessionsController < Devise::SessionsController
  respond_to :json
  prepend_before_action :allow_params_authentication!, only: [:create]

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    if resource.valid?
      if active_order && active_order.can_checkout?
        url = checkout_orders_path
      else
        url = resource.has_role?(:restaurateur) ? restaurateurs_path : request.referer || home_path
      end
      redirect_to url
    end
  end
end
