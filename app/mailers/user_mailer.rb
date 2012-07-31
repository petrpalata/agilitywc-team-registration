class UserMailer < ActionMailer::Base
  default :from => "orders@agility2012.cz"

  def welcome_message(user)
      @user = user
      mail(:to => user.email,
           :subject => t('user.mailer.welcome_message.subject'))
  end

  def admin_welcome_message(user)
      @user = user
      mail(:to => user.email,
           :subject => t('user.mailer.admin_welcome_message.subject'))
  end
end
