require 'test_helper'

class SmsControllerTest < ActionController::TestCase
  test "should get receive" do
    get :receive
    assert_response :success
  end

  test "should get send" do
    get :send
    assert_response :success
  end

end
