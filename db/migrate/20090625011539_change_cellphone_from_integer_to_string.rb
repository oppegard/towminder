class ChangeCellphoneFromIntegerToString < ActiveRecord::Migration
  def self.up
    change_column :remindees, :cellphone, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
