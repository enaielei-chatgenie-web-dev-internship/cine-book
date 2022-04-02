require "test_helper"

class TimeslotsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get timeslots_new_url
    assert_response :success
  end
end
