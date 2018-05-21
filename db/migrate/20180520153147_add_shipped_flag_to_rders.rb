class AddShippedFlagToRders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :received, :boolean, default: false
  end
end
