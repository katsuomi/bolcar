class ChangeReservation < ActiveRecord::Migration[5.2]
  def up
    change_column :reservations, :service_name ,:string, null: true
  end

  def down
    change_column :reservations, :service_name,:string, null: false
  end
end
