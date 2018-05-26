class Order < ApplicationRecord
  include Filterable
  has_one :payable
  validates :order_amount, presence: true
  validates :term, presence: true
  after_create :create_associated_payable
  after_save :process_order
  before_save :update_order_amount
   
  def process_order
    if received_on.present?
      self.payable.update( due_on: received_on + term.days )
    elsif ship_on.present?
      self.payable.update( due_on: ship_on + term.days )
    end
  end

  def update_order_amount
    self.order_amount_with_shipping = order_amount_with_shipping_added
  end

  def create_associated_payable
    self.payable = Payable.create(order: self)
  end


  def received?
    !!received_on
  end

  def self.term_options
    self.terms.map {|k,_| [k, k]}
  end

 

  def self.by_ordered_date(month_and_year)
    date = month_and_year.split("-")
    where('extract(month from ordered_on) = ? AND
         extract(year from ordered_on) = ?', date[0], date[1])
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
