class CommentsController < ApplicationController
	def index
		@item= Item.find(params[:item_id])
		redirect_to user_item_path(current_user,@item)
	end
	# def new
	# 	@comment= Comment.new
	# end
	def create
		@item= Item.find(params[:item_id])
		@average_rating= Comment.findAverageRating(@item)
		@cart=current_user.cart
		@comment= Comment.create(user_id: current_user.id ,item_id: @item.id ,body: comment_params["body"], rating: comment_params["rating"]) 
		if comment_params["body"]==nil or comment_params["body"]==""
			@comment.destroy
			render 'items/show'
		elsif comment_params["rating"]==nil or comment_params["rating"]==""
			@comment.destroy
			render 'items/show'
		elsif current_user==@item.user
			@comment.errors.add(:body,"Seller can not comment")
			@comment.destroy
			render 'items/show'
		else
			redirect_to user_item_path(current_user,@item)
		end
	end

	def comment_params
      params.require(:comment).permit(:body,:rating)
    end
end
