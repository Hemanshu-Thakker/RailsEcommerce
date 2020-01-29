class Cart < ApplicationRecord
	serialize :added_items, Hash
	belongs_to :user 
end
