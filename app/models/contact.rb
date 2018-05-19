class Contact < ApplicationRecord
  belongs_to :vendor, optional: true
  has_many :orders

  def full_name_and_company
    if first_name && last_name
      first_name + " " + last_name + " (" + self.vendor.name + ")"
    end
  end
end
