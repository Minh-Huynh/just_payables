class Payable < ApplicationRecord
  include Filterable
  belongs_to :order

  def paid?
    !!paid_on.present?
  end

  def self.by_due_date(month_and_year)
    date = month_and_year.split("-")
    where('extract(month from due_on) = ? AND
         extract(year from due_on) = ?', date[0], date[1])
  end

  def self.search(term)
    term = term.downcase if term
    Payable.joins(:order).where("orders.description ILIKE :term 
                  OR orders.invoice_number ILIKE :term 
                  OR orders.vendor ILIKE :term 
                  OR orders.contact ILIKE :term 
                  OR orders.show ILIKE :term", 
                  term: "%#{term}%")
  end
end