class CommentsController < ApplicationController
	def index
		@user= User.find(params[:user_id])
		@item= Item.find(params[:item_id])
		redirect_to user_item_path(@user,@item)
	end
	# def new
	# 	@comment= Comment.new
	# end
	def create
		@user= User.find(params[:user_id])
		@item= Item.find(params[:item_id])
		@order= Order.new
		@average_rating= Comment.findAverageRating(@item)
		@comment= Comment.create(user_id: @user.id ,item_id: @item.id ,body: comment_params["body"], rating: comment_params["rating"]) 
		if comment_params["body"]==nil or comment_params["body"]==""
			@comment.destroy
			render 'items/show'
		elsif @user==@item.user
			binding.pry
			@comment.errors.add(:body,"Seller can not comment")
			@comment.destroy
			render 'items/show'
		else
			redirect_to user_item_path(@user,@item)
		end
	end

	def comment_params
      params.require(:comment).permit(:body,:rating)
    end
end
