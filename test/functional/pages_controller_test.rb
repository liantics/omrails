require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get learnmore" do
    get :learnmore
    assert_response :success
  end

  test "should get createproject" do
    get :createproject
    assert_response :success
  end

  test "should get projectlist" do
    get :projectlist
    assert_response :success
  end

  test "should get successstories" do
    get :successstories
    assert_response :success
  end

  test "should get resources" do
    get :resources
    assert_response :success
  end

end
