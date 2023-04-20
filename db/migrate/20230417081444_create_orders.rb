class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id, null: false
      t.integer :postage, default: 800, null: false
      t.integer :pay_method, default: 0, null: false
      t.integer :billing_amount, null: false
      t.integer :status, default: 0, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
