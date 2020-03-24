class CreateProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.float :price, null: false
      t.float :cost_price, null: false
      t.timestamps
    end
  end
end
