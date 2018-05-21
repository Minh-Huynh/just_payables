class AddVendorShowContactToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :vendor, :string
    add_column :orders, :show, :string
    add_column :orders, :contact, :string

  end
end
