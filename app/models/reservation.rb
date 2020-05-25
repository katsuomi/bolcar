class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :student

  scope :my_reservation, ->(id) {where(student_id: id)}

  validates :student_id, presence: true, uniqueness: { scope: :schedule_id }

  def check_deadline
    self.schedule.date < Date.today || (self.schedule.date == Date.today && self.schedule.start_time.strftime("%H%M") < Time.current.since(3.hours).strftime("%H%M"))
  end
end
