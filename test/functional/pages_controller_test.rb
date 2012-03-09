require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get Home" do
    get :Home
    assert_response :success
  end

  test "should get Contact" do
    get :Contact
    assert_response :success
  end

  test "should get About_Us" do
    get :About_Us
    assert_response :success
  end

end
