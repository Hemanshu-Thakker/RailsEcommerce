class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @user= User.find(params[:user_id])
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @user= User.find(params[:user_id])
    @order= Order.new
  end

  # GET /items/new
  def new
    @user= User.find(params[:user_id])
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @user= User.find(params[:user_id])
    @item = @user.items.create(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @user, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @user= User.find(params[:user_id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def buy
    @user= User.find(params[:user_id])

    @quantity
    # deductMoney(@user)
    # @user1= User.find(:all, :condition => {user_id != @user.id})
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :quantity)
    end

    #orders params
    
end
