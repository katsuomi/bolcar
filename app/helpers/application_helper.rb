module ApplicationHelper
  def meetings_count
    if current_student
      current_student&.meetings&.select{|m| !m&.reviewed(current_student)}.size
    else
      current_instructor&.meetings&.select{|m| !m&.reviewed(current_instructor)}.size
    end
  end
end
