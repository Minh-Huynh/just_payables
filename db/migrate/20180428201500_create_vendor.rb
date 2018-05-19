class CreateVendor < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :name
    end
  end
end
