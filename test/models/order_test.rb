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
  	binding.pry
  	assert_equal(@order.user.balance,500)
  	assert_equal(@order.item.user.balance,3500)
  	assert_equal(@order.item.quantity,0)
  end 
end
