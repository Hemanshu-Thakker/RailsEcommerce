class SessionsController < ApplicationController
  def new

  end

  def create
  	# render plain: params[:order].inspect
  	user= User.find_by_username(params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to user_items_path(user)
  	else
  		flash.now[:alert] = "Email or password is invalid" 
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end
