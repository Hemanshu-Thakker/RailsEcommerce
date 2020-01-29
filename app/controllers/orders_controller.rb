class OrdersController < ApplicationController
	def index
		@item= Item.find(params[:item_id])
		redirect_to user_item_path(current_user,@item)
	end
	
	def update
	end
	
	def destroy
	end

	def add_to_card
		
	end

	def create
		# render plain: params[:order].inspect
		binding.pry
		@item= Item.find(params[:item_id])
		@comment= Comment.new
		@average_rating= Comment.findAverageRating(@item)
		
		Rails.logger.info "@@@@@ #{params["quantity"]}"

		@order= Order.create(user_id: current_user.id, item_id: @item.id, quantity: params["quantity"])
		if params["quantity"]=="" or params["quantity"] == nil 
			render 'carts/show'
		elsif current_user.balance==nil or current_user.balance==0
			@order.destroy
			@order.errors.add(:quantity,"is given but Add Money to your account")
			render 'carts/show'
		elsif params["quantity"].to_i > @item.quantity
			@order.destroy
			@order.errors.add(:quantity," of the product Exceeded")
			render 'carts/show'
		elsif current_user.balance < @item.price*params["quantity"].to_i
			@order.destroy
			@order.errors.add(:user_id,"Insufficient balance")
			render 'carts/show'
		else
			if current_user.buy(@item,params["quantity"].to_i)
				redirect_to user_item_order_path(current_user['id'],@item['id'],@order['id'])
			else
				@order.destroy
				redirect_to user_item_path(current_user['id'],@item['id'])
			end
		end
	end

	def show
		redirect_to "/users/#{current_user['id']}/orders"
	end

	def order_params
      params.require(:order).permit(:quantity)
    end
end
