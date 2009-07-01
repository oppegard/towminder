class Notifier < ActionMailer::Base
  

  def notify(remindee_emails, alert_period="hour")
    recipients  'glenn@towminder.com'
    bcc         remindee_emails
    from       'glenn@towminder.com'
    sent_on    Time.now
    body       :alert_period => alert_period
  end

end
