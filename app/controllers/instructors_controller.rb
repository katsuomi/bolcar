class InstructorsController < UsersController
  def index
    today_instructors = Schedule.today.map{|s| s.instructor_id }.uniq
    @instructors = Instructor.active.find(today_instructors)
    @date = Date.today
  end

  def show
    if current_instructor && !current_instructor.name
      redirect_to edit_instructor_registration_path
    end
    @instructor = Instructor.find(params[:id])
    @schedules = @instructor.schedules.order(:date, :start_time)
    @dates = @schedules.dates
  end

  def tomorrow
    tomorrow_instructors = Schedule.tomorrow.map{|s| s.instructor_id }.uniq
    @instructors = Instructor.active.find(tomorrow_instructors)
    @date = Date.tomorrow
    render "index"
  end
end
