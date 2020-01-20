require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
  	@item = items(:one) 
  end

  test "valid item" do
    assert @item.valid?
  end

  test "vaild price" do 
  	assert @item.price > 0 
  	assert_not_nil @item.price
  end

  test "valid name" do 
  	assert_not_nil @item.name
  end

  test "valid quantity" do
  	assert @item.quantity > 0 
  	assert_not_nil @item.quantity
  end	
end
