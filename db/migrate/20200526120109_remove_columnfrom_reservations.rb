class RemoveColumnfromReservations < ActiveRecord::Migration[5.2]
  def change
    remove_column :reservations, :service_name, :string
    remove_column :reservations, :servise_id, :string
    remove_column :reservations, :servise_pwd, :string
  end
end
