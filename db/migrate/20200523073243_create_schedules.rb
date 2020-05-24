class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :instructor, foreign_key: true
      t.datetime :datetime, null: false
      t.timestamps
    end
  end
end
