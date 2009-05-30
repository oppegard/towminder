class CreateMobileCompanies < ActiveRecord::Migration
  def self.up
    create_table :mobile_companies do |t|
      t.string :name
      t.string :email_suffix

      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_companies
  end
end
