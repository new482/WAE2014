class Department < ActiveRecord::Base
  belongs_to :school
  has_many :courses
end
