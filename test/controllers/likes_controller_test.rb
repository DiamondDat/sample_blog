require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get likes_create_url
    assert_response :success
  end

  test "creates like" do
    assert_difference 'stories(:two).votes.count' do
      post micropost_likes_path(microposts(:two))
    end
  end

  test "create vote with AJAX" do
    post micropost_likes_path(microposts(:two)), xhr: true
    assert_response :success
  end
end
