class CreateStore < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :logo
      t.belongs_to :address, foreign_key: true, null:false
      t.timestamps
    end
  end
end
