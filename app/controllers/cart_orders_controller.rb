class CartOrdersController < ApplicationController
	def index
		redirect_to user_item_path(current_user,params[:item_id])
	end
	def show
		@cart=current_user.cart
		@cart_orders=@cart.cart_order.where(in_cart: true)
		item_count=@cart_orders.count
		@orders=current_user.orders.order(:created_at).last(item_count)
		@cart_orders.destroy_all
	end
	def create
		@cart=current_user.cart
		@item=Item.find(params[:item_id])
		@quantity=params[:quantity].to_i
		@price= @quantity * @item.price
		@comment= Comment.new

		if @cart.cart_order.find_by_item_id(params[:item_id])==nil and (@quantity > 0 and @quantity <= @item.quantity)
			@cart_orders=CartOrder.create(cart_id: @cart.id,quantity: @quantity,item_id: params[:item_id], price: @price, price_discounted: @price)
			redirect_to user_cart_path(current_user,@cart)
		elsif @quantity<=0 or @quantity>@item.quantity or @quantity =="" or @quantity==nil
			@cart.errors.add(:quantity," is invalid")
			render 'items/show'
		else
			@cart.errors.add(:quantity, "is valid but Item already exists")
			render 'items/show'
		end
	end

	def update
		@quantity=params[:quantity].to_i
		@cart=current_user.cart
		@cart_order=@cart.cart_order.find(params[:id])
		@price= (@cart_order.price/@cart_order.quantity)*@quantity
		@cart_order.update(quantity: @quantity, price: @price)
		redirect_to user_cart_path(params[:user_id])
	end

	def update_in_cart
		@cart_order= CartOrder.find(params[:id])
		if @cart_order.in_cart
			@cart_order.update(in_cart: false)
		else
			@cart_order.update(in_cart: true)
		end
		redirect_to user_cart_path(current_user,current_user.cart)
	end

	def destroy
		@cart_order=CartOrder.find(params[:id])
		@cart_order.destroy
		redirect_to user_cart_path(current_user.id,current_user.cart.id)
	end
end
