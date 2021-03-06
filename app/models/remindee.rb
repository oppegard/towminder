class Remindee < ActiveRecord::Base
  belongs_to :mobile_company
  has_many :reminder_day_and_weeks, :dependent => :destroy
  before_validation :sanitize_cellphone
  before_save :remove_duplicate_rdaws
  
  accepts_nested_attributes_for :reminder_day_and_weeks, :allow_destroy => true
  
  AT_TIMES = [
    ["An hour before street sweeping starts", "hour"],
    ["The evening before street sweeping starts", "day"],
    ["Both the evening before and an hour before", "both"]
  ]
  
  validate :cellphone_must_be_10_digits, :ending_month_is_after_starting_month
  validates_uniqueness_of :cellphone, :message => "is already in the Towminder system"
  validates_presence_of :cellphone, :starting_month, :ending_month, :mobile_company_id, :at
  validates_inclusion_of :at, :in => AT_TIMES.map {|dispay, value| value}
  
  def self.find_all_by_alert_period(alert_period="hour")
    lookup_day, lookup_week = nil
    # By default we look for remindees that want to be notified the day of towing
    lookup_date = Date.today
    # Otherwise, we look for remindees that want to be notified the day before
    lookup_date += 1 if alert_period == "day"
    
    lookup_day = Date::DAYNAMES[lookup_date.wday].downcase
 
    # Find the ordinal week of the month (first, second, third, fourth) for lookup_date
    ReminderDayAndWeek::WEEKS_OF_MONTH.each do |week|
      # The method call to month below is using the smart_month plugin
      lookup_week = week if lookup_date.to_time.month.send("#{week}_#{lookup_day}") == lookup_date
    end     
    
    return [] if lookup_week.nil?

    
    return self.find(:all, :conditions => 
                        ["starting_month <= ? AND ending_month >= ? 
                          AND reminder_day_and_weeks.week_of_month = ? 
                          AND reminder_day_and_weeks.day_of_week = ?
                          AND (at = ? OR at = ?)", 
                          lookup_date.month, lookup_date.month,
                          lookup_week,
                          lookup_day,
                          "both", alert_period], 
                        :include => [:mobile_company, :reminder_day_and_weeks])
  end
  
  
  private
  
  def uniq_with_block (array)
    return array.uniq unless block_given?
    aggregator = {}
    array.each do |element|
      aggregator[yield(element)] ||= element
    end
    aggregator.values
  end
  
  def remove_duplicate_rdaws
    self.reminder_day_and_weeks = uniq_with_block(self.reminder_day_and_weeks) {|a| a[:week_of_month] + a[:day_of_week]}
  end
  
  def cellphone_must_be_10_digits
    errors.add(:cellphone, "must be 10 digits") unless cellphone.match(/^\d\d\d\d\d\d\d\d\d\d$/)
  end
  
  def ending_month_is_after_starting_month
    errors.add(:ending_month, "must be after the starting month") if ending_month <= starting_month
  end
  
  def sanitize_cellphone
    # Strip out any character that isn't a digit
    self.cellphone = cellphone.gsub(/\D/, "")
  end
  
  def reminder_day_and_weeks_uniqueness
    all_unique = true
    self.reminder_day_and_weeks.each do |rdaw|
      temp_ary = self.reminder_day_and_weeks.find_all do |comp|
        rdaw.day_of_week == comp.day_of_week && rdaw.week_of_month == comp.week_of_month
      end
      all_unique = false if temp_ary.length > 1
    end
    errors.add_to_base("Each day and week of month must be unique") if all_unique == false
  end
  
end
