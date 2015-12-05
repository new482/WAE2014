class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  include TheRole::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :searchredirect

  def access_denied
    flash[:error] = t('the_role.access_denied')
    redirect_to :back
  end

  before_filter :update_sanitized_params, if: :devise_controller?
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :email, :password)}
  end

  def self.get_current_userid
    return current_user
  end

  def search
    #@courses = Course.all
    #@courses = (!params[:university].blank?)? University.where("id in (" + params[:university] + ")") : University.all
    @courses_json = Course.where("coursename ilike ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: custom_json_for(@courses_json)}
    end
  end

  def custom_json_for(value)
    list = value.map do |course| {
        :id => course.id.to_s,
        :name => course.coursename.to_s
    }
    end
    list.to_json
  end

  def searchredirect
    if (!params[:srch_term].nil?)
      course = Course.find(params[:srch_term]);
      id_department = course.department_id
      department = Department.find(id_department);
      id_school = department.school_id
      redirect = "/exams/" + id_school.to_s + "/" + id_department.to_s + "/"+ params[:srch_term].to_s
      redirect_to redirect
    end
  end
end
