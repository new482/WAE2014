class User < ActiveRecord::Base
  has_many :exams

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable,:omniauth_providers => [:facebook]

  include TheRole::User
  before_create :setRole

  def setRole
    self.role_id = 2
  end

##------------------------Facebook Authentication------------------------##
  ## Method 1 required
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid:auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        #user.save!
      end 
  end
  ## Method 2 required
  def self.new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
  end
##-----------------------------------------------------------------------##

end
