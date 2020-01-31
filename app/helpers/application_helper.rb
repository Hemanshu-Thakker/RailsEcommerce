module ApplicationHelper
	def getCurrentUser
		current_user
	end
	def getItem(id)
		Item.find(id)
	end
	def getTotal
		item_id=current_user.cart.cart_order.pluck(:item_id)
		Item.where(id: item_id).sum(:price)
	end
	def getAverageRating(item) 
		@average_rating= Comment.findAverageRating(item)
		@average_rating
	end
end
