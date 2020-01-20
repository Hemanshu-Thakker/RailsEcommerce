require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
  	@order= orders(:oneroman)
  end

  test "valid order" do
    assert @order.valid?
  end

  test "valid buy" do 
  	@order.user.buy(@order.item,@order.quantity)
  	assert_equal(@order.user.balance,500)
  	assert_equal(@order.item.user.balance,3500)
  	assert_equal(@order.item.quantity,0)
  end 

  test "valid quantity" do
    assert @order.quantity <= @order.item.quantity
    assert_not_nil @order.quantity
  end

  test "valid money" do
    assert @order.item.price <= @order.user.balance
    assert_not_nil @order.user.balance
  end
end
