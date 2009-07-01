class Notifier < ActionMailer::Base
  

  def notify(remindees, alert_period="hour")
    #subject    'Test Reminder'
    recipients  remindees
    #bcc         remindees
    from       'glenn@towminder.com'
    sent_on    Time.now
    
    body       :alert_period => alert_period
  end

end
