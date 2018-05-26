class PayablesController < ApplicationController
  before_action :authenticate_user
  def index
    @payables = Payable.filter(params.slice(:by_due_date))
                       .search(params[:search])
                       .order(:created_at)
    @orders = Order.includes(:payable).where("payables.id IN (?)", @payables.ids)
    @payables = @payables.paginate(page: params[:page], per_page: 30)
  end

  def edit
    @payable = Payable.find(params[:id])
    @order = @payable.order
  end

  def update
    @payable = Payable.find(params[:id])
    if @payable.update(payable_params)
      flash.now[:message] = "Payable updated"
      redirect_to payables_path
    else
      flash[:error] = "Failed to update payable"
      render :edit
    end
  end

  private
    def payable_params
      permitted_params = params.require(:payable).permit(:paid_on, :due_on)
      convert_date_strings(permitted_params)
      permitted_params
    end

    def convert_date_strings(params)
      params.slice(:paid_on, :due_on).each do |key, value|
      if /\d{2}\/\d{2}\/\d{4}/ =~ params[key]
        params[key] = DateTime.strptime(params[key], '%m/%d/%Y') unless params[key].empty?
      end
    end
  end
end