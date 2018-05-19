class CreatePayables < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :description
      t.integer :term
      t.date :paid_on
      t.decimal :order_amount
      t.string :invoice_number
    end
  end
end
