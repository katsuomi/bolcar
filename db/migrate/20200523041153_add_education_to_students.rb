class AddEducationToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :school, :string
    add_column :students, :faculty, :string
    add_column :students, :is_public, :boolean
    add_column :students, :graduation_year, :string
  end
end
