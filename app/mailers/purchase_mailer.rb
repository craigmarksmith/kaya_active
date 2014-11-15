class PurchaseMailer < ActionMailer::Base
  default from: "no-reply@kayaactive.com.au"

  def confirmation(purchase)
    @purchase = purchase
    mail(to: @purchase.email_address, subject: 'Your order with KayaActive.com.au')
  end
end
