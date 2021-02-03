class ApplicationMailer < ActionMailer::Base
  default from: 'postmaster@mailgun.org'
  layout 'mailer'
end
