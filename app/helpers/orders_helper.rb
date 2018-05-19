module OrdersHelper
  def format_date(date_obj)
    date_obj.strftime("%m/%d/%Y") if !date_obj.nil?
  end

  def row_format(order)
    if order.paid?
      'table-success'
    elsif order.past_due?
      'table-danger'
    elsif order.due_this_month?
      'table-warning'
    end
  end
end