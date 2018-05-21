class Order < ApplicationRecord
  include Filterable
  validates :order_amount, presence: true
  before_save :process_order
   
  def process_order
    if received_on.present? && term
      self.due_on = received_on + term.days
    end
    self.order_amount_with_shipping = order_amount_with_shipping_added
  end

  def self.term_options
    self.terms.map {|k,_| [k, k]}
  end

  def self.by_due_date(month_and_year)
    date = month_and_year.split("-")
    where('extract(month from due_on) = ? AND
         extract(year from due_on) = ?', date[0], date[1])
  end

  def self.by_ordered_date(month_and_year)
    date = month_and_year.split("-")
    where('extract(month from created_at) = ? AND
         extract(year from created_at) = ?', date[0], date[1])
  end

  def self.by_ship_date(month_and_year)
    date = month_and_year.split("-")
    where('extract(month from ship_on) = ? AND
         extract(year from ship_on) = ?', date[0], date[1])
  end

  def order_amount_with_shipping_added
    if shipping_percentage == 0 || shipping_percentage.nil?
      order_amount
    else
      order_amount * (1 + (shipping_percentage/100))
    end
  end

  def paid?
    !paid_on.nil?
  end

  def received?
    !!received_on
  end

  def past_due?
    due_on <= Date.today if due_on.present?
  end

  def due_this_month?
    due_on.month == Date.today.month if due_on.present?
  end

  def self.search(term)
    term = term.downcase if term
    Order.where("description ILIKE :term 
                  OR invoice_number ILIKE :term 
                  OR vendor ILIKE :term 
                  OR contact ILIKE :term 
                  OR show ILIKE :term", 
                  term: "%#{term}%")
  end
end
