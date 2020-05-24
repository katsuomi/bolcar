class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :schedules, foreign_key: true
      t.references :students, foreign_key: true
      t.string :course, null: false
      t.string :service_name, null: false
      t.string :servise_id
      t.string :servise_pwd   
      t.timestamps
    end
  end
end
