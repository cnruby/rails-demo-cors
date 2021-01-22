require "test_helper"

class SurfersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get surfers_index_url
    assert_response :success
  end
end
