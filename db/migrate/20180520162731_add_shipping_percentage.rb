class AddShippingPercentage < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :shipping_percentage,:decimal 
  end
end
