class CartOrdersController < ApplicationController
	def index
		redirect_to user_item_path(current_user,params[:item_id])
	end
	def show
		@cart=current_user.cart
		@cart_orders=@cart.cart_order
		@cart.cart_order.destroy_all
	end
	def create
		@cart=current_user.cart
		@item=Item.find(params[:item_id])
		@quantity=params[:quantity].to_i
		@comment= Comment.new

		if @cart.cart_order.find_by_item_id(params[:item_id])==nil and (@quantity > 0 and @quantity <= @item.quantity)
			@cart_orders=CartOrder.create(cart_id: @cart.id,quantity: @quantity,item_id: params[:item_id])
			redirect_to user_cart_path(current_user,@cart)
		elsif @quantity<=0 or @quantity>@item.quantity
			@cart.errors.add(:quantity," is invalid")
			render 'items/show'
		else
			@cart.errors.add(:quantity, "is valid but Item already exists")
			render 'items/show'
		end
	end

	def update
		@quantity=params[:quantity]
		@cart=current_user.cart
		@cart_order=@cart.cart_order.find(params[:id])
		@cart_order.update(quantity: @quantity)
		redirect_to user_cart_path(params[:user_id])
	end

	def destroy
		@cart_order=CartOrder.find(params[:id])
		@cart_order.destroy
		redirect_to user_cart_path(current_user,current_user.cart)
	end
end
