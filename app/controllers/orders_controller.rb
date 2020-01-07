class OrdersController < ApplicationController
	def index
	end
	def update
	end
	def destroy
	end
	def create
		# render plain: params[:order].inspect
		@user= User.find(params[:user_id])
		@item= Item.find(params[:item_id])
		Rails.logger.info "@@@@@ #{params}"
		Rails.logger.info "@@@@@ #{order_params}"
		Rails.logger.info "@@@@@ #{@item}"
		Rails.logger.info "@@@@@ #{@item.price}"
		Rails.logger.info "@@@@@ #{@user.balance}"
		Rails.logger.info "@@@@@ #{order_params["quantity"]}"

		@order= Order.create(user_id: @user.id, item_id: @item.id, quantity: order_params["quantity"])
		if order_params["quantity"]=="" or order_params["quantity"] == nil 
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
			buy(@user,@item,order_params["quantity"].to_i)
			redirect_to user_item_order_path(@user['id'],@item['id'],@order['id'])
		end
	end

	# def new
	# 	redirect_to user_item_path
	# end

	def buy(user,item,quant)
		# Rails.logger.info "@@@@@ mail sending time"
		UserMailer.buyer_confirmation(user).deliver
		# Rails.logger.info "@@@@@ Done sending mail"
		# Deduct money from the buyer
		balance_updater = user.balance - quant*item.price.to_i
		user.update(balance: balance_updater)
		# mails the buyer
		# Add money seller
		balance_updater = item.user.balance.to_i + quant*item.price.to_i
		item.user.update(balance: balance_updater)
		# mail the seller
		UserMailer.seller_confirmation(item.user).deliver
		# Alter quantity of the product
		item_updater = item.quantity.to_i - quant
		item.update(quantity: item_updater)
	end

	def show
		super
		@user=User.find(params[:user_id])
		redirect_to "/users/#{@user['id']}/orders"
	end
	def order_params
      params.require(:order).permit(:quantity)
    end
end
