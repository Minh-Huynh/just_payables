class AddContactIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :contact_id, :integer
  end
end
