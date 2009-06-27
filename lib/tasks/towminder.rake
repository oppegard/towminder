namespace :towminder do
  desc "Send out notifications, specify alert period with ALERT_PERIOD=hour|day"
  task(:send_notification_emails => :environment) do
    p Remindee.find_all_by_alert_period(ENV['ALERT_PERIOD'])
  end
end
