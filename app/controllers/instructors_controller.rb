class InstructorsController < UsersController
  def index
    today_instructors = Schedule.today
    instructors_id = today_instructors.map {|i| i.instructor_id }
    @instructors = Instructor.active.find(instructors_id)
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
    today_instructors = Schedule.tomorrow
    instructors_id = today_instructors.map {|i| i.instructor_id }
    @instructors = Instructor.active.find(instructors_id)
    @date = Date.tomorrow
    render "index"
  end
end
