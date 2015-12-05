class ApplicationController < ActionController::Base
  include TheRole::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def access_denied
    flash[:error] = t('the_role.access_denied')
    redirect_to :back
  end

<<<<<<< HEAD
  def home

  end

=======
>>>>>>> ec4ed160773dfdd524d9a2b1eef044bb87c83645
end
