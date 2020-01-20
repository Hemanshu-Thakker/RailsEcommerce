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
    assert_not_nil @user.username
  end

  test 'valid email' do 
    assert @user.valid?
    assert_not_nil @user.email
  end

  test 'valid password' do
    assert @user.password_digest.length >=5
  end

end
