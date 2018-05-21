class ChangeTypeOfTermToInteger < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :term
    add_column :orders, :term, :integer
  end
end
