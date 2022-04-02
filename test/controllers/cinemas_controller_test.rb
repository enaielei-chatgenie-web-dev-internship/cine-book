require "test_helper"

class CinemasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cinemas_new_url
    assert_response :success
  end
end
