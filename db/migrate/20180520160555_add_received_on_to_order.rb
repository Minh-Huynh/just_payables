class AddReceivedOnToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :received_on, :datetime
  end
end
