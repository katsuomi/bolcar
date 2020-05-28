class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :meeting, foreign_key: true
      t.text :content, null: false
      t.integer :student_id
      t.integer :instructor_id
      t.timestamps
    end
  end
end
