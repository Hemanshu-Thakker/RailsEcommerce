require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
  	@comment= comments(:first)
  end

  test "valid comment" do
    assert @comment.valid?
  end

  test "valid rating" do
  	assert @comment.rating <= 5
  end 

  test "valid comment body" do 
  	assert_not_nil @comment.body
  end
  
end
