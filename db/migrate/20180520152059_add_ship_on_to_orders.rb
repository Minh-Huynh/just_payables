class AddShipOnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ship_on, :datetime
  end
end
