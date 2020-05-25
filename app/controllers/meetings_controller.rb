class MeetingsController < ApplicationController
  before_action :authenticate_instructor!, except: :index
  before_action :authenticate_user!

  def index
    if current_student
      @schedules = current_student.reservations.map{|r| r.schedule }
      @meetings = @schedules.select{|s| s.meeting }.map{|s| s.meeting }
    else
      @schedules = current_instructor.schedules
      @meetings = @schedules.select{|s| s.meeting }.map{|s| s.meeting }
    end
  end

  def new
    @schedule = Schedule.find(params[:schedule_id])
    @student = @schedule.reservations.first.student
    @course = @schedule.reservations.first.course
    @meeting = @schedule.build_meeting
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

end
