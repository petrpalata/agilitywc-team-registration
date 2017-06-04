class UserMailer < ActionMailer::Base
  default :from => "teamleaders@agility2017.cz"

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
