class Course < ActiveRecord::Base
  belongs_to :department
  has_many :exams
end
