class ConfirmationMailer < ActionMailer::Base
  default :from => "orders@agility2012.cz"

  def send_confirmation_mail(user, payment)
      @payment = payment
      @user = user
      mail(:to => user.email,
           :subject => t('confirmation.mailer.send_confirmation.subject'))
  end
end
