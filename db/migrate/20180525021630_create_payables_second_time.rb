class CreatePayablesSecondTime < ActiveRecord::Migration[5.1]
  def change
    create_table :payables do |t|
      t.datetime :paid_on
      t.datetime :due_on
      t.belongs_to :order, index: true
      t.decimal :ordered_amount
      t.timestamps
    end
  end
end
