class Meeting < ApplicationRecord
  belongs_to :schedule
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :service_name, presence: true
  validate :check_start_time

  def instructor_reviewed(id)
    self.reviews.find{|r| r.instructor_id == id}
  end

  def student_reviewed(id)
    self.reviews.find{|r| r.student_id == id}
  end

  def finished?
    self.schedule.date < Date.today || (self.schedule.date == Date.today && self.schedule.start_time.strftime("%-H%M").to_i < Time.current.strftime("%-H%M").to_i + 30)
  end

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
    if Schedule.find(schedule_id).date == Date.today && Schedule.find(schedule_id).start_time.strftime("%H%M") < Time.current.strftime("%H%M")
      errors.add(:base, "この予約はすでに無効です")
    end
  end
end
