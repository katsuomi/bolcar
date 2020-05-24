class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :icon
  has_many :schedules

  validates :name, presence: true, length: {maximum: 20}, on: :update
  validates :age, presence: true, on: :update
  validates :profile, presence: true, length: {maximum: 300}, on: :update
  validates :status, presence: true, on: :update
  validates :industry, presence: true, on: :update
  validates :occupation, presence: true, on: :update

  scope :active, -> {where.not(name: nil)}
end
