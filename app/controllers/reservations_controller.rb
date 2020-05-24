class ReservationsController < ApplicationController
  before_action :authenticate_student!
  before_action :redirect_to_profile_edit, except: :index

  def index
    @reservations = Reservation.my_reservation(current_student.id)
    schedules_id = @reservations.map{|r| r.schedule.id }
    @schedules = Schedule.find(schedules_id)
    @dates = @schedules.map{|s| s.date }.uniq
  end

  def personal
    @reservation = Schedule.find(params[:schedule_id]).reservations.build(
                    student_id: current_student.id,
                    course: "personal"
                  )
    render "new"
  end

  def group
    @reservation = Schedule.find(params[:schedule_id]).reservations.build(
                    student_id: current_student.id,
                    course: "group"
                  )
    render "new"
  end

  def create
    @schedule = Schedule.find(params[:schedule_id])
    if @schedule.available?(1)
      @reservation = @schedule.reservations.build(
                      student_id: current_student.id,
                      course: params[:course]
                    )
      @reservation.save
      redirect_to instructors_path, notice: "予約が完了しました"
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
end
