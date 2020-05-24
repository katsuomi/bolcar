class AddCompanyToInstructors < ActiveRecord::Migration[5.2]
  def change
    add_column :instructors, :company, :string
    add_column :instructors, :is_public, :boolean
    add_column :instructors, :industry, :string
    add_column :instructors, :occupation, :string
  end
end
