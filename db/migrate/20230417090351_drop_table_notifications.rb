class DropTableNotifications < ActiveRecord::Migration[6.1]
  def change
    drop_table :delivery_addresses
  end
end
