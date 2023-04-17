class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :explanation, null: false
      t.integer :tax_out_price, null: false
      t.boolean :is_sale, default: true, null: false

      t.timestamps
    end
  end
end
