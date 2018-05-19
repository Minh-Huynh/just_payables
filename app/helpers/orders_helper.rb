module OrdersHelper
  def format_date(date_obj)
    date_obj.strftime("%m/%d/%Y") if !date_obj.nil?
  end
end