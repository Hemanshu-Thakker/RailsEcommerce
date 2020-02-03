module ApplicationHelper
	def getCurrentUser
		current_user
	end
	def getItem(id)
		Item.find(id)
	end
	def getTotal
		current_user.cart.cart_order.where(in_cart: true).sum(:price)
	end
	def getAverageRating(item) 
		@average_rating= Comment.findAverageRating(item)
		@average_rating
	end
	def getCartOrders
		@cart=current_user.cart
		if @cart.cart_order.where.not(coupon_id: nil)==[]
			#not applied
			true
		else
			#applied
			false
		end
	end
end
