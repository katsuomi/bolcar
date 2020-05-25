class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :schedule, foreign_key: true
      t.string :service_name, null: false
      t.string :service_id
      t.string :service_pwd
      t.timestamps
    end
  end
end
