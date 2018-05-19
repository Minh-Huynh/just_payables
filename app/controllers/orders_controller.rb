class OrdersController < ApplicationController
  helper_method :sort_order
  before_action :authenticate_user

  def index
    @orders = Order.filter(params.slice(:by_due_date, :by_ordered_date))
                   .search(params[:search])
                   .paginate(page: params[:page], per_page: 30)
                   .order(:created_at)
    @total_amount = @orders.sum(:order_amount)
  end

  def new
    @order= Order.new
    @vendor = @order.build_vendor
    @contact = @order.build_contact
    @show = @order.build_show
    @vendors = Vendor.all
  end

  def create
    @order = Order.new(new_order_params)
    if @order.save
      flash[:message] = "New order created"
      @contact = @order.contact
      associate_contact_with_vendor(@contact, @order)
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
    if @order.update(edit_order_params)
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

  def associate_contact_with_vendor(contact, order)
    contact.update(vendor_id: order.vendor_id) if contact.vendor.nil?
  end

  def convert_date_strings(params)
    [:due_on, :paid_on].each do |attribute|
      params[attribute] = DateTime.strptime(params[attribute], '%m/%d/%Y')
    end
  end

  def new_order_params
    permitted_params = params.require(:order).permit(:contact_id, :vendor_id, :show_id, 
                                  :order_amount, :description, :term,
                                  :paid_on, :due_on, :invoice_number, 
                                  vendor_attributes: [:name], 
                                  contact_attributes: [:first_name, 
                                  :last_name, :email, :phone_number], 
                                  show_attributes: [:name])
    convert_date_strings(permitted_params)
    drop_new_model_attributes(permitted_params)
  end

  def edit_order_params
    permitted_params = params.require(:order).permit(:contact_id, :vendor_id, :show_id, 
                                  :order_amount, :description, :term,
                                  :paid_on, :due_on, :invoice_number, 
                                  vendor_attributes: [:name], 
                                  contact_attributes: [:first_name, 
                                  :last_name, :email, :phone_number], 
                                  show_attributes: [:name])
    convert_date_strings(permitted_params)
    permitted_params
  end

  def drop_new_model_attributes(params)
    params = params.except(:contact_attributes) unless params[:contact_id].empty?
    params = params.except(:show_attributes) unless params[:show_id].empty?
    params = params.except(:vendor_attributes) unless params[:vendor_id].empty?
    params.reject{|_,v| v.blank? }
  end
end
