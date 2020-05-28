class Meeting < ApplicationRecord
  belongs_to :schedule
  has_many :messages, dependent: :destroy

  validates :service_name, presence: true
  validate :check_start_time


  def instructor
    self.schedule.instructor
  end

  def students
    self.schedule.reservations.map{|r| r.student }
  end

  def course
    self.schedule.reservations.first.course
  end

  private
  def check_start_time
    if Schedule.find(schedule_id).date == Date.today && Schedule.find(schedule_id).start_time < Time.current
      errors.add(:base, "この予約はすでに無効です")
    end
  end
end
