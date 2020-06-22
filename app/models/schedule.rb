class Schedule < ApplicationRecord
  belongs_to :instructor
  has_many :reservations, dependent: :destroy
  has_one :meeting, dependent: :destroy

  validates :date, presence: true
  validates :start_time, presence: true, uniqueness: { scope: [:date, :instructor_id], message: "が既存のシフトと重複しています" }
  validate :is_before_deadline

  default_scope {order(:date, :start_time)}

  scope :after_today, -> {where("date >= ?", Date.today)}
  scope :today, -> {where(date: Date.today)}
  scope :tomorrow, -> {where(date: Date.tomorrow)}

  def self.without_personal_reservation
    after_today.reject{|s| s.reservations&.first&.course == "personal" }
  end

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

  def previous?
    self.date < Date.today || self.date == Date.today && self.compare_start_time(0)
  end

  private
  def is_before_deadline
    if date < Date.today || date == Date.today && compare_start_time(300)
      errors.add(:base, "日時は今から3時間後以降を選択してください")
    end
  end
end
