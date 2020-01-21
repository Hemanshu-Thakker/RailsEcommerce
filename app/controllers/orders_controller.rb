class OrdersController < ApplicationController
	def index
		@item= Item.find(params[:item_id])
		redirect_to user_item_path(current_user,@item)
	end
	def update
	end
	def destroy
	end
	def create
		# render plain: params[:order].inspect
		@item= Item.find(params[:item_id])
		@comment= Comment.new
		@average_rating= Comment.findAverageRating(@item)
		
		Rails.logger.info "@@@@@ #{order_params["quantity"]}"

		@order= Order.create(user_id: current_user.id, item_id: @item.id, quantity: order_params["quantity"])
		if order_params["quantity"]=="" or order_params["quantity"] == nil 
			render 'items/show'
		elsif current_user.balance==nil or current_user.balance==0
			@order.destroy
			@order.errors.add(:quantity,"is given but Add Money to your account")
			render 'items/show'
		elsif order_params["quantity"].to_i > @item.quantity
			@order.destroy
			@order.errors.add(:quantity," of the product Exceeded")
			render 'items/show'
		elsif current_user.balance < @item.price*order_params["quantity"].to_i
			@order.destroy
			@order.errors.add(:user_id,"Insufficient balance")
			render 'items/show'
		else
			current_user.buy(@item,order_params["quantity"].to_i)
			redirect_to user_item_order_path(current_user['id'],@item['id'],@order['id'])
		end
	end

	def show
		redirect_to "/users/#{current_user['id']}/orders"
	end

	def order_params
      params.require(:order).permit(:quantity)
    end
end
