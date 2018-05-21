class RemoveAssociationsFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :vendor_id
    remove_column :orders, :show_id
    remove_column :orders, :contact_id
  end
end
