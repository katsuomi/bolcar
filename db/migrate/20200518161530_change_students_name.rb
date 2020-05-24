class ChangeStudentsName < ActiveRecord::Migration[5.2]
  def up
    change_column :students, :name,:string, null: true
  end

  def down
    change_column :students, :name,:string, null: false
  end
end
