class ApplicationController < ActionController::Base
  include TheRole::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def access_denied
    flash[:error] = t('the_role.access_denied')
    redirect_to :back
  end

  before_filter :update_sanitized_params, if: :devise_controller?
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password)}
  end

end
