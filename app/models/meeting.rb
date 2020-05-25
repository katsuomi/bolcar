class Meeting < ApplicationRecord
  belongs_to :schedule

  validates :service_name, presence: true
end
