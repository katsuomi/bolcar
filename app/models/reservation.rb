class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :student

  scope :my_reservation, ->(id) {where(student_id: id)}

  validates :student_id, presence: true, uniqueness: { scope: :schedule_id }
  validate :check_double_booking

  def check_deadline
    self.schedule.date < Date.today || self.schedule.date == Date.today && self.schedule.start_time.strftime("%-H%M").to_i < Time.current.strftime("%-H%M").to_i + 300
  end

  private
  def check_double_booking
     if Student.find(student_id).reservations.find{|r| r.schedule&.date == Schedule.find(schedule_id).date && r.schedule&.start_time == Schedule.find(schedule_id).start_time }
       errors.add(:base, "")
     end
  end
end
