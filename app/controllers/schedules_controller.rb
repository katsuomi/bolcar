class SchedulesController < ApplicationController
  before_action :authenticate_instructor!, except: [:show, :courses]

  def index
    @schedules = current_instructor.schedules
    @dates = @schedules.map{|s| s.date }.uniq
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def new
    @schedule = current_instructor.schedules.build
  end

  def create
    @schedule = current_instructor.schedules.build(schedule_params)
    if @schedule.save
      redirect_to schedules_path
    else
      render "new"
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to schedules_path
  end


  private
  def schedule_params
    params.require(:schedule).permit(:date, :start_time)
  end
end
