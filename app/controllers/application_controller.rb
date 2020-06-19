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

  def redirect_to_top(notice)
    if current_student
      redirect_to instructors_path, notice: notice
    elsif current_instructor
      redirect_to schedules_path, notice: notice
    end
  end

  def authenticate_user!
    if !student_signed_in? && !instructor_signed_in?
      authenticate_student!
      authenticate_instructor!
    end
  end

  def redirect_to_profile_edit
    if current_student && current_student.name == nil
      redirect_to edit_student_registration_path, alert: "プロフィール登録をしてください"
    elsif current_instructor && current_instructor.name == nil
      redirect_to edit_instructor_registration_path, alert: "プロフィール登録をしてください"
    end
  end

  def redirect_if_not_reviewed
    if current_student && current_student.not_reviewed?
      redirect_to meetings_path, alert: "過去のレビューが残っています"
    elsif current_instructor && current_instructor.not_reviewed?
      redirect_to meetings_path, alert: "過去のレビューが残っています"
    end
  end

  def uniq_dates(schedules)
    return schedules.map{|s| s.date }.uniq.sort
  end

end
