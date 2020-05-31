class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.class == Student
      instructors_path
    elsif resource.class == Instructor
      schedules_path
    end
  end

  def authenticate_user!
    if !student_signed_in? && !instructor_signed_in?
      authenticate_student!
      authenticate_instructor!
    end
  end

  def redirect_if_not_reviewed
    if current_student && current_student.not_reviewed?
      redirect_to meetings_path, alert: "過去のレビューが残っています"
    elsif current_instructor && current_instructor.not_reviewed?
      redirect_to meetings_path, alert: "過去のレビューが残っています"
    end    
  end

  def available_schedule(schedules)
    return schedules.select{|s| s }
  end

end
