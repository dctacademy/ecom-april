class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.date :order_date
      t.string :order_number
      t.float :total_amount

      t.timestamps null: false
    end
  end
end
