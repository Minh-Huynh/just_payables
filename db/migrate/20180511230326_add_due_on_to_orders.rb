class AddDueOnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :due_on, :datetime
  end
end
