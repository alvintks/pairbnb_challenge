class UserMailer < ApplicationMailer
  default from: 'alvintankuansean@gmail.com'

  def notify(user)
    @user = user
    mail(to: @user.email, subject: "Notification")
  end
end