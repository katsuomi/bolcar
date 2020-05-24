class Schedule < ApplicationRecord
  belongs_to :instructor
  has_many :reservations

  validates :date, presence: true
  validates :start_time, presence: true, uniqueness: { scope: :date, message: "が既存のシフトと重複しています" }
  validate :date_not_before_today

  default_scope {where("date >= ?", Date.today).order(:date, :start_time)}

  scope :dates, -> {select(:date).distinct.order(:date)}
  scope :today, -> {where(date: Date.today)}
  scope :tomorrow, -> {where(date: Date.tomorrow)}

  def available?(max)
    self.reservations.count < max
  end

  private
  def date_not_before_today
    errors.add(:date, "は今日以降のものを選択してください") if date < Date.today
  end

end
