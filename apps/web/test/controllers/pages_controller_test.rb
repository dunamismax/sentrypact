require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  PUBLIC_PATHS = {
    home:     "/",
    overview: "/overview",
    pacts:    "/pacts",
    privacy:  "/privacy",
    safety:   "/safety",
    pricing:  "/pricing",
    faq:      "/faq",
    support:  "/support"
  }.freeze

  PRIMARY_NAV_PATHS = %w[/overview /pacts /privacy /safety /pricing].freeze

  test "every public route returns success" do
    PUBLIC_PATHS.each do |name, path|
      get path
      assert_response :success, "expected #{path} (#{name}) to return 200"
    end
  end

  test "every public route includes the durable layout chrome" do
    PUBLIC_PATHS.each_value do |path|
      get path

      assert_select "header.site-header"
      assert_select "footer.site-footer"
      assert_select ".status-bar__pill", text: /Pre-launch/i,
        message: "expected pre-launch status pill on #{path}"
      assert_select ".footer-disclaimer",
        text: /not marketed as impossible to bypass/i,
        message: "expected avoided-claims disclaimer on #{path}"

      PRIMARY_NAV_PATHS.each do |nav_path|
        assert_select "header.site-header a[href=?]", nav_path, minimum: 1,
          message: "expected primary nav link to #{nav_path} on #{path}"
      end
    end
  end

  test "home renders the SentryPact landing page" do
    get root_url

    assert_response :success
    assert_select "h1", "Filtering that stays on when willpower does not."
    assert_select "title", "SentryPact | Filtering that stays on"
    assert_select "a[href=?]", "mailto:hello@sentrypact.com", minimum: 1
    assert_select "a[href=?]", pacts_path, minimum: 1
    assert_select "a[href=?]", pricing_path, minimum: 1
    assert_includes response.body, "privacy-preserving accountability"
    assert_includes response.body, "Tamper-resistant and bypass-detecting"
    assert_includes response.body, "Not marketed as impossible to bypass"
  end

  test "overview describes architecture and avoided claims" do
    get overview_url

    assert_response :success
    assert_select "h1", "Filtering you cannot impulsively switch off."
    assert_includes response.body, "Native enforcement, Rails control plane"
    assert_includes response.body, "Claims we will not make"
    assert_includes response.body, "Impossible to bypass"
    assert_includes response.body, "Addiction cure"
    assert_includes response.body, "Guaranteed protection"
    assert_includes response.body, "Secret monitoring"
  end

  test "pacts page explains lifecycle and release paths" do
    get pacts_url

    assert_response :success
    assert_select "h1", "A pact is a voluntary lock with a release time."
    assert_includes response.body, "Server-verified"
    assert_includes response.body, "Configure"
    assert_includes response.body, "Lock"
    assert_includes response.body, "Release"
    assert_includes response.body, "cooling-off"
    assert_includes response.body, "Tamper handling"
  end

  test "privacy page documents default collection and opt-in" do
    get privacy_url

    assert_response :success
    assert_select "h1", "Collect less. Explain everything."
    assert_includes response.body, "Raw browsing history"
    assert_includes response.body, "opt-in"
    assert_includes response.body, "No stealth mode"
    assert_includes response.body, "category counts"
  end

  test "safety page documents coercive control and emergency release" do
    get safety_url

    assert_response :success
    assert_select "h1", "Lockdown cannot become a weapon."
    assert_includes response.body, "coercive control"
    assert_includes response.body, "Emergency release"
    assert_includes response.body, "Abuse, harassment"
    assert_includes response.body, "audit trail"
    assert_includes response.body, "No stealth, no surveillance"
  end

  test "pricing page lists every plan and is clearly pre-launch" do
    get pricing_url

    assert_response :success
    assert_select "h1", "A paid plan centered on Solo Pact."
    [ "Free", "Solo Pact", "Pact Plus", "Family" ].each do |plan|
      assert_includes response.body, plan
    end
    assert_includes response.body, "pre-launch"
    assert_includes response.body, "Pricing locks in before launch"
  end

  test "faq page surfaces avoided-claims questions" do
    get faq_url

    assert_response :success
    assert_select "h1", "Questions worth asking before you trust a blocker."
    assert_includes response.body, "Is SentryPact impossible to bypass?"
    assert_includes response.body, "Is SentryPact a treatment for addiction?"
    assert_includes response.body, "Can a partner secretly install or monitor me?"
  end

  test "support page lists every contact route" do
    get support_url

    assert_response :success
    assert_select "h1", "Talk to a real person."
    %w[hello support privacy security press].each do |mailbox|
      assert_includes response.body, "#{mailbox}@sentrypact.com"
    end
    assert_includes response.body, "Safety reports"
  end

  test "primary nav marks the current page" do
    get pacts_url
    assert_select "header.site-header a[href=?].is-current", pacts_path, minimum: 1

    get privacy_url
    assert_select "header.site-header a[href=?].is-current", privacy_path, minimum: 1
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
