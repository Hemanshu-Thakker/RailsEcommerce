class AddInCartToItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :in_cart, :boolean, default: true
  end
end
