class CartsController < ApplicationController
	def index
	end
	def show
		@cart= current_user.cart
    	@order= Order.new
	end
	def update
		@cart=current_user.cart
		@item=params[:id]
		@cart.added_items[params[:id]]=params[:quantity]
		if @cart.save
			flash[:notice]="Item successfully added to Cart"
			redirect_to user_item_path(current_user,@item)
		else
			flash[:notice]="Item couldnt be added to Cart"
			redirect_to user_item_path(current_user,@item)
		end
	end
	def remove_item
		@cart= current_user.cart
		@cart.added_items.delete(params[:key])
		@cart.save
		redirect_to user_cart_path(current_user,@cart.id)
	end
end
