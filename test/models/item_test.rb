require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
  	@item = items(:one) 
  end

  test "valid item" do
    assert @item.valid?
  end
  
end
