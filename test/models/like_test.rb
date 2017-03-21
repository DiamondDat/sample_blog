require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "likes have a micropost" do
    assert_equal microposts(:one), likes(:one).micropost
  end
end
