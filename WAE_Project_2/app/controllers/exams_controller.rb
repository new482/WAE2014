class ExamsController < ApplicationController
  # GET /members/new

  before_filter :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :login_required, only: [:edit, :update, :destroy]
  #before_action :role_required, only: [:info]
  before_action :set_exam, only: [ :update, :destroy]

  def info
    @exams = Exam.where(:accepted => false)
    @users = User.all
    @deps = Department.all
    @courses = Course.all
    @schools = School.all
  end

  def home
    @schools = School.all.order(:schoolname)
  end

  def department
    @school = School.find(params[:id_school])
    @departments = Department.where('school_id = ?', params[:id_school]).order(:departmentname);
  end

  def course
    @school = School.find(params[:id_school])
    @department = Department.find(params[:id_department])
    @courses = Course.where('department_id = ?', params[:id_department]).order(:coursename)
  end

  def files
    @school = School.find(params[:id_school])
    @department = Department.find(params[:id_department])
    @courses = Course.find(params[:id_course])
    if user_signed_in?
      @exams = Exam.where('course_id = ?', params[:id_course]).order(:year)
    else
      @exams = Exam.where('course_id = ? AND accepted = ?', params[:id_course],true).order(:year)
    end

    @users = User.all
  end

  def new
    @course_id = params[:course_id]
    @exam = Exam.new

    @course = Course.find(params[:id_course])
    @department = Department.find(params[:id_department])
    @school = School.find(params[:id_school])
  end

  def edit
    if params[:accept] == '1'
      Exam.find(params[:id]).update_attribute('accepted', true)
      Exam.find(params[:id]).update_attribute('acceptedby', params[:acceptedby])
      @notice = 'Post Accepted'
    elsif params[:accept] == '0'
      exam = Exam.find(params[:id])
      File.delete(Rails.root.join('public', 'data', exam.path))
      exam.delete()
      @notice = 'Post Rejected'
    elsif params[:delete] == '1'
      exam = Exam.find(params[:id])
      File.delete(Rails.root.join('public', 'data', exam.path))
      exam.delete()
      @notice = 'Post Deleted'
  end
    redirect_to :back, notice: @notice
  end

  def create
    course = Course.find(params[:course_id]);
    id_department = course.department_id
    department = Department.find(id_department);
    id_school = department.school_id
    redirect_error = "/exams/" + id_school.to_s + "/" + id_department.to_s + "/"+ params[:course_id].to_s + "/new"
    redirect_success = "/exams/" + id_school.to_s + "/" + id_department.to_s + "/"+ params[:course_id].to_s

    if current_user.role_id == 1
      @isadmin = true
    else
      @isadmin = false
    end

    if params[:file].nil?
      redirect_to redirect_error , notice: 'You need to choose a file'
    else
      file = params[:file]
      @exam = Exam.new(exam_params)
      respond_to do |format|
        if @exam.save
          #File.open(Rails.root.join('public', 'data', @exam.path), 'wb') do |f|
          File.open(Rails.root.join('app', 'assets/data', @exam.path), 'wb') do |f|
            if file
              f.write(file.read)
            end
          end
          if (current_user.role_id == 1)
            format.html { redirect_to redirect_success , notice: 'File will successfully uploaded' }
          else
            format.html { redirect_to redirect_success , notice: 'File will be upload depending upon admin approval' }
          end
          format.json { render :show, status: :created, location: @exam }
        else
          format.html { redirect_to redirect_error, alert: @exam.errors.full_messages.first }
          format.json { render json: @exam.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exam
    @exam = Exam.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def exam_params
    params[:exam]
    params.permit(:file, :posttype, :year, :user_id, :course_id, :examtype, :accepted, :acceptedby)
  end


end
