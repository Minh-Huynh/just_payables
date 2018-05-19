class ChangeTypeOfTerm < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :term, :string
  end
end
