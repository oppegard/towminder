class ReminderDayAndWeek < ActiveRecord::Base
  belongs_to :remindee
  
  WEEKS_OF_MONTH = %w(first second third fourth)
  
  validates_presence_of :day_of_week, :week_of_month
  before_save :sanitize_week_and_month
  
  private
  
  def sanitize_week_and_month
    self.day_of_week.downcase!
    self.week_of_month.downcase!
  end
  
end
