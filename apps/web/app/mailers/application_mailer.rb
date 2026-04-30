class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAIL_FROM", "SentryPact <support@sentrypact.com>")
  layout "mailer"
end
