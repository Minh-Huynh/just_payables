class CreateShow < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :location
    end
  end
end
