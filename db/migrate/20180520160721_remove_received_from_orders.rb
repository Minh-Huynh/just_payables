class RemoveReceivedFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :received, :boolean
  end
end
