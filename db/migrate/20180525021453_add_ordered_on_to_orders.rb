class AddOrderedOnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ordered_on, :datetime
  end
end
