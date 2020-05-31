class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :meeting, foreign_key: true
      t.integer :student_id
      t.integer :instructor_id
      t.text :content, null: false
      t.string :safety, null: false
      t.timestamps
    end
  end
end
