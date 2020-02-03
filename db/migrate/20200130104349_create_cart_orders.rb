class CreateCartOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_orders do |t|
      t.references :cart, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity
      t.boolean :in_cart, default: true
      t.float :price_discounted
      t.float :price
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
