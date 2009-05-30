class CreateRemindees < ActiveRecord::Migration
  def self.up
    create_table :remindees do |t|
      t.integer :cellphone
      t.integer :mobile_company_id
      t.integer :starting_month
      t.integer :ending_month

      t.timestamps
    end
  end

  def self.down
    drop_table :remindees
  end
end
