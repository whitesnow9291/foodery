class PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { result: I18n.t("devise.passwords.send_instructions") }, status: :ok
    else
      render json: { result: I18n.t("login.couldnt_send_email") }, status: :ok
    end
  end
end
