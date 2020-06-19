class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :icon
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}, on: :update
  validates :profile, presence: true, length: {maximum: 300}, on: :update
  validates :graduation_year, presence: true, on: :update

  scope :active, -> {where.not(name: nil)}

  def meetings
    self.reservations.select{|r| r.schedule&.meeting }.map{|r| r.schedule.meeting}
  end

  def not_reviewed?
    meetings = self.meetings.select{|m| m.schedule.previous?}
    return meetings.select{|m| m.reviews.find{|r| r.student_id == self.id } }.count != meetings.count
  end

end
