require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user= User.new(username: "Heman", password:"heman", email: "hemanshupthakker", balance: "20000" )
  end

  test 'valid user' do
    assert_not @user.valid?
  end
end
