class AddStatusToInstructors < ActiveRecord::Migration[5.2]
  def change
    add_column :instructors, :status, :string
  end
end
