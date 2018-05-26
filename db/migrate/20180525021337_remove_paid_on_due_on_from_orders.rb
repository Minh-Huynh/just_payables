class RemovePaidOnDueOnFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :paid_on
    remove_column :orders, :due_on
  end
end
