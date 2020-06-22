class MeetingsController < ApplicationController
  before_action :authenticate_instructor!, except: [:index, :show]
  before_action :authenticate_user!

  def index
    if current_student
      @meetings = current_student.meetings.select{|m| !m.reviewed(current_student)}
    else
      @meetings = current_instructor.meetings.select{|m| !m.reviewed(current_instructor)}
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    @messages = @meeting.messages
    @message = @meeting.messages.build(student_id: current_student.id) if current_student
    @message = @meeting.messages.build(instructor_id: current_instructor.id) if current_instructor
    redirect_to_schedules
  end

  def new
    @schedule = Schedule.find(params[:schedule_id])
    @student = @schedule.reservations.first.student
    @course = @schedule.reservations.first.course
    @meeting = @schedule.build_meeting
    redirect_to_schedules
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    @student = @schedule.reservations.first.student
    @course = @schedule.reservations.first.course
    @meeting = @schedule.build_meeting(meeting_params)
    if @meeting.save
      ReservationMailer.send_meeting_notification(@schedule, @student).deliver_later
      redirect_to schedules_path, notice: "フォームを送信しました"
    else
      render "new"
    end
  end

  private
  def meeting_params
    params.require(:meeting).permit(:service_name, :service_id, :service_pwd)
  end

  def redirect_to_schedules
    if !@meeting.schedule
      redirect_to meetings_path, alert: "この面談はすでに終了しています"
    elsif @meeting.instructor != current_instructor && !@meeting.students.find{|s| s == current_student}
      redirect_to meetings_path, alert: "不正なアクセスです"
    end
  end

end
