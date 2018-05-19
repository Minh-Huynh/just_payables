class Order < ApplicationRecord
  include Filterable
  belongs_to :vendor, optional: true
  belongs_to :show, optional: true
  belongs_to :contact, optional: true
  accepts_nested_attributes_for :vendor, :contact, :show
  validates :order_amount, presence: true
   

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

  def paid?
    !paid_on.nil?
  end

  def past_due?
    due_on <= Date.today if due_on.present?
  end

  def due_this_month?
    due_on.month == Date.today.month if due_on.present?
  end

  def self.search(term)
    term = term.downcase if term
    Order.joins(:vendor, :show).where("description ILIKE :term 
                                          OR term ILIKE :term 
                                          OR invoice_number ILIKE :term 
                                          OR vendors.name ILIKE :term 
                                          OR shows.name ILIKE :term", 
                                          term: "%#{term}%")
  end
end
