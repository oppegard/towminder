class CreateRemindees < ActiveRecord::Migration
  def self.up
    create_table :remindees do |t|
      t.integer :cellphone, :null => false
      t.integer :mobile_company_id, :null => false
      t.integer :starting_month, :null => false
      t.integer :ending_month, :null => false
      t.string  :at, :null => false

      t.timestamps
    end
    
    add_index :remindees, :cellphone, :unique => true
    add_index :remindees, :at
    add_index :remindees, :starting_month
    add_index :remindees, :ending_month
  end

  def self.down
    drop_table :remindees
  end
end
