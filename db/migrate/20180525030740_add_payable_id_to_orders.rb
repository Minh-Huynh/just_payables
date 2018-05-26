class AddPayableIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payable_id, :integer
  end
end
