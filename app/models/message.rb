class Message < ApplicationRecord
  belongs_to :meeting

  validates :content, presence: true, length: {maximum: 200}
  validate :exist_sender

  def sender
    if self.student_id
      Student.find(self.student_id)
    else
      Instructor.find(self.instructor_id)
    end
  end

  private
  def exist_sender
    if student_id && instructor_id || !student_id && !instructor_id
      errors.add(:base, "エラーが発生しました")
    end
  end
end
