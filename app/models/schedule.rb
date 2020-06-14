class Schedule < ApplicationRecord
  belongs_to :instructor
  has_many :reservations, dependent: :destroy
  has_one :meeting, dependent: :destroy

  validates :date, presence: true
  validates :start_time, presence: true, uniqueness: { scope: [:date, :instructor_id], message: "が既存のシフトと重複しています" }
  validate :date_not_before_today, :check_start_time

  default_scope {order(:date, :start_time)}

  scope :after_today, -> {where("date >= ?", Date.today)}
  scope :today, -> {where(date: Date.today)}
  scope :tomorrow, -> {where(date: Date.tomorrow)}

  def available?(course)
    case course
      when "personal"
        max = 1
      when "group"
        max = 5
    end
    self.reservations.count < max
  end

  def compare_start_time(dif)
    self.start_time.strftime("%-H%M").to_i < Time.current.strftime("%-H%M").to_i + dif
  end

  def later_than_current_date
    self.date < Date.today || self.date == Date.today && self.compare_start_time(0)
  end

  private
  def date_not_before_today
    errors.add(:date, "は今日以降のものを選択してください") if date < Date.today
  end

  def check_start_time
    errors.add(:start_time, "は3時間後以降を選択してください") if date == Date.today && start_time < Time.current.since(3.hours)
  end

end
