class DashboardController < ApplicationController
  def index
    @month_and_year = date_params_processing
    @orders_due = Order.by_due_date(@month_and_year)
    @orders_ordered = Order.by_ordered_date(@month_and_year)
  end

  private
  def date_params_processing
    params[:month_and_year] || DateTime.now.strftime("%m-%Y")
  end
end