class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users  = User.paginate(:page => params[:page], :per_page=>5)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to user_items_path(@user) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if current_user.update(user_params)
        session[:user_id] = current_user.id
        format.html { redirect_to user_items_path(current_user)}
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    current_user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to login_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #dispaly users sold products
  def sold                      
    @orders=Order.joins(:item).where("items.user_id IN (?)",current_user.id).paginate(:page => params[:page], :per_page=>4)
    # @items= @user.items.paginate(:page => params[:page], :per_page=>4)
  end

  # display users selling products
  def your_items
    @items=current_user.items.paginate(:page => params[:page], :per_page=>4)
  end

  #display bought products
  def orders
    @orders= current_user.orders.reverse().paginate(:page => params[:page], :per_page=>4)
  end

  # Add money to your account
  def add_money
  end

  # Increment balance in your account
  def increment_balance
    @money= params[:balance].to_i
    if current_user.balance == nil or current_user.balance==0
      if current_user.update(balance: @money)
        redirect_to user_items_path(current_user)
      else 
        render "add_money"
      end
    else
      @money = @money + current_user.balance
      if current_user.update(balance: @money)
        redirect_to user_items_path(current_user)
      else 
        render "add_money"
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :email)
    end
end
