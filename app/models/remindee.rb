class Remindee < ActiveRecord::Base
  belongs_to :mobile_company
  has_many :reminder_day_and_weeks, :dependent => :destroy
  before_validation :sanitize_cellphone
  
  accepts_nested_attributes_for :reminder_day_and_weeks, :allow_destroy => true
  
  AT_TIMES = [
    ["An hour before street sweeping starts", "hour"],
    ["The evening before street sweeping starts", "day"],
    ["Both the evening before and an hour before", "both"]
  ]
  
  validate :cellphone_must_be_10_digits, :ending_month_is_after_starting_month
  validates_numericality_of :cellphone, :only_integer => true
  validates_uniqueness_of :cellphone, :message => "number is already in our system"
  validates_presence_of :cellphone, :starting_month, :ending_month, :mobile_company_id, :at
  validates_inclusion_of :at, :in => AT_TIMES.map {|disp, value| value}
  
  def self.find_all_by_alert_period(alert_period="hour")
    lookup_day, lookup_week = nil
    lookup_date = Date.today
    if alert_period == "day" then
      lookup_date += 1
    end
    
    lookup_day = Date::DAYNAMES[lookup_date.wday].downcase
 
    ReminderDayAndWeek::WEEKS_OF_MONTH.each do |week|
      if lookup_date.to_time.month.send("#{week}_#{lookup_day}") == lookup_date
        lookup_week = week
        # p "Lookup date is the #{week} #{lookup_day} of #{Date::MONTHNAMES[lookup_date.month]}."
      end
    end     
    
    if (lookup_week.nil?) then
      return []
    end
    
    return self.find(:all, :conditions => 
                        ["starting_month <= ? AND ending_month >= ? 
                          AND reminder_day_and_weeks.week_of_month = ? 
                          AND reminder_day_and_weeks.day_of_week = ?
                          AND (at = ? OR at = ?)", 
                          lookup_date.month, lookup_date.month,
                          lookup_week, lookup_day,
                          "both", alert_period], 
                        :include => [:mobile_company, :reminder_day_and_weeks])
    
  end
  
  def cellphone_must_be_10_digits
    errors.add(:cellphone, "must be 10 digits") unless cellphone.to_s.match(/^\d\d\d\d\d\d\d\d\d\d$/)
  end
  
  def ending_month_is_after_starting_month
    errors.add(:ending_month, "must be after the starting month") if ending_month <= starting_month
  end
  
  def sanitize_cellphone
     self.cellphone = cellphone.to_s.gsub(/\D/, "").to_i
  end
  
end
