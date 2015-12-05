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
end


#credit : http://stackoverflow.com/questions/5629480/rails-devise-is-there-a-way-to-ban-a-user-so-they-cant-login-or-reset-their