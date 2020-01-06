class ApplicationController < ActionController::Base
	def index
    	if params[:user_id] == nil
      		@user= User.find(4)
      		@user.username= "Login"
      		@user.balance= nil
    	else
      		@user= User.find(params[:user_id])
    	end
	end
	def show
    	if params[:user_id] == nil
      		@user= User.find(4)
      		@user.username= "Login"
      		@user.balance= nil
    	else
      		@user= User.find(params[:user_id])
    	end
	end
end
