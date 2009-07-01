class CreateReminderDayAndWeeks < ActiveRecord::Migration
  def self.up
    create_table :reminder_day_and_weeks do |t|
      t.string :week_of_month, :null => false
      t.string :day_of_week, :null => false
      t.integer :remindee_id, :null => false

      t.timestamps
    end
    
    add_index :reminder_day_and_weeks, [:day_of_week, :week_of_month], :name => 'idx_rdaw_dow_wom'
    add_index :reminder_day_and_weeks, [:day_of_week, :week_of_month, :remindee_id], :unique => true, :name => 'idx_rdaw_dow_wom_rid'
  end

  def self.down
    drop_table :reminder_day_and_weeks
  end
end
