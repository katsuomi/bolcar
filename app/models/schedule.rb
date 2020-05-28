class Schedule < ApplicationRecord
  belongs_to :instructor
  has_many :reservations, dependent: :destroy
  has_one :meeting, dependent: :destroy

  validates :date, presence: true
  validates :start_time, presence: true, uniqueness: { scope: [:date, :instructor_id], message: "が既存のシフトと重複しています" }
  validate :date_not_before_today, :check_start_time

  default_scope {where("date >= ?", Date.today).order(:date, :start_time)}

  scope :today, -> {where(date: Date.today)}
  scope :tomorrow, -> {where(date: Date.tomorrow)}

  def available?(max)
    self.reservations.count < max
  end

  private
  def date_not_before_today
    errors.add(:date, "は今日以降のものを選択してください") if date < Date.today
  end

  def check_start_time
    errors.add(:start_time, "は3時間後以降を選択してください") if date == Date.today && start_time < Time.current.since(3.hours)
  end

end
