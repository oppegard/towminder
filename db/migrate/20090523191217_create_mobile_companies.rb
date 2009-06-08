class CreateMobileCompanies < ActiveRecord::Migration
  def self.up
    create_table :mobile_companies do |t|
      t.string :name, :null => false
      t.string :email_suffix, :null => false

      t.timestamps
    end
    
    add_index :mobile_companies, :name, :unique => true
    
    MobileCompany.create(:name => "AT&T Wireless", :email_suffix => "txt.att.net")
    MobileCompany.create(:name => "Cricket", :email_suffix => "sms.mycricket.com")
    MobileCompany.create(:name => "Sprint", :email_suffix => "messaging.sprintpcs.com")
    MobileCompany.create(:name => "T-Mobile", :email_suffix => "tmomail.net")
    MobileCompany.create(:name => "Verizon", :email_suffix => "vtext.com")
    MobileCompany.create(:name => "Virgin Mobile", :email_suffix => "vmobl.com")
  end

  def self.down
    drop_table :mobile_companies
  end
end
