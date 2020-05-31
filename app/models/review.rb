class Review < ApplicationRecord
  belongs_to :meeting

  validates :safety, presence: true
  validates :content, presence: true, length: {maximum: 300}
end
