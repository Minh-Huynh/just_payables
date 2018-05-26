module OrdersHelper
  def format_date(date_obj)
    date_obj.strftime("%m/%d/%Y") if !date_obj.nil?
  end

  def row_format(order)
    if order.payable.present? && order.payable.paid?
      'table-success'
    elsif order.received?
      'table-primary'
    end
  end
end