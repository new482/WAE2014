class ContentController < ApplicationController

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
    @exams = Exam.where('course_id = ?', params[:id_course]).order(:year)
    @users = User.all
  end

  def uploadFile

  end

end
