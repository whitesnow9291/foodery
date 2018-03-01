class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        #if the user came from order page
        if active_order && active_order.can_checkout?
          url = checkout_orders_path
        else
          url = home_path
        end
        render json: { location: url }, status: :ok
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def new_restaurateur
    @user = User.new
  end

  def edit
    if current_user.has_role? :restaurateur
      render 'restaurateurs/edit'
    else
      render :edit
    end
  end

  def create_restaurateur
    @user = User.new sign_up_params
    if @user.save
      @user.add_role :restaurateur
      sign_in @user
      redirect_to restaurateurs_path
    else
      render :new_restaurateur
    end
  end

  protected

  def after_update_path_for(resource)
    home_path
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
