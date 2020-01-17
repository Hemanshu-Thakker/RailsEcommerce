class OrdersController < ApplicationController
	def index
		@user= User.find(params[:user_id])
		@item= Item.find(params[:item_id])
		redirect_to user_item_path(@user,@item)
	end
	def update
	end
	def destroy
	end
	def create
		# render plain: params[:order].inspect
		@user= User.find(params[:user_id])
		@item= Item.find(params[:item_id])
		@comment= Comment.new
		@average_rating= Comment.findAverageRating(@item)
		
		Rails.logger.info "@@@@@ #{order_params["quantity"]}"

		@order= Order.create(user_id: @user.id, item_id: @item.id, quantity: order_params["quantity"])
		if order_params["quantity"]=="" or order_params["quantity"] == nil 
			render 'items/show'
		elsif @user.balance==nil or @user.balance==0
			@order.destroy
			@order.errors.add(:quantity,"is given but Add Money to your account")
			render 'items/show'
		elsif order_params["quantity"].to_i > @item.quantity
			@order.destroy
			@order.errors.add(:quantity," of the product Exceeded")
			render 'items/show'
		elsif @user.balance < @item.price*order_params["quantity"].to_i
			@order.destroy
			@order.errors.add(:user_id,"Insufficient balance")
			render 'items/show'
		else
			@user.buy(@item,order_params["quantity"].to_i)
			redirect_to user_item_order_path(@user['id'],@item['id'],@order['id'])
		end
	end

	def show
		@user=User.find(params[:user_id])
		redirect_to "/users/#{@user['id']}/orders"
	end

	def order_params
      params.require(:order).permit(:quantity)
    end
end
