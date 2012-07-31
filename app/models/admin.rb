class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def create!
      super
      welcome_message
  end
  
  def create
      super
      welcome_message
  end

  def superadmin?
      false
  end

  def admin?
      true
  end

  private 

  def welcome_message
      UserMailer.admin_welcome_message(self).deliver
  end
end
