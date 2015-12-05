class AddCoursecodeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_code, :string
    add_column :courses, :offered_sem, :string
    add_column :courses, :course_type, :string
  end
end
