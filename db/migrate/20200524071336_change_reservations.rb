class ChangeReservations < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reservations, :students
    add_reference :reservations, :student, foreign_key: true
    remove_reference :reservations, :schedules
    add_reference :reservations, :schedule, foreign_key: true
  end
end
