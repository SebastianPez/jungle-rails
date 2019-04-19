class UserMailer < ApplicationMailer
  default from: 'noreply@jungle.com'

  def order_receipt(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Thank you for ordering with Jungle! Your order id: #{@order.id}")
  end
end
