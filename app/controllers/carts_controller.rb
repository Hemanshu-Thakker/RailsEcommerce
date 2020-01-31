class CartsController < ApplicationController
	def index
	end
	def show
		@cart= current_user.cart
	end
	def buyall
		@cart=current_user.cart
		@cart.cart_order.each do |ord|
			if ord.quantity=="" or ord.quantity == nil
				@cart.errors.add(:quantity, "is invalid")
				render 'show'
			elsif current_user.balance==nil or current_user.balance==""
				@cart.errors.add(:user_id, "has insufficient balance")
			elsif current_user.balance < ord.item.price*ord.quantity.to_i
				@cart.errors.add(:user_id, " has insufficient balance")
				render 'show'
			else
				@order=Order.create(user_id: current_user.id, item_id: ord.item_id, quantity: ord.quantity)
				if current_user.buy(ord.item,ord.quantity.to_i)
					ord.destroy
				else
					@order.destroy
				end
			end
		end
		redirect_to order_confirmation_path(current_user)
	end
end
