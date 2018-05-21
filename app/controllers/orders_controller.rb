class OrdersController < ApplicationController
  helper_method :sort_order
  before_action :authenticate_user

  def index
    @orders = Order.filter(params.slice(:by_due_date, :by_ordered_date, :by_ship_date))
                   .search(params[:search])
                   .paginate(page: params[:page], per_page: 30)
                   .order(:created_at)
    @total_amount = @orders.sum(:order_amount)
  end

  def new
    @order= Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:message] = "New order created"
      @contact = @order.contact
      redirect_to orders_path
    else
      flash[:error] = "Order failed to be created"
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
    @vendor = @order.vendor
    @contact = @order.contact
    @show = @order.show
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:message] = "Order updated"
      redirect_to orders_path
    else
      flash[:error] = "Order failed to update"
      render :edit
    end
  end


  private

  def search(term)
    Order.include(:vendor, :show).where("description LIKE :search 
                                          OR term LIKE :search 
                                          OR invoice_number LIKE :search 
                                          OR due_on LIKE :search 
                                          OR paid_on LIKE :search 
                                          OR vendors.name LIKE :search 
                                          OR shows.name LIKE :search", 
                                          search: term)
  end

  def convert_date_strings(params)
    params.slice(:due_on, :paid_on, :ship_on, :received_on).each do |key, value|
      if /\d{2}\/\d{2}\/\d{4}/ =~ params[key]
        params[key] = DateTime.strptime(params[key], '%m/%d/%Y') unless params[key].empty?
      end
    end
  end

  def order_params
    permitted_params = params.require(:order).permit(:received_on, :contact_id, :vendor_id, :show_id, 
                                  :order_amount, :description, :term,
                                  :paid_on, :due_on, :ship_on, :invoice_number,
                                  :vendor, :show, :contact, :shipping_percentage)
    convert_date_strings(permitted_params)
    permitted_params
  end
end
