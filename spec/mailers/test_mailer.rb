class TestMailer < ActionMailer::Base
  def email(options)
    recipients options[:to]
    cc         options[:cc]
    bcc        options[:bcc]
    from       'test@emailblacklist.org'
    subject    "Email test"
    body       "Here is the message body."
  end
end