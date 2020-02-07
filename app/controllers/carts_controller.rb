class CartsController < ApplicationController
	include ApplicationHelper
	def index
	end
	def show
		@cart= current_user.cart
		@cart_items= @cart.cart_order.where(in_cart: true)
		@saved_items= @cart.cart_order.where(in_cart: false)
		if @cart.cart_order.where.not(coupon_id: nil)==[]
			# not applied
		else
			# applied
			id=@cart_items.where.not(coupon_id: nil).pluck(:coupon_id).first
			@coupon= Coupon.find(id)
			@discounted_total= (getTotal-(@coupon.discount/100)*getTotal).ceil(2)
			flash[:notice]="Note: Coupon Applied"
			@cart_items.where(coupon_id: nil).each do |ord|
				price= ord.price-(@coupon.discount/100)*ord.price
				ord.update(price_discounted: price, coupon_id: @coupon.id)
			end
		end
	end
	def buyall
		@cart=current_user.cart
		@cart_items= @cart.cart_order.where(in_cart: true)
		@saved_items= @cart.cart_order.where(in_cart: false)
		flag=false
		@cart.cart_order.where(in_cart: true).find_each do |ord|
			if ord.quantity=="" or ord.quantity == nil
				@cart.errors.add(:quantity, "is invalid")
				flag=true
				render 'show'
				break
			elsif current_user.balance==nil or current_user.balance=="" or current_user.balance < ord.item.price*ord.quantity.to_i
				@cart.errors.add(:user_id, "has insufficient balance")
				flag=true
				render 'show'
				break
			else
				@order=Order.create(user_id: current_user.id, item_id: ord.item_id, quantity: ord.quantity, price: ord.price_discounted)
				if current_user.buy(ord.item,ord.quantity.to_i)
				else
					@order.destroy
				end
			end
		end
		redirect_to order_confirmation_path(current_user) if flag==false
	end

end
