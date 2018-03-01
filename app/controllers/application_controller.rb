class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :active_order, :render_to_string
  before_action :set_locale
  after_filter :set_csrf_cookie_for_ng

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    redirect_to home_url
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def authenticate_active_admin_user!
      authenticate_user!
      unless current_user.has_role? :admin
          flash[:alert] = I18n.t "unauthorized_access"
          redirect_to home_path
      end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def active_order
    @active_order ||= begin
      if session[:order_id]
        Order.active.find_by id: session[:order_id]
      end
    end
  end

  private

  def check_location
    if request.method.downcase != 'get'
      redirect_to home_path, notice: I18n.t('location.set_long') unless session[:address]
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(_resource_or_scope)
    home_path
  end
  protected

  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
end
