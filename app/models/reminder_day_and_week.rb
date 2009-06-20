class ReminderDayAndWeek < ActiveRecord::Base
  belongs_to :remindee
  
  WEEKS_OF_MONTH = %w(first second third fourth)
  
  validates_presence_of :day_of_week, :week_of_month
  
end
