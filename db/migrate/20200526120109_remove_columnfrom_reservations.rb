class RemoveColumnfromReservations < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :service_name
    remove_column :reservations, :service_id
    remove_column :reservations, :service_pwd
  end
end
