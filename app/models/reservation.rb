class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :student

  scope :my_reservation, ->(id) {where(student_id: id)}
end
