class AddOrderAmountWithShipping < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_amount_with_shipping, :decimal
  end
end
