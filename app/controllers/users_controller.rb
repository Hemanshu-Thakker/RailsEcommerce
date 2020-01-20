class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @users  = User.paginate(:page => params[:page], :per_page=>5)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
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
      if @user.update(user_params)
        session[:user_id] = @user.id
        format.html { redirect_to user_items_path(@user)}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to login_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #dispaly users selling products
  def sold
    @user = User.find(params[:user_id])
    @orders_array = Array.new
    @revOrders= Array.new
    @user.items.each do |item|
      # if order.item.user.id == @user.id
      item.orders.each do |order|
        @orders_array.push(order)
      end
    end
    @orders_array.reverse_each do |e|
      @revOrders.push(e)
    end
    @orders= @revOrders.paginate(:page => params[:page], :per_page=>4)
  end

  #display bought products
  def orders
    @user = User.find(params[:user_id])
    @orders_array= Array.new
    @revOrders= Array.new

    # 100k Order are there
    # User 1 Comes to check his orders
    # User 1 has 2 orders

    @user.orders.each do |order|
        @orders_array.push(order)
    end


    @orders_array.reverse_each do |e|
      @revOrders.push(e)
    end
    @orders= @revOrders.paginate(:page => params[:page], :per_page=>4)
  end

  def add_money
    @user= User.find(params[:user_id])
  end

  def increment_balance
    @money= params[:balance].to_i
    @user= User.find(params[:user_id])
    if @user.balance == nil or @user.balance==0
      if @user.update(balance: @money)
        redirect_to user_items_path(@user)
      else 
        render "add_money"
      end
    else
      @money = @money + @user.balance
      if @user.update(balance: @money)
        redirect_to user_items_path(@user)
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
