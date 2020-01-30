class CartsController < ApplicationController
	def index
	end
	def show
		@cart= current_user.cart
    	@order= Order.new
	end
	def update
		@cart=current_user.cart
		@item=Item.find(params[:id])
		@quantity=params[:quantity].to_i
		@comment= Comment.new

		if @quantity <= 0 or @quantity > @item.quantity
			@cart.errors.add(:quantity, "is invalid")
			render 'items/show'
		elsif @cart.added_items.key?(params[:id])
			flash[:notice]="Item already exists in the cart"
			redirect_to user_item_path(current_user,@item)
		else
			@cart.added_items[params[:id]]=params[:quantity]
			
			if @cart.save
				flash[:notice]="Item successfully added to Cart"
				redirect_to user_item_path(current_user,@item)
			else
				flash[:notice]="Item couldnt be added to Cart"
				redirect_to user_item_path(current_user,@item)
			end
		end
	end
	def remove_item
		@cart= current_user.cart
		@cart.added_items.delete(params[:key])
		@cart.save
		redirect_to user_cart_path(current_user,@cart.id)
	end

	def buyall
		binding.pry
		# @cart=current_user.cart
		# @cart.added_items.each do |id,q|
		# 	@order= Order.new
			
		# end
	end
end
