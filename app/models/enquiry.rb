class Enquiry < ActiveRecord::Base

  belongs_to :product

  validates :name, presence: true
  validates :message, presence: true

  def message
    super || default_message
  end

private
  def default_message
    <<-eos
Hi Kaya,
I'm interested in the "#{product.name}"

How can I get hold of these beautiful #{product.category}?
    eos
  end
end