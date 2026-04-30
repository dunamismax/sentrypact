require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home renders the SentryPact website" do
    get root_url

    assert_response :success
    assert_select "h1", "SentryPact"
    assert_select "title", "SentryPact | Filtering that stays on"
  end
end
