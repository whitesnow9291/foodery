class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    if current_user.update_attributes({
      stripe_uid: request.env["omniauth.auth"].uid,
      stripe_access_code: request.env["omniauth.auth"].credentials.token,
      stripe_publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
    })
      redirect_to restaurateur_restaurants_path, notice: 'Stripe Connect OAuth success'
    else
      redirect_to restaurateur_restaurants_path, notice: 'Stripe Connect OAuth fail'
    end
  end

end

