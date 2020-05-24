class ChangeSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :datetime
    add_column :schedules, :date, :date
    add_column :schedules, :start_time, :time
  end
end
