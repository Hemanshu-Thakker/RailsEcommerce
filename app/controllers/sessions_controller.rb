class SessionsController < ApplicationController

  def new
    render :layout => 'unuser'
  end

  def create
  	# render plain: params[:order].inspect
  	user= User.find_by_username(params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to user_items_path(user)
  	else
  		flash[:alert] = "Email or password is invalid" 
  		render 'new'
  	end
  end

  def validate_user
    @user=params[:username]
    respond_to do |format|
      if User.exists?(username: @user)
        UserMailer.password_reseter(User.find_by_username(@user)).deliver
        flash[:notice]= "User Exists ! Password reset link sent to your mail"
        format.html { redirect_to "/get_user" }
      else
        flash[:alert]= "Username False. Please re-enter !"
        format.html { redirect_to "/get_user" }
      end
    end
  end

  def get_user
    render :layout => 'unuser'
  end

  def password_reset 
    @user= User.find(params[:id])
    render :layout => 'unuser'
  end

  def update_password
    @user= User.find(params[:id])
    respond_to do |format|
      if params[:password]==params[:password_confirmation]
        if @user.update(password: params[:password])
          format.html { redirect_to login_path}
        else
          format.html { render :password_reset }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        @user.errors.add(:password_confirmation, "dosen't match password")
        format.html { render :password_reset }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def email_validate
    @user= User.find(
      ActiveSupport::MessageEncryptor.new(ENV['KEY']).decrypt_and_verify(params[:id])
      )
    session[:user_id] = @user.id
    @user.update(validate_user: true)
    redirect_to user_items_path(@user)
  end

  def destroy
  	session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end
