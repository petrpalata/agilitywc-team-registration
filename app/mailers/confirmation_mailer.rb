class ConfirmationMailer < ActionMailer::Base
  default :from => "teamleaders@agility2017.cz"

  def send_confirmation_mail(user, payment)
      @payment = payment
      @user = user
      mail(:to => user.email,
           :subject => t('confirmation.mailer.send_confirmation.subject'))
  end
end
