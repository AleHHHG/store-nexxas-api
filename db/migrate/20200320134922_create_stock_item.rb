class CreateStockItem < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_items do |t|
      t.belongs_to :product, foreign_key: true, null:false
      t.belongs_to :store, foreign_key: true, null:false
      t.integer :stock, null: false, default: 0
      t.timestamps
    end
  end
end
