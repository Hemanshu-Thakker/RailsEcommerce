class CouponsController < ApplicationController
	include ApplicationHelper
	def apply
		@cart= current_user.cart
		@coupon= Coupon.find_by_value(params[:value])
		@cart.cart_order.where(in_cart: true).update_all(coupon_id: @coupon.id)
		@cart.cart_order.where(in_cart: true).each do | ord |
			price= ord.price-(@coupon.discount/100)*ord.price
			ord.update(price_discounted: price)
		end
		redirect_to user_cart_path(current_user.id,current_user.cart.id)
	end
end
