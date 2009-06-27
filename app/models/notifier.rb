class Notifier < ActionMailer::Base
  

  def notify(remindees)
    subject    'Test Reminder'
    recipients 'glenn@towminder.com'
    bcc         remindees
    from       'glenn@towminder.com'
    sent_on    Time.now
    
    body       :greeting => 'Hi,'
  end

end
