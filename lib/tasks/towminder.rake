namespace :towminder do
  desc "Send out notifications, specify alert period with ALERT_PERIOD=hour|day"
  task(:send_notification_emails => :environment) do
    remindees = Remindee.find_all_by_alert_period(ENV['ALERT_PERIOD'])
    unless remindees.empty? 
      remindee_emails = remindees.map{|remindee| remindee.cellphone + "@" + remindee.mobile_company.email_suffix}
      email = Notifier.deliver_notify(remindee_emails, ENV['ALERT_PERIOD'])
    end
  end
end
