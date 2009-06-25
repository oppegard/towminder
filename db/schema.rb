# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090625011539) do

  create_table "mobile_companies", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "email_suffix", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mobile_companies", ["name"], :name => "index_mobile_companies_on_name", :unique => true

  create_table "remindees", :force => true do |t|
    t.string   "cellphone",         :null => false
    t.integer  "mobile_company_id", :null => false
    t.integer  "starting_month",    :null => false
    t.integer  "ending_month",      :null => false
    t.string   "at",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remindees", ["at"], :name => "index_remindees_on_at"
  add_index "remindees", ["cellphone"], :name => "index_remindees_on_cellphone", :unique => true
  add_index "remindees", ["ending_month"], :name => "index_remindees_on_ending_month"
  add_index "remindees", ["starting_month"], :name => "index_remindees_on_starting_month"

  create_table "reminder_day_and_weeks", :force => true do |t|
    t.string   "week_of_month", :null => false
    t.string   "day_of_week",   :null => false
    t.integer  "remindee_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reminder_day_and_weeks", ["day_of_week", "week_of_month", "remindee_id"], :name => "index_reminder_day_and_weeks_on_day_of_week_and_week_of_month_and_remindee_id", :unique => true
  add_index "reminder_day_and_weeks", ["day_of_week", "week_of_month"], :name => "index_reminder_day_and_weeks_on_day_of_week_and_week_of_month"

end
