require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get user_items_url(@item.user)
    assert_response :success
  end

  test "should get new" do
    get new_user_item_url(@item.user)
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post user_items_url(Item.last.user), params: { item: { name: @item.name, price: @item.price, quantity: @item.quantity, user_id: @item.user_id } }
    end

    assert_redirected_to user_items_url(Item.last.user)
  end

  test "should show item" do
    get user_item_url(@item,user_id: @item.user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_item_url(@item,user_id: @item.user)
    assert_response :success
  end

  # test "should update item" do
  #   patch user_item_url(@item,user_id: @item.user_id), params: { item: { name: @item.name, price: @item.price, quantity: @item.quantity, user_id: @item.user_id } }
  #   assert_response :success
  #   assert_redirected_to user_items_url(@item.user)
  # end

  # test "should destroy item" do
  #   assert_difference('Item.count', -1) do
  #     delete user_items_url(user_id: @item.user_id)
  #   end

  #   assert_redirected_to user_items_url(user_id: @item.user_id)
  # end
end
