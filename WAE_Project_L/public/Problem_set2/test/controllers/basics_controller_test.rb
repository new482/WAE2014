require 'test_helper'

class BasicsControllerTest < ActionController::TestCase
  test "should get quotations" do
    get :quotations
    assert_response :success
  end

end
