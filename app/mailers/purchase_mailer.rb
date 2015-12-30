class PurchaseMailer < ActionMailer::Base
  default from: "no-reply@kayaactive.com.au"

  def confirmation(purchase)

    attachments.inline['image.jpg'] = File.read(File.join(Rails.root,'/public/email_image.png'))

    @purchase = purchase
    mail(to: @purchase.email_address, subject: 'Your order with KayaActive.com.au')
  end
end
