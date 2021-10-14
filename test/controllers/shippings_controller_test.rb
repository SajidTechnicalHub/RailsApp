require 'test_helper'

class ShippingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shippings_index_url
    assert_response :success
  end

end
