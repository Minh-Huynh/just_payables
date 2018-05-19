class AddVendorIdAndShowIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :vendor_id, :integer
    add_column :orders, :show_id, :integer
  end
end
