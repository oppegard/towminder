class Remindee < ActiveRecord::Base
  belongs_to :mobile_company
  has_many :reminder_day_and_weeks
  
  accepts_nested_attributes_for :reminder_day_and_weeks, :allow_destroy => true
  
  AT_TIMES = [
    ["An hour before", "hour"],
    ["The evening before", "day"],
    ["Both", "both"]
  ]
  
  validate :cellphone_must_be_10_digits, :ending_month_is_after_starting_month
  validates_numericality_of :cellphone, :only_integer => true
  validates_uniqueness_of :cellphone, :message => "number is already in our system"
  validates_presence_of :cellphone, :starting_month, :ending_month, :mobile_company_id, :at
  validates_inclusion_of :at, :in => AT_TIMES.map {|disp, value| value}
  
  def cellphone_must_be_10_digits
    #cellphone2 = cellphone.to_s.gsub(/\D/, "")
    errors.add(:cellphone, "must be 10 digits") unless cellphone.to_s.match(/^\d\d\d\d\d\d\d\d\d\d$/)
  end
  
  def ending_month_is_after_starting_month
    errors.add(:ending_month, "must be after the starting month") if ending_month <= starting_month
  end
  
end
