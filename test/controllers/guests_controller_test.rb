require 'test_helper'

class GuestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guests_index_url
    assert_response :success
  end

end
