class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :country_id, :role
  as_enum :role, [:superadmin, :admin, :user]

  validates_as_enum :role
  validates_presence_of :country_id if :role == :user

  def create!
      super
      send_welcome_message
  end

  def create
      super
      send_welcome_message
  end

  def update_password(password)
      self.password = password
      self.password_confirmation = password
      update
      send_welcome_message
  end

  private

  def send_welcome_message
      if self.role == :admin
          admin_welcome_message
      elsif self.role == :user
          welcome_message
      end
  end
  
  def welcome_message
      UserMailer.welcome_message(self).deliver
  end

  def admin_welcome_message
      UserMailer.admin_welcome_message(self).deliver
  end
end
