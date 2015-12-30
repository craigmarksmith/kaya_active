class PurchasePreview < ActionMailer::Preview
  def confirmation

    PurchaseMailer.confirmation(Purchase.last)
  end
end