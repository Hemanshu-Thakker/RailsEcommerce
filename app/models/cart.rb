class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_order
end
