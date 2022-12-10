class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :postcode
      t.string :address
      t.string :name
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method
      t.integer :status
      t.integer :customer_id
      t.integer :item_id
      t.integer :image_id

      t.timestamps
    end
  end
end
