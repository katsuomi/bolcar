class InstructorsController < UsersController

  def index
    today_instructor_ids = Schedule.today.map{|s| s.instructor_id }.uniq
    @instructors = Instructor.active.find(today_instructor_ids)
    @date = Date.today
  end

  def show
    redirect_to_profile
    @instructor = Instructor.find(params[:id])
    @schedules = @instructor.schedules.after_today
    @dates = uniq_dates(@schedules)
  end

  def tomorrow
    tomorrow_instructor_ids = Schedule.tomorrow.map{|s| s.instructor_id }.uniq
    @instructors = Instructor.active.find(tomorrow_instructor_ids)
    @date = Date.tomorrow
    render "index"
  end

  private
  def redirect_to_profile
    if current_instructor && !current_instructor.name
      redirect_to edit_instructor_registration_path
    end
  end
end
