class UserMailer < ApplicationMailer
  default from: 'noreply@jungle.com'

  def order_receipt(user)
    @user = user
    mail(to: @user.email, subject: 'Thank you for ordering with Jungle!')
  end
end
