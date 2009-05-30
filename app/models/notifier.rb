class Notifier < ActionMailer::Base
  

  def notify(remindees)
    subject    'Test Reminder'
    recipients remindees
    from       'renmind@towminder.com'
    sent_on    Time.now
    
    body       :greeting => 'Hi,'
  end

end
