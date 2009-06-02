class Remindee < ActiveRecord::Base
  belongs_to :mobile_company
  before_create :convert_cellphone_to_integer
  
  validate :cellphone_must_be_10_digits, :ending_month_is_after_starting_month
  #validates_numericality_of :cellphone, :only_integer => true
  validates_uniqueness_of :cellphone
  validates_presence_of :starting_month, :ending_month, :mobile_company_id
  
  def convert_cellphone_to_integer
    self.cellphone = cellphone.gsub(/\D/, "")
  end
  
  def cellphone_must_be_10_digits
    #cellphone2 = cellphone.to_s.gsub(/\D/, "")
    errors.add(:cellphone, "must be 10 digits #{cellphone.class}") unless cellphone.to_s.match(/^\d\d\d\d\d\d\d\d\d\d$/)
  end
  
  def ending_month_is_after_starting_month
    errors.add(:ending_month, "must be after the starting month") if ending_month <= starting_month
  end
  
end
