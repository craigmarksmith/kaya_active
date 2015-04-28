class Signup < ActiveRecord::Base
  validates :email_address, :email => true, uniqueness: true
end