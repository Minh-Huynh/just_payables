class AddVendorIdToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :vendor_id, :integer
  end
end
