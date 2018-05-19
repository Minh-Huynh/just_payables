module DashboardHelper
  def amount_total(orders)
    orders.sum(:order_amount)
  end

  def convert_month_year_to_string(date_string)
    month_and_year = date_string.split("-")
    month = Date::MONTHNAMES[month_and_year[0].to_i]
    year = month_and_year[1]
    "#{month} #{year}"
  end
end