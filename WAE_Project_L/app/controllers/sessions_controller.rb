class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    if current_user.role_id == 3
    sign_out resource
    flash[:error] = "This account has been banned"
    unauthenticated_root_path
    else
     super
    end
  end

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end


#credit : http://stackoverflow.com/questions/5629480/rails-devise-is-there-a-way-to-ban-a-user-so-they-cant-login-or-reset-their