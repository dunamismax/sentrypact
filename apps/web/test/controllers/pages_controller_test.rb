require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home renders the SentryPact website" do
    get root_url

    assert_response :success
    assert_select "h1", "SentryPact"
    assert_select "title", "SentryPact | Filtering that stays on"
    assert_select "a[href=?]", "mailto:hello@sentrypact.com", minimum: 1
    assert_select "a[href=?]", "#pacts", minimum: 1
    assert_select "a[href=?]", "#pricing", minimum: 1
    assert_includes response.body, "privacy-preserving accountability"
    assert_includes response.body, "not marketed as impossible to bypass"
  end

  test "home sends a content security policy" do
    get root_url

    assert_response :success
    assert_includes response.headers["Content-Security-Policy"], "default-src 'self'"
    assert_includes response.headers["Content-Security-Policy"], "frame-ancestors 'none'"
  end

  test "health check responds" do
    get rails_health_check_url

    assert_response :success
  end
end
