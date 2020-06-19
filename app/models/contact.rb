class Contact < ApplicationRecord
  validates :content, presence: true

  def student
    Student.find_by(id: self.student_id)
  end

  def instructor
    Instructor.find_by(id: self.instructor_id)
  end
end
