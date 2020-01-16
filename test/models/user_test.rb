require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user= users(:romanone)
  end

  test 'valid user' do
    assert @user.valid?
  end

  # test "valid buy" do
  # 	@item=items(:two)
  # 	@user.buy(@item,1)
  # 	assert_equal(@user.balance,1900)
  # end

end
