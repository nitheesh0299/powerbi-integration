require 'test_helper'

class Oauth2ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get oauth2_index_url
    assert_response :success
  end

end
