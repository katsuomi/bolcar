class ReservationsController < ApplicationController
  before_action :authenticate_student!
  before_action :redirect_to_profile_edit, except: :index
  before_action :redirect_if_not_reviewed, only: [:create]

  def index
    @reservations = Reservation.my_reservation(current_student.id)
    @schedules = @reservations.reject{|r| r.schedule.date < Date.today }.map{|r| r.schedule}
    @dates = @schedules.map{|s| s.date }.uniq.sort
  end

  def personal
    @reservation = Schedule.find(params[:schedule_id]).reservations.build(
                    student_id: current_student.id,
                    course: "personal"
                  )
    if @reservation.check_deadline
      redirect_to_schedule(@reservation)
      return
    end
    render "new"
  end

  def group
    @reservation = Schedule.find(params[:schedule_id]).reservations.build(
                    student_id: current_student.id,
                    course: "group"
                  )
    if @reservation.check_deadline
      redirect_to_schedule(@reservation)
      return
    end
    render "new"
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    case params[:course]
      when "personal"
        max = 1
      when "group"
        max = 5
    end
    if @schedule.available?(max)
      @reservation = @schedule.reservations.build(
                      student_id: current_student.id,
                      course: params[:course]
                    )
      if @reservation.save
        ReservationMailer.send_reservation_notification(@schedule.instructor).deliver_later if !@schedule.meeting
        redirect_to instructors_path, notice: "予約が完了しました"
      else
        redirect_to instructors_path, alert: "指定した日時はすでに予約済みです"
      end
    else
      redirect_to instructors_path, alert: "すでに予約が埋まっています"
    end
  end

  private
  def redirect_to_profile_edit
    if current_student.name == nil
      redirect_to edit_student_registration_path, alert: "プロフィール登録をしてください"
    end
  end

  def redirect_to_schedule(reservation)
    redirect_to instructor_path(reservation.schedule.instructor), alert: "予約の締め切り時刻を過ぎています"
  end

end
