class Vendor < ApplicationRecord
  has_many :orders
  has_many :contacts
end
