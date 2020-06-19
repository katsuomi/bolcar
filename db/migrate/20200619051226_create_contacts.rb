class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :student_id
      t.integer :instructor_id
      t.text :content, null: false
      t.timestamps
    end
  end
end
