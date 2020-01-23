require 'will_paginate/array'
class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items= Item.where.not(user_id: current_user.id).where(active: true).paginate(:page => params[:page], :per_page=>8)
  end

  #Search index page
  def search
    # @user= current_user
    search= params[:search]
    if search==nil or search==""
      redirect_to user_items_path(current_user)
    else
      # @items_array= Array.new
      # Item.all.each do |item|
      #   if item.name.downcase.include?search.downcase 
      #     @items_array.push(item)
      #   end
      # end
      @items= Item.where.not(user_id: current_user).where(name: search).where(active: true).paginate(:page => params[:page], :per_page=>8)
      render 'index'
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item= Item.find(params[:id])
    @order= Order.new
    @comment= Comment.new
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.create(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to user_items_path(current_user) }
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
    @item= Item.find(params[:id])
      # @item.item_to_send_mail= @item
      # @item.user_to_send_mail= current_user
    respond_to do |format|
      if @item.update(item_params)
        # UserMailer.item_update(current_user,before_item,@item).deliver
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
    @item.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Item was successfully destroyed.' }
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
      params.require(:item).permit(:name, :price, :quantity, :item_img, :active)
    end

    #orders params
    
end
