class AddTimestampsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_timestamps(:orders)
  end
end
