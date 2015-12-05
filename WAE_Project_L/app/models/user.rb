class User < ActiveRecord::Base
  has_many :exams

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable

  include TheRole::User
  before_create :setRole

  def setRole
    self.role_id = 2
  end
end
