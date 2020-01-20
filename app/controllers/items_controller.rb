require 'will_paginate/array'
class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @user= User.find(params[:user_id])
    # @items = Item.paginate(:page => params[:page], :per_page=>12
    @items_array= Array.new
    Item.all.each do |item|
      if item.user != @user
        @items_array.push(item)
      end
    end
    @items= @items_array.paginate(:page => params[:page], :per_page=>12)
  end

  #Search index page
  def search
    @user= User.find(params[:user_id])
    search= params[:search]
    if search==nil or search==""
      redirect_to user_items_path(@user)
    else
      @items_array= Array.new
      Item.all.each do |item|
        if item.name.downcase.include?search.downcase 
          @items_array.push(item)
        end
      end
      @items= @items_array.paginate(:page => params[:page], :per_page=>12)
      render 'index'
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @user= User.find(params[:user_id])
    @item= Item.find(params[:id])
    @order= Order.new
    @comment= Comment.new
  end

  # GET /items/new
  def new
    @user= User.find(params[:user_id])
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @user= User.find(params[:user_id])

  end

  # POST /items
  # POST /items.json
  def create
    @user= User.find(params[:user_id])
    @item = @user.items.create(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to user_items_path(@user) }
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
    # @item.item_img.attach(params[:item_img])
    respond_to do |format|
      if @item.update(item_params)
        # if current_user==nil then current_user=params[:user_id]; end
        binding.pry
        format.html { redirect_to user_items_path(current_user) }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :quantity, :item_img)
    end

    #orders params
    
end
