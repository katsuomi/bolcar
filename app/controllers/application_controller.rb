class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.class == Student
      instructors_path
    elsif resource.class == Instructor
      new_schedule_path
    end
  end

  def authenticate_user!
    if !student_signed_in? && !instructor_signed_in?
      authenticate_student!
      authenticate_instructor!
    end
  end

  def available_schedule(schedules)
    return schedules.select{|s| s }
  end

end
