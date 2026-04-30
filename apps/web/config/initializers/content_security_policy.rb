# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.base_uri :self
    policy.connect_src :self
    policy.font_src :self, :https, :data
    policy.form_action :self
    policy.frame_ancestors :none
    policy.img_src :self, :https, :data
    policy.object_src :none
    policy.script_src :self, :https, :unsafe_inline
    policy.style_src :self, :https, :unsafe_inline
    policy.upgrade_insecure_requests if Rails.env.production?
  end
end
