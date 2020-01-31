class CartOrder < ApplicationRecord
  belongs_to :cart
  belongs_to :item
end
